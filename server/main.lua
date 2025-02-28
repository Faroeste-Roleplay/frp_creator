local Tunnel = module("frp_lib", "lib/Tunnel")
local Proxy = module("frp_lib", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

VirtualWorld = Proxy.getInterface("virtual_world")


lib.callback.register('PersonaEditor.RequestCreatePersona', function(source, request)
    local User = API.GetUserFromSource(source)

    if not User then
        return
    end

    local userMaxSlots = User:GetMaxCharSlotsAvailable()
    local characters = User:GetCharacters()

    local birtDate = request.birthDate

    if characters then
        local cannotCreateCharacter = #characters >= userMaxSlots

        if cannotCreateCharacter then
            User:Notify("error", i18n.translate('error.do_not_have_permission'), 5000)
            return
        end
    end

    local equippedApparelsByType = request.equippedApparelsByType

    local headApparatusId = equippedApparelsByType[eMetapedBodyApparatusType.Heads]?.id

    local teethApparatusStyleId = equippedApparelsByType[eMetapedBodyApparatusType.Teeth]?.styleId

    local eyesApparatusId, eyesApparatusStyleId = equippedApparelsByType[eMetapedBodyApparatusType.Eyes]?.id, equippedApparelsByType[eMetapedBodyApparatusType.Eyes]?.styleId

    local appearance =
    {
        isMale = request?.isMale,

        expressions =  request?.expressionsMap,

        bodyApparatusId = request?.bodyApparatusId,
        bodyApparatusStyleId = request?.bodyApparatusStyleId,
    
        headApparatusId = headApparatusId,

        teethApparatusStyleId = teethApparatusStyleId,

        eyesApparatusId = eyesApparatusId,
        eyesApparatusStyleId = eyesApparatusStyleId,

        whistleShape = request?.whistleShape,
        whistlePitch = request?.whistlePitch,
        whistleClarity = request?.whistleClarity,

        height = request?.height,

        bodyWeightOufitType = request?.bodyWeightOufitType,

        bodyKindType = request?.bodyKindType,
    }
    -- print(" appearance :: ", json.encode(appearance, {indent=true}))

    local hairApparatusId, hairApparatusStyleId = equippedApparelsByType[eMetapedBodyApparatusType.Hair]?.id, equippedApparelsByType[eMetapedBodyApparatusType.Hair]?.styleId

    local mustacheApparatusId, mustacheApparatusStyleId = equippedApparelsByType[eMetapedBodyApparatusType.BeardsComplete]?.id, equippedApparelsByType[eMetapedBodyApparatusType.BeardsComplete]?.styleId

    local equippedOutfitId

    local appearanceCustomizable =
    {
        equippedOutfitId = equippedOutfitId,

        hairApparatusId = hairApparatusId,
        hairApparatusStyleId = hairApparatusStyleId,

        mustacheApparatusId = mustacheApparatusId,
        mustacheApparatusStyleId = mustacheApparatusStyleId,
    }

    local appearanceOverlays = exports.frp_creator:formatOverlaysToSave(request?.overlayLayersMap)
    
    -- print(" appearanceOverlays :: ", json.encode(appearanceOverlays, {indent=true}))

    local characterNode = {
        faceFeatures = appearance.expressions,
        components = appearance,
        componentsCustomizable = appearanceCustomizable,
        overlays = appearanceOverlays.appearanceOverlays,
        overlaysCustomizable = appearanceOverlays.appearanceOverlaysCustomizable
    }

    local metadata = {
        mothername = request.mothername,
        fathername = request.fathername,
        borncity = request.borncity,
        naturalness = request.naturalness,
    }

    local charId = User:CreateCharacter(request.firstName, request.lastName, request.birthDate, characterNode, equippedApparelsByType, metadata)

    return charId
end)

RegisterNetEvent("net.personaCreatorHandlerRemovePlayerRoutingBucket", function()
    local playerId = source
    VirtualWorld:AddPlayerToGlobalWorld( playerId )
end)

RegisterNetEvent("net.personaCreatorHandlerSetPlayerRoutingBucket", function()
    local playerId = source
    VirtualWorld:AddPlayerOnVirtualWorld( playerId, tonumber(playerId) )
end)

RegisterNetEvent("net.personaCreatorHandlerSetRoutingBucket", function(entityId)
    local playerId = source
    SetEntityRoutingBucket(NetworkGetEntityFromNetworkId(entityId), tonumber(playerId))
end)

-- function convertToSQLDate(dateStr)
--     local day, month, year = dateStr:match("(%d%d)/(%d%d)/(%d%d%d%d)")  -- Extrai os componentes
--     return string.format("%d-%02d-%02d", year, tonumber(month), tonumber(day))  -- Retorna no formato correto
-- end