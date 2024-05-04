


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

    local appearanceCustomizable =
    {
        hairApparatusId = hairApparatusId,
        hairApparatusStyleId = hairApparatusStyleId,

        mustacheApparatusId = mustacheApparatusId,
        mustacheApparatusStyleId = mustacheApparatusStyleId,
    }
    print(" appearanceCustomizable :: ", json.encode(appearanceCustomizable, {indent=true}))

    local appearanceOverlays, appearanceOverlaysCustomizable = exports.frp_creator:formatOverlaysToSave(request?.overlayLayersMap)
    
    print(" appearanceOverlaysCustomizable :: ", json.encode(appearanceOverlaysCustomizable, {indent=true}))
    print(" appearanceOverlays :: ", json.encode(appearanceOverlays, {indent=true}))
end)

