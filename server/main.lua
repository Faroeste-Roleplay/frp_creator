

lib.callback.register('PersonaEditor.RequestCreatePersona', function(source, request)
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

    local characterNode = {
        faceFeatures = appearance.expressions,
        componets = appearance,
        componentsCustomizable = appearanceCustomizable,
        overlays = appearanceOverlays,
        overlaysCustomizable = appearanceOverlaysCustomizable
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

    print(" appearanceOverlaysCustomizable :: ", json.encode(appearanceOverlaysCustomizable, {indent=true}))
    print(" appearanceOverlays :: ", json.encode(appearanceOverlays, {indent=true}))
end)

