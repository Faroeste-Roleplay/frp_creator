Game.Scene = {}
Game.Scene.lineupPedMap = {}
Game.Scene.iplsLoaded = {}

Game.Scene.Start = function(arguments)
    Game.Player.SetPlayerPosition(vec3(-555.162, -3777.914, 35.29764))
end

Game.Scene.LoadIpls = function()
    local iplsData = Config.Ipls

    if not iplsData then
        return
    end

    for _, ipl in pairs(iplsData) do 
        RequestImap(ipl);

        table.insert(Game.Scene.iplsLoaded, ipl)
    end
end

LightRendererLightInfoArray = {
    {-561.860, -3776.757, 238.590, 10.000, 50.000},
    {-559.590, -3780.757, 238.590, 10.000, 50.000}
}

Game.Scene.RendererLight = function()
    for i = 1, #LightRendererLightInfoArray do
        local x, y, z, range, intensity = table.unpack(LightRendererLightInfoArray[i])
        -- print(" RendererLight :: ", x, y, z, 255, 255, 255, range, intensity)
        DrawLightWithRange(x, y, z, 255, 255, 255, range, intensity)
    end
end

Game.Scene.CreateLineupCamera = function(lineupGender)

    if not Game.Scene.lineupCameraMap then
        Game.Scene.lineupCameraMap = {}
    end

    local  lineupGenderStr = lineupGender == eLineupGender.Female and 'female' or 'male';
    local camData = Config.LineupPeds[lineupGenderStr].camera

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false);

    SetCamCoord(cam, camData.x, camData.y, camData.z);
    SetCamRot(cam, camData.pitch, camData.roll, camData.yaw, 2);
    SetCamFov(cam, camData.fov or 35.0);

    N_0x11f32bb61b756732(cam, 4.0) -- SetCamFocusDistance

    Game.Scene.lineupCameraMap[lineupGenderStr] = cam
end

Game.Scene.CreateLineupPeds = function()
    Game.Scene.CreateLineupPed(eLineupGender.Male, GetHashKey("mp_male"))
    Game.Scene.CreateLineupPed(eLineupGender.Female, GetHashKey("mp_female"))
end

Game.Scene.CreateLineupPed = function(lineupGender, pedModelHash)

    if not Game.Scene.lineupPedMap then
        Game.Scene.lineupPedMap = {}
    end

    lib.requestModel(pedModelHash)

    local  lineupGenderStr = lineupGender == eLineupGender.Female and 'female' or 'male';

    local pedConfig = Config.LineupPeds[lineupGenderStr].position

    local pedId = CreatePed(pedModelHash, pedConfig.x, pedConfig.y, pedConfig.z, pedConfig.heading, true, false, false, false);

    while NetworkGetNetworkIdFromEntity(pedId) == 0 do
        Wait(1)
    end 

    TriggerServerEvent('net.personaCreatorHandlerSetRoutingBucket', NetworkGetNetworkIdFromEntity(pedId))

    SetPedRandomComponentVariation(pedId, 1);

    FreezeEntityPosition(pedId, true)
    SetFocusEntity(pedId);

    Game.Scene.lineupPedMap[lineupGenderStr] = pedId;

    Game.Scene.SetPedDefaultOutfit(pedId);
end

Game.Scene.ChangeFocusedLineupGender = function(newFocusedLineupGender)
    local camStr
    local newGender

    if type(newFocusedLineupGender) == "string" then
        camStr = newFocusedLineupGender
        newGender = newFocusedLineupGender == 'female' and 1 or 0
    end

    if type(newFocusedLineupGender) == "number" then
        camStr = newFocusedLineupGender == eLineupGender.Female and 'female' or 'male';
        newGender = newFocusedLineupGender
    end

    local cam = Game.Scene.lineupCameraMap[camStr]

    SetCamActiveWithInterp(cam, GetRenderingCam(), 1200, 1, 1);
    RenderScriptCams(true, false, 3000, true, false, 0);

    Game.Scene.focusedLineupGender = newGender
end

Game.Scene.ChangeFocusedLineupPedWithKeyboardArrow = function(leftDirection)
    -- A Camera do ped ainda tá interpolando, vamos aguardar...

    local  newFocusedLineupGender = Game.Scene.focusedLineupGender == eLineupGender.Female and 'female' or 'male';
    
    if (IsCamInterpolating(Game.Scene.lineupCameraMap[newFocusedLineupGender]) or IsCamInterpolating(GetRenderingCam())) then
        return;
    end

    PlaySoundFrontend(leftDirection and 'gender_left' or 'gender_right', 'RDRO_Character_Creator_Sounds', true, 0);

    Game.Scene.ChangeFocusedLineupGender(leftDirection and 'male' or 'female');
end

Game.Scene.CreateInputHandlers = function()

    local onRightArrowPressed = Game.Inputs.On('OnPressed', eIoContextType.KeyboardRightArrow, function()
        if Game.state == ePersonaCreationState.Selecting then
            Game.Scene.ChangeFocusedLineupPedWithKeyboardArrow(false)
        elseif Game.state == ePersonaCreationState.Customizing then
            Game.Scene.RotateCustomizationPed(false);
        end
    end)


    local onLeftArrowPressed = Game.Inputs.On('OnPressed', eIoContextType.KeyboardLeftArrow, function()
        if Game.state == ePersonaCreationState.Selecting then
            Game.Scene.ChangeFocusedLineupPedWithKeyboardArrow(true)
        elseif Game.state == ePersonaCreationState.Customizing then
            Game.Scene.RotateCustomizationPed(false);
        end
    end)


    local onEnterPressed = Game.Inputs.On('OnPressed', eIoContextType.KeyboardEnter, function()
        -- Não estamos no estado de seleção, ignorar.
        if Game.state ~= ePersonaCreationState.Selecting then
            return 
        end

        local focusedLineupGender = Game.Scene.focusedLineupGender
        -- print(" focusedLineupGender :: ", focusedLineupGender)

        -- Nenhum dos lineupPeds estão focados/selecionados, ignorar.
        if focusedLineupGender == nil then
            return
        end

        local  eLineupGenderStr = focusedLineupGender == eLineupGender.Female and 'female' or 'male';
        local ped = Game.Scene.lineupPedMap[eLineupGenderStr];

        -- print(" ped :: ", ped)

        Game.State = ePersonaCreationState.Transitioning;

        Game.Scene.CreateStartToCustomizationTransition(ped)
    end)

    -- onRightArrowPressed()
    -- onLeftArrowPressed()
    -- onEnterPressed()

    return { onRightArrowPressed, onLeftArrowPressed, onEnterPressed}
end

Game.Scene.CreateStartToCustomizationTransition = function(ped)
    local animScene = CreateAnimScene('script@mp@character_creator@transitions', 0, 0, false, true);

    LoadAnimScene(animScene);

    Game.Scene._customizationCurrentPed = ped
    -- Aguardar o animScene carregar...
    -- IsAnimSceneLoaded
    while not N_0x477122b8d05e7968(animScene, true,  false) do
        Wait(0);
    end

    -- O nosso ped local precisa estar na mesma posição
    -- que a camera antes da transição para o animScene
    -- porque vai ser cameraLocalPed -> cameraAnimScene.
    --
    -- Meio merda em rockstar ;/
    local  lineupGenderStr = Game.Scene.focusedLineupGender == eLineupGender.Female and 'female' or 'male';
    local oldCam = Game.Scene.lineupCameraMap[lineupGenderStr]
    Game.Player.SetPlayerPosition(GetCamCoord(oldCam))
    Game.Player.ControlEnabled(false)

    Wait(500)

    local useMaleAnim = Game.Scene.focusedLineupGender == eLineupGender.Male;
    local pedAnim = useMaleAnim and 'Male_MP' or 'Female_MP'

    SetAnimSceneEntity(animScene, pedAnim, ped, 0);

    StartAnimScene(animScene);

    -- SetAnimScenePlayList
    SetAnimScenePlaybackList(animScene, useMaleAnim and 'Pl_Start_to_Edit_Male' or 'Pl_Start_to_Edit_Female'); 

    while not HasAnimEventFired(ped, 931807363) do 
        Wait(0);
    end

    local cam = CreateCamera(GetHashKey('DEFAULT_SCRIPTED_CAMERA'), false);

    SetCamCoord(cam, -561.8157, -3780.966, 239.0805);
    SetCamRot(cam, -4.2146, -0.0007, -87.8802, 2);

    SetCamFov(cam, 30.0);

    SetCamActive(cam, true);
    RenderScriptCams(true, false, 3000, true, false, 0);

    Game.Scene.editCamera = cam;
    Game.state = ePersonaCreationState.Customizing;

    FreezeEntityPosition(ped, false)

    Wait(2000)
-- 
    -- local equippedMetapedClothing = exports.frp_lib:handleStartEditor(ped)
    -- print(" INICIOU :: ", json.encode(equippedMetapedClothing))
    -- Game.equippedMetapedClothing = equippedMetapedClothing

    local function onConfirm(personaData)
        print(" onConfirm :: ", json.encode(personaData ,{indent=true}))

        local success = Game.RequestCreatePersona(personaData);

        if success then
            --- RETORNAR Criação de personagem
            -- SpawnSelector.Start();
            TriggerServerEvent("FRP:spawnSelector:DisplayCharSelection")
            Game.Stop();
        end
        return true
    end
    
    local function onBeforeUndo()
        local alert = lib.alertDialog({
            header = i18n.translate("info.cancel_appearance"),
            content = i18n.translate("info.have_sure"),
            centered = true,
            cancel = true
        })

        return alert == 'confirm'
    end

    local function onUndo(personaData)
        Game.Stop();
        SpawnSelector.Start()
        return true
    end

    local equippedMetapedClothing = Appearance.Start(ped, nil, onConfirm, onBeforeUndo, onUndo)

    equippedMetapedClothing.bodyApparatusId = 1;
    equippedMetapedClothing.bodyApparatusStyleId = 1;

    equippedMetapedClothing.isMale = IsPedMale(ped);

    equippedMetapedClothing.whistleShape = 0.0;
    equippedMetapedClothing.whistlePitch = 0.0;
    equippedMetapedClothing.whistleClarity = 0.0;
    equippedMetapedClothing.height = 180;

    equippedMetapedClothing.bodyWeightOufitType = 10;

    equippedMetapedClothing.bodyKindType = 1;

    Game.equippedMetapedClothing = equippedMetapedClothing;
    
    
    -- print(" START :: equippedMetapedClothing , ", json.encode(equippedMetapedClothing))

    -- local started, editor = exports["frp_appearance"]:Start(gscPersonaEditor, ped, function(status)
    --     local success = Game.RequestCreatePersona(Game.equippedMetapedClothing);

    --     if success then
    --         --- RETORNAR Criação de personagem
    --         Game.Stop();
    --     end

    --     return success;
    -- end)

    -- local equippedMetapedClothing = equippedMetapedClothing;
    -- local equippedMetapedClothing = Game.GetEquippedMetapedClothing();

    -- Valores padrões para o editor de persona
    -- TODO: Melhorar isso!

    -- Game.Editor = editor;
end

Game.Scene.RotateCustomizationPed = function(rotateLeft)
    local toAddAngle = rotateLeft and -45.0 or 45.0;

    local lineupGenderStr = Game.Scene.focusedLineupGender == eLineupGender.Female and 'female' or 'male';
    local lineupPed = Game.Scene.lineupPedMap[lineupGenderStr];

    local newHeading = Game.Utils.WrapAngle(lineupPed.getHeading() + toAddAngle);

    TaskAchieveHeading(lineupPed, newHeading, 0);
end

Game.Scene.SetPedDefaultOutfit = function(ped)

    Game.Utils.FixStuckAmmoClothingPiece(ped)
    local isMale = IsPedMale(ped)

    local metapedGender = isMale and eMetapedBodyApparatusGender.Male or eMetapedBodyApparatusGender.Female;

    local defaultOutfit = Config.PedsInitialSettings[metapedGender];

    for _, outfit in pairs(defaultOutfit) do
        local  type, id, styleId = outfit.type, outfit.id, outfit.styleId

        if id <= -1 then
            Appearance.clothingSystemPushRequest(ped, "RemoveCurrentApparatusByType", type);
            return
        end

        Appearance.clothingSystemPushRequest(ped, "UpdateCurrentApparatus",
        {
            apparatusId =  id,
            apparatusStyleId = styleId,
            apparatusType =  type,
        });
    end
end