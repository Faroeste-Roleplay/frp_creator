local playerAppearanceComponents = {}

local playerAppearanceOverlay = {}

local playerProfileCreation = {}

local pedHandle = nil

RegisterNetEvent("FRP:CHARCREATION:startCustomizationScene")
AddEventHandler("FRP:CHARCREATION:startCustomizationScene", function(characterData)
    startCustomizationScene(characterData)  
end)

function startCustomizationScene(characterData)
    playerAppearanceComponents = characterData

    --InitiatePrompts();
    playerProfileCreation.faceFeatures = {}

    playerProfileCreation.pedSize = 1.0

    pedHandle = gPeds[gPedsSelectedPedIndex];

    --print("NUM PLAYER", gPedsSelectedPedIndex, pedHandle)

    ClearPedTasks(pedHandle, 1, 1)
    ClearPedSecondaryTask(pedHandle)

    Creation = true
    
    local coordsPed = GetEntityCoords(pedHandle)

    TaskGoToCoordAnyMeansExtraParams(pedHandle, coordsPed.x-1.0, coordsPed.y, coordsPed.z, 1.0, 0, false, 524311, -1.0, 0, 1101004800, 800, 1112014848)

    Citizen.Wait(700)

    TaskGoToCoordAnyMeansExtraParams(pedHandle, -558.55, -3781.13, 238.59, 1.0, 0, false, 524311, -1.0, 0, 1101004800, 800, 1112014848)

    Wait(4000)

    local staticOrderedCamerasConfig = staticOrderedCameras[3];    
    local x, y, z, pitch, roll, yaw, fov = staticOrderedCamerasConfig[1], staticOrderedCamerasConfig[2], staticOrderedCamerasConfig[3], staticOrderedCamerasConfig[4], staticOrderedCamerasConfig[5], staticOrderedCamerasConfig[6], staticOrderedCamerasConfig[7]

    DestroyAllCams(true);
    
    local cCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true);
    SetCamCoord(cCamera, x, y, z);
    SetCamRot(cCamera, pitch, roll, yaw, 2);
    SetCamActive(cCamera, true);
    SetCamFov(cCamera, 30.0);
    RenderScriptCams(true, false, 3000, true, true, 0);

    SetFocusPosAndVel(x, y, z, 0.0, 0.0, 0.0);   
    
    SetPedDesiredHeading(pedHandle, 91.0);
    
    Wait(2000)

    local isMale = IsPedMale(pedHandle) == 1

    local idleAnimationDict;

    if (isMale) then
        idleAnimationDict = "SCRIPT_COMMON@TAILOR_SHOP";
    else
        idleAnimationDict = "MECH_LOCO_F@TYPE@COWGIRL@NORMAL@UNARMED@IDLE";  
    end 

    if not HasAnimDictLoaded(idleAnimationDict) then
        RequestAnimDict(idleAnimationDict)

        while not HasAnimDictLoaded(idleAnimationDict) do
            Citizen.Wait(0)
        end
    end
    
    TaskPlayAnim(pedHandle, idleAnimationDict, "idle", 1000.0, -4.0, -1, 8193, 0.0, false, 0, false, 0, false)

    SetNuiFocus(true,true)  
    SetNuiFocusKeepInput(true)
    

    SendNUIMessage({
        type = 'open',
        isVisible = true,
        isMale = isMale,
    })
    
end

RegisterNUICallback("state:Customization:ComponentTypeSelected", function(data)
    setComponentPlayer(data)
end)

RegisterNUICallback("state:Customization:OverlayType", function(data)
    exports.frp_creator:setOverlayData(pedHandle, data)

    table.insert(playerAppearanceOverlay, data)
end)

