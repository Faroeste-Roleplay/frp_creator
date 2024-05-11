local Tunnel = module("frp_core", "lib/Tunnel")
local Proxy = module("frp_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

lib.callback.register('PersonaEditor.RequestCreatePersona', function(source, request)
    local User = API.GetUserFromSource(source)

    if not User then
        return
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
    print(" appearance :: ", json.encode(appearance, {indent=true}))

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

        weightPercentage = appearance.bodyWeightOufitType,
    }

    local appearanceOverlays, appearanceOverlaysCustomizable = exports.frp_creator:formatOverlaysToSave(request?.overlayLayersMap)

    print(" appearanceOverlaysCustomizable :: ", json.encode(appearanceOverlaysCustomizable, {indent=true}))
    print(" appearanceOverlays :: ", json.encode(appearanceOverlays, {indent=true}))

    local characterNode = {
        faceFeatures = appearance.expressions,
        components = appearance,
        componentsCustomizable = appearanceCustomizable,
        overlays = appearanceOverlays.appearanceOverlays,
        overlaysCustomizable = appearanceOverlays.appearanceOverlaysCustomizable
    }

    local charId = User:CreateCharacter(request.firstName, request.lastName, request.birthDate, characterNode, equippedApparelsByType)

    -- if charId then
    --     -- local Character = User:setCharacter(charId)
    --     -- Character:setData(Character:getId(), "metaData", "hunger", 100)
    --     -- Character:setData(Character:getId(), "metaData", "thirst", 100)

    --     -- local encoded = json.encode({-1099.470,-1839.129,60.327})
    --     -- Character:setData(Character:getId(), "metaData", "position", encoded)

    --     User:SetCharacter( charId ) -- Will draw itself
    -- end


end)

