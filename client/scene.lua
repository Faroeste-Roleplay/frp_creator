local Tunnel = module("frp_core", "lib/Tunnel")
local Proxy = module("frp_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")


staticOrderedCameras = 
{
    {-561.206, -3776.224, 238.895, 0.000,  0.000, 270.000, 70.0},        
    {-558.909-0.5, -3776.300, 238.5973, 0.000, 0.000, 210.000, 70.0},
    {-561.8157, -3780.966, 239.0805, -4.2146, -0.0007, -87.8802, 70.0}
}

staticInterpolableCams = 
{
    {-558.909-1.0, -3775.616, 237.590+1.6, -10.000,  0.000, 270.000, 70.0},
    {-558.909-1.0, -3776.978, 237.590+1.5, -10.214, -0.000, 270.000, 70.0},
    {-561.8157+1.4, -3780.966, 239.1805, -4.2146, -0.0007, -87.8802, 25.0}, 
    {-561.8157+0.4, -3780.966, 239.0805, -4.2146, -0.0007, -87.8802, 45.0}
}

State = {
    NONE                  = 0,
    WAITING               = 1,
    SELECTING             = 2,
    CUSTOMIZING           = 3,

    TRANSITION_TO_SELECTING    = 4,
    TRANSITION_TO_CUSTOMIZING  = 5,
}

gState = nil

gIsCamInterpolating = nil

CreationMode = false

gPedsSelectedPedIndex = 1
gPedSelectedSex = "none"

function request()

    gState = State.NONE;
    
    staticPedModels = {
        'mp_male',
        'mp_female',
    }

    defaultPedComponents = 
    {
        ["female"] =
        {
            ['heads'] =
            {
                1,
                4
            },
            ["BODIES_UPPER"] =
            {
                3,
                4
            },
            ['hair'] =
            {
                2,
                10
            },
            ['eyes'] =
            {
                1,
                3               
            },
            ['teeth'] =
            {
                1,
                1
            }      
        },
        ["male"] =
        {
            ['heads'] =
            {
                1,
                4
            },
            ['BODIES_UPPER'] =
            {
                4,
                3
            },
            ['hair'] =
            {
                7,
                2
            },
            ['mustache'] =
            {
                7,
                2                
            },
            ['eyes'] =
            {
                1,
                2                
            },
            ['teeth'] =
            {
                1,
                1
            }            
        },
    }

    staticPedPositions = 
    {
        {-558.559, -3775.616, 237.590, 95.0},
        {-558.559, -3776.978, 237.590, 95.0},
    }

    staticLightPositions = 
    {
        {-561.860, -3776.757, 238.590, 10.000, 50.000},
        {-559.590, -3780.757, 238.590, 10.000, 50.000},
    }

    gImaps =
    {
        -1699673416,
        1679934574,
        183712523,
    }

    for _, imap in pairs(gImaps) do
        RequestImap(imap)
    end 

    gPeds = {}

    local uiMenuData = exports.frp_creator:getDataCreator()

    SendNUIMessage({
        type = 'receivedata',
        uiMenuData = uiMenuData,
    })

    Wait(1500)

    for i = 1, 2 do

        TriggerServerEvent("PersonaCreatorHandler.setPlayerRoutingBucket")

        pedModel = staticPedModels[i]

        hashedPedModel = GetHashKey(pedModel)

        if not HasModelLoaded(hashedPedModel) then
            RequestModel(hashedPedModel)
            while not HasModelLoaded(hashedPedModel) do
                Citizen.Wait(10)
            end
        end

        local coords = staticPedPositions[i]

        local x, y, z, h  = coords[1], coords[2], coords[3], coords[4]
        
        ped = CreatePed(hashedPedModel, x, y, z, 89.37, true, 0)

        TriggerServerEvent("PersonaCreatorHandler.setRoutingBucket", NetworkGetNetworkIdFromEntity(ped))

        SetEntityHeading(ped, h)
        
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)

        NetworkSetEntityInvisibleToNetwork(ped, true)
        
        local pedSex = "female"

        if IsPedMale(ped) then
            pedSex = "male";
        end

        local idleAnimationDict

        if pedSex == "male" then
            idleAnimationDict = "SCRIPT_COMMON@TAILOR_SHOP"
        else 
            idleAnimationDict = "MECH_LOCO_F@TYPE@COWGIRL@NORMAL@UNARMED@IDLE"
        end

        cAPI.SetSkin(ped, json.encode(defaultPedComponents[pedSex]))

        if not HasAnimDictLoaded(idleAnimationDict) then
            RequestAnimDict(idleAnimationDict)

            while not HasAnimDictLoaded(idleAnimationDict) do
                Citizen.Wait(0)
            end
        end

        TaskPlayAnim(ped, idleAnimationDict,  "idle", 1000.0, -4.0, -1, 8193, 0.0, false, 0, false, 0, false)

        table.insert(gPeds, ped)
    end
    
    do        
        gCameraIndex = 1;

        local configCam = staticOrderedCameras[gCameraIndex];
        local x, y, z, pitch, roll, yaw, fov = configCam[1], configCam[2], configCam[3], configCam[4], configCam[5], configCam[6], configCam[7]

        gCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true);
        SetCamCoord(gCamera, x, y, z);
        SetCamRot(gCamera, pitch, roll, yaw, 0);
        SetCamActive(gCamera, true);
        RenderScriptCams(true, false, 1, true, true, 0);

        SetFocusPosAndVel(x, y, z, 0.0, 0.0, 0.0);
        -- Debugging
        SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false);

        SetEntityInvincible(PlayerPedId(), true);
        SetEntityVisible(PlayerPedId(), false);
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true);

        
    end

    CreationMode = true 

    gState = State.SELECTING;
    
    local x,y,z = GetEntityCoords(PlayerPedId(), false);
    
    Citizen.CreateThread(function()
        RequestCollisionAtCoord(x,y,z)
        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
            print('[creator] Loading spawn collision.')
            Wait(0)
        end
    end)
    Wait(1000)
    DoScreenFadeIn(500)

    TriggerEvent("FRP:CHARCREATION:sceneSelect")