function setComponentPlayer(data)    
    local categoryIndex = data.compType
    local componentIndex = data.offsetModel
    local variationIndex = data.offsetVariation

    local isMale = "female"

    if IsPedMale(pedHandle) then
        isMale = "male"
    end
    
    if data.faceFeatureIndex > 1 then
        
        interpolateToCamIndex(staticInterpolableCams, 3)

        local hash = data.faceFeatureIndex;
        local value = componentIndex;    

        table.insert(playerProfileCreation.faceFeatures, {['hash'] = hash, ['index'] = value})     

        Citizen.InvokeNative(0x5653AB26C82938CF, pedHandle, tonumber(hash), tonumber(value))
        Citizen.InvokeNative(0xCC8CA3E88256E58F, pedHandle, 0, 1, 1, 1, 0)

        return
    end

    if variationIndex == 0 then
        variationIndex = 1
    end

    for i = 1, #componentsHashNames do

        local components = componentsHashNames[i]

        if componentIndex == 0 and components.category_hashname == compType then           
                Citizen.InvokeNative(0xD710A5007C2AC539, pedHandle, components.category_hash, 0)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, pedHandle, 0, 1, 1, 1, 0)
            return
        end

        if components.ped_type == isMale then
            if components.category_hashname == categoryIndex then
                

                local componentHash = components.models[componentIndex][variationIndex].hash
                Citizen.InvokeNative(0xD3A7B003ED343FD9, pedHandle, componentHash, true,true, true)                   
                

                playerAppearanceComponents[categoryIndex] = {componentIndex, variationIndex}     
            end

            if categoryIndex == "BODIES_UPPER" then
                if components.category_hashname == "BODIES_UPPER" then

                    local componentHash = componentsHashNames[i-2].models[componentIndex][variationIndex].hash
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, pedHandle, componentHash, true, true, true)

                end
            end

        end
    end

    changeCamPosition(categoryIndex)
    
    if categoryIndex ~= "teeth" then
        ClearPedTasks(pedHandle, 0, 0)
    end

    if categoryIndex == 'pedSize' then
        interpolateToCamIndex(staticInterpolableCams, 4) 

        local value = componentIndex;

        local isPositive = value > 185;
        local variation = (math.abs(185 - value) * 0.004333)
        
        if not isPositive then
            variation = -(variation)
            number = 1.0 + variation
        else
            number = 1.0 + variation
        end

        SetPedScale(pedHandle, number); 

        playerProfileCreation.pedSize = number;        

    elseif categoryIndex == 'teeth' then
        interpolateToCamIndex(staticInterpolableCams, 3)
        
        if not HasAnimDictLoaded("FACE_HUMAN@GEN_MALE@BASE") then
            RequestAnimDict("FACE_HUMAN@GEN_MALE@BASE")

            while not HasAnimDictLoaded("FACE_HUMAN@GEN_MALE@BASE") do
                Citizen.Wait(0)
            end
        end
        
        TaskPlayAnim(pedHandle, "FACE_HUMAN@GEN_MALE@BASE", "Face_Dentistry_Loop", 1090519040, -4.0, -1, 17, 0.0, false, 0, false, 0, false)

    elseif categoryIndex == 'porte' then
        local offset = 131

        if isMale == "female" then
            offset = 113
        end

        local finalIndex = offset + componentIndex;

        playerAppearanceComponents['porte'] = finalIndex

        Citizen.InvokeNative(0xA5BAE410B03E7371, pedHandle, finalIndex, false, true)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, pedHandle, 0, 1, 1, 1, 0)

    elseif categoryIndex == 'char-weight' then
        local WAIST_TYPES = {
            -2045421226,    -- smallest
            -1745814259,
            -325933489,
            -1065791927,
            -844699484,
            -1273449080,
            927185840,
            149872391,
            399015098,
            -644349862,
            1745919061,      -- default
            1004225511,
            1278600348,
            502499352,
            -2093198664,
            -1837436619,
            1736416063,
            2040610690,
            -1173634986,
            -867801909,
            1960266524,        -- biggest    
        }

        local waistIndex = componentIndex;

        playerProfileCreation.waistType = waistIndex
        
        Citizen.InvokeNative(0x1902C4CFCC5BE57C,pedHandle, WAIST_TYPES[waistIndex])
        Citizen.InvokeNative(0xCC8CA3E88256E58F,pedHandle, 0, 1, 1, 1, false)
    end
end

local camCategoryIndex = {
    ["skin_tone"] = 4, -- corpo todo
    ["hair"] = 3, -- rosto
    ["heads"] = 3
}


function changeCamPosition(category)
    for index, camIndex in pairs(camCategoryIndex) do
        if category == index then            
            interpolateToCamIndex(staticInterpolableCams, camIndex)
        end
    end
end


RegisterNUICallback("state:Customization:requestTypeProfileName", function(data)
    SetNuiFocus(false,false)
    SetNuiFocusKeepInput(false)

    SendNUIMessage({
        type = 'close',
        isVisible = false
    })

    local PlayerName = cAPI.Prompt("Nome Completo:", "")
    
    if PlayerName == "" then
        return
    end

    playerProfileCreation.name = PlayerName
    
    SendNUIMessage({
        type = 'ReceiveProfileName',
        isVisible = true,
        profileName = playerProfileCreation.name
    })     
    
    SetNuiFocus(true,true)
    SetNuiFocusKeepInput(true) 
end)


RegisterNUICallback("CharacterCreation.Done", function(data)
    local pedHandle = gPeds[gPedsSelectedPedIndex]      
    local playerPed = PlayerPedId()

    local pedModel = "mp_female"

    if IsPedMale(pedHandle) then                        
        pedModel = "mp_male"
    end
    
    cAPI.SetPlayerPed(pedModel)
    
    SendNUIMessage({
        type = 'close',
        isVisible = false
    })

    Wait(200)

    SetFocusEntity(playerPed) 
    SetEntityInvincible(playerPed, false)
    SetEntityVisible(playerPed, true)
    NetworkSetEntityInvisibleToNetwork(playerPed, false)

    DestroyAllCams(true)

    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", " ", Citizen.ResultAsLong())              
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)

    local isPedMale = false

    if IsPedMale(pedHandle) then
        isPedMale = true
    end

    playerProfileCreation.isMale = isPedMale
    playerProfileCreation.pedModel = pedModel
    playerProfileCreation.age = data.age.value;
    
    playerProfileCreation.components = cAPI.PackPedComponents( playerProfileCreation, playerAppearanceComponents )
    playerProfileCreation.componentsCustomizable = cAPI.PackPedComponentsCustomizable( playerAppearanceComponents )
    playerProfileCreation.overlays = json.encode(playerAppearanceOverlay);

    TriggerServerEvent("PersonaCreatorHandler.requestCreatePersona", playerProfileCreation)

    --emitNet("PersonaCreatorHandler.requestCreatePersona", buffer, gMessageNMProfileCreation.faceFeatures);

    SetNuiFocus(false, false);

    release()

    cAPI.StartFade(500)

    Wait(Config.fadeOutTime)
    cAPI.EndFade(500)
end)