Game = {}
Game.Editor = {}

RegisterNetEvent("FRPCreator:Client:StartScript", function()
    Game.Init()
end)

Game.Init = function ()

    if Game.Start then 
        Game.Stop()
    end

    Game.state = ePersonaCreationState.Starting
    
    DoScreenFadeOut(1000);
    AnimpostfxStop("SkyTL_2100_04Storm_nofade");

    Game.Player.ControlEnabled(false)
    Game.Inputs.enabled = true

    Game.Scene.LoadIpls()

    TriggerServerEvent("net.personaCreatorHandlerSetPlayerRoutingBucket");

    SetClockTime(12, 0, 0);

    N_0x531a78d6bf27014b('RDRO_Character_Creator_Sounds');

    Game.Scene.CreateLineupCamera(eLineupGender.Male);
    Game.Scene.CreateLineupCamera(eLineupGender.Female);

    Game.Scene.ChangeFocusedLineupGender(eLineupGender.Male);

    Game.Scene.CreateLineupPeds()

    Wait(1000)
    
    DoScreenFadeIn(1000);
    AnimpostfxStop("SkyTL_2100_04Storm_nofade");
    
    Game.state = ePersonaCreationState.Selecting

    Game.Scene.CreateInputHandlers()

    Game.Start = true
end


Game.Stop = function()
    Game.Start = false
    Game.Inputs.enabled = false

    for _, ipl in pairs(Game.Scene.iplsLoaded) do 
        RemoveImap(ipl);
    end

    if Game.Scene.lineupPedMap then
        for _, ped in pairs(Game.Scene.lineupPedMap) do 
            DeleteEntity(ped)
        end
        Game.Scene.lineupPedMap = {}
    end

    if Game.Scene.lineupCameraMap then
        for _, cam in pairs(Game.Scene.lineupCameraMap) do 
            DestroyCam(cam, true)
        end
        Game.Scene.lineupCameraMap = {}
    end

    DestroyCam(Game.Scene.editCamera, true);

    RenderScriptCams(false, false, 3000, true, false, 0);

    TriggerServerEvent("net.personaCreatorHandlerRemovePlayerRoutingBucket")

    Game.Player.ControlEnabled(true)

    Game.Scene.focusedLineupGender = {}

    Game.Scene.editCamera = nil

    Game.state = nil

    ClearFocus()

    DisplayHud(false)
    DisplayRadar(false)

    Appearance.OnStop()
end

CreateThread(function()
    local tickTime
    while true do 
        tickTime = 1000
        if Game.Start then
            -- NetworkDisableRealtimeMultiplayer
            N_0x236905c700fdb54d()

            -- Tick para renderizar as luzes!
            Game.Scene.RendererLight()

            if Game.Scene.lineupPedMap then
                for _, ped in pairs(Game.Scene.lineupPedMap) do 
                    ClearPedWetness(ped)
                end
            end

            tickTime = 0
        end

        Wait(tickTime)
    end
end)

Game.RequestCreatePersona = function (equippedMetapedClothing)
    local playerData = equippedMetapedClothing

    ::setupName::
    local inputData = {
        { type = "input", label = i18n.translate('general.name'),        placeholder = "Mack" },
        { type = "input", label = i18n.translate('general.lastname'),    placeholder = "Miller" },
        { type = "date", label = i18n.translate('general.birthdate') },
    }

    local input = lib.inputDialog(i18n.translate('general.personaCreator'), inputData)

    local validadePlayerInfo = ValidadePlayerInfo(input)

    if not validadePlayerInfo then
        goto setupName
    end

    playerData.firstName = inputData[1]
    playerData.lastName = inputData[2]
    playerData.birthDate = inputData[3]

    playerData.isMale = IsPedMale(Game.Ped)
    
    local request = lib.callback.await("PersonaEditor.RequestCreatePersona", false, playerData)
    return request
end

AddEventHandler("onResourceStop", function(resName)
    if resName == GetCurrentResourceName() then
        Game.Stop()
    end
end)