end


RegisterNetEvent("FRP:CHARCREATION:sceneSelect")
AddEventHandler("FRP:CHARCREATION:sceneSelect", function()    
    local PAD_RIGHT_ARROW = 0xDEB34313
    local PAD_LEFT_ARROW  = 0xA65EBAB4
    local INPUT_FRONTEND_ACCEPT = 0xC7B5340A

    while CreationMode do
        Wait(0)

        if CreationMode then
            DisableAllControlActions(0)
            DisplayRadar(false)
            DisplayHud(true)
            NetworkClockTimeOverride(8, 0, 0, 0, false)
        end

        for i = 1, #staticLightPositions do

            local lightPosition = staticLightPositions[i]
            local x, y, z, range, intensity = lightPosition[1], lightPosition[2], lightPosition[3], lightPosition[4], lightPosition[5]

    
            DrawLightWithRange(x, y, z, 255, 255, 255, range, intensity)
        end

        if gState == State.SELECTING then
            if IsDisabledControlJustReleased(0, PAD_RIGHT_ARROW) then                
                gPedsSelectedPedIndex = 2
                gPedSelectedSex = "female"

                PlaySoundFrontend("gender_right", "RDRO_Character_Creator_Sounds", true, 0)

                gIsCamInterpolating = true

                interpolateToCamIndex(staticInterpolableCams, 2)
            end
            
            if IsDisabledControlJustReleased(0, PAD_LEFT_ARROW) then
                gPedsSelectedPedIndex = 1
                gPedSelectedSex = "male"
                
                PlaySoundFrontend("gender_left", "RDRO_Character_Creator_Sounds", true, 0)

                gIsCamInterpolating = true

                interpolateToCamIndex(staticInterpolableCams, 1)
            end

            if IsDisabledControlJustReleased(0, INPUT_FRONTEND_ACCEPT) then
                
                TriggerEvent("FRP:CHARCREATION:startCustomizationScene", defaultPedComponents[gPedSelectedSex])

                gIsCamInterpolating = false

                interpolateToCamIndex(staticOrderedCameras, 2)

                gState = State.TRANSITION_TO_SELECTING
            end

            local text = "Escolha seu personagem, use as setas do seu teclado. ~INPUT_FRONTEND_ACCEPT~ Para escolher."
            notify(text)

        elseif gState == State.TRANSITION_TO_SELECTING then

            gState = State.TRANSITION_TO_CUSTOMIZING
            Citizen.InvokeNative(0xFA233F8FE190514C, 0)
            Citizen.InvokeNative(0xE9990552DEC71600)

        elseif gState == State.TRANSITION_TO_CUSTOMIZING then

            Citizen.InvokeNative(0xFA233F8FE190514C, 0)
            Citizen.InvokeNative(0xE9990552DEC71600)  

        elseif gState == State.CUSTOMIZING then

            Citizen.InvokeNative(0xFA233F8FE190514C, 0)
            Citizen.InvokeNative(0xE9990552DEC71600)
        end
        
    end
end)


function notify(_message)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", _message, Citizen.ResultAsLong())
    SetTextScale(0.25, 0.25)
    SetTextCentre(1)
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end

function interpolateToCamIndex(camRefArray, camIndex)
    local camConfig = camRefArray[camIndex]    
    local x, y, z, pitch, roll, yaw, fov =  camConfig[1], camConfig[2], camConfig[3], camConfig[4], camConfig[5], camConfig[6], camConfig[7]

    SetCamActiveWithInterp(gCamera, gInterpCamera, 1200, 1, 1);

    gInterpCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true);       
    SetCamRot(gInterpCamera, pitch, roll, yaw, 0);
    SetCamActive(gInterpCamera, true);
    SetCamFov(gInterpCamera, fov);

    if gIsCamInterpolating then
        local pedHandle = gPeds[gPedsSelectedPedIndex];

        AttachCamToEntity(gInterpCamera, pedHandle, -1.0, 0.0, 0.5,false)
        SetCamActiveWithInterp(gInterpCamera, gCamera, 1000, 1, 1);

        gIsCamInterpolating = false;
    else 
        SetCamCoord(gInterpCamera, x, y, z);
        if camIndex == 2 then
            SetCamActiveWithInterp(gInterpCamera, gCamera, 5000, 1.0, 1.0);
        else
            SetCamActiveWithInterp(gInterpCamera, gCamera, 1000, 1.0, 1.0);
        end
    end
end

function release()

    if gPeds ~= nil then
        local pedHandle = gPeds[gPedsSelectedPedIndex] 
        
        Citizen.InvokeNative(0xE952D6431689AD9A, pedHandle, PlayerPedId())

        for i = 1, #gPeds do
            DeleteEntity(gPeds[i])
        end

        gPeds = nil
    end

    if gImaps ~= nil then
        for i = 1, #gImaps do
            RemoveImap(gImaps[i])
        end
    end

    gImaps = nil

    gState = nil

    local playerPed = PlayerPedId()

    SetFocusEntity(playerPed)
    SetEntityInvincible(playerPed, false)
    SetEntityVisible(playerPed, true)
    NetworkSetEntityInvisibleToNetwork(playerPed, false)
    
    CreationMode = false

    DestroyAllCams(true)

    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())                    
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end

RegisterNetEvent("FRP:CHARCREATION:starting")
AddEventHandler("FRP:CHARCREATION:starting", function()    
    DoScreenFadeOut(500)
    
    while IsScreenFadedOut() do 
        Wait(100)
    end

    Wait(1100)
    request()
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() or resourceName == "frp_core" then
        release()
    end
end)
