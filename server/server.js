
async function handleRequestCreatePersona(session, request, forceStartPlaying)
{
    const {
        firstName,
        lastName,
        birthDate,

        isMale,

        bodyApparatusId,
        bodyApparatusStyleId,

        whistleShape,
        whistlePitch,
        whistleClarity,

        expressionsMap,

        overlayLayersMap,

        equippedApparelsByType,

        height,

        bodyWeightOufitType,

        bodyKindType,
    } = request;

    // console.log('handleRequestCreatePersona :: request', request);

    const userId = session.getPrincipal().id;

    let numFreePersonaSlots = 0;

    try
    {
        numFreePersonaSlots = await this.accountService.getAccountNumFreePersonaSlots(userId);
    }
    catch(e)
    {
        this.logger.error(e);

        throw new Error(`Ocorreu um error ao tentar buscar o seu número máximo de personagens!`);
    }

    if (numFreePersonaSlots <= 0)
        throw new Error(`Você não pode criar mais personagens!`);

    //

    const { id: headApparatusId } = equippedApparelsByType[eMetapedBodyApparatusType.Heads] || { };

    const { styleId: teethApparatusStyleId } = equippedApparelsByType[eMetapedBodyApparatusType.Teeth] || { };

    const { id: eyesApparatusId, styleId: eyesApparatusStyleId } = equippedApparelsByType[eMetapedBodyApparatusType.Eyes] || { };

    const appearance =
    {
        isMale,

        expressions: expressionsMap,

        bodyApparatusId,
        bodyApparatusStyleId,
    
        headApparatusId,

        teethApparatusStyleId,

        eyesApparatusId,
        eyesApparatusStyleId,

        whistleShape,
        whistlePitch,
        whistleClarity,

        height,

        bodyWeightOufitType,

        bodyKindType,
    }

    //

    const { id: hairApparatusId, styleId: hairApparatusStyleId } = equippedApparelsByType[eMetapedBodyApparatusType.Hair] || { };

    const { id: mustacheApparatusId, styleId: mustacheApparatusStyleId } = equippedApparelsByType[eMetapedBodyApparatusType.BeardsComplete] || { };

    const appearanceCustomizable =
    {
        hairApparatusId,
        hairApparatusStyleId,

        mustacheApparatusId,
        mustacheApparatusStyleId,
    }

    const overlaysForAppearanceOverlays =
    [
        eOverlayLayer.MPC_OVERLAY_LAYER_COMPLEXION,
        eOverlayLayer.MPC_OVERLAY_LAYER_COMPLEXION_2,
        eOverlayLayer.MPC_OVERLAY_LAYER_SKIN_MOTTLING,
        eOverlayLayer.MPC_OVERLAY_LAYER_FRECKLES,
        eOverlayLayer.MPC_OVERLAY_LAYER_AGEING,
        eOverlayLayer.MPC_OVERLAY_LAYER_GRIME,
        eOverlayLayer.MPC_OVERLAY_LAYER_SPOTS,
        eOverlayLayer.MPC_OVERLAY_LAYER_MOLES,
        eOverlayLayer.MPC_OVERLAY_LAYER_SCAR
    ];

    const overlaysForAppearanceOverlaysCustomizable =
    [
        // MPC_OVERLAY_LAYER_BLUSHER,
        // MPC_OVERLAY_LAYER_EYEBROWS,
        // MPC_OVERLAY_LAYER_EYELINER,
        // MPC_OVERLAY_LAYER_FACE_PAINT,
        // MPC_OVERLAY_LAYER_LIPSTICK,
        // MPC_OVERLAY_LAYER_EYESHADOW,
        // MPC_OVERLAY_LAYER_HEAD_HAIR,
        // MPC_OVERLAY_LAYER_FOUNDATION,
        // MPC_OVERLAY_LAYER_FACIAL_HAIR,
    ];

    const appearanceOverlaysData = Object.entries(overlayLayersMap)
    // Filtrar somenre os overlays que não são customizáveis
    .filter(e =>
    {
        const [ overlayLayerTypeAsString ] = e;

        const overlayLayerType = Number(overlayLayerTypeAsString) as eOverlayLayer;

        return overlaysForAppearanceOverlays.includes(overlayLayerType);
    })
    // Mapear novamente os overlays, e transformar `Array<[overlayLayer, { styleIndex, ... }]>` em `Record<overlayLayer, { styleIndex, ... }>`
    .reduce((obj, e) =>
    {
        const [ overlayLayerType, rest ] = e;

        return {
            ...obj,
            [overlayLayerType]: rest,
        }
    }, { });

    // console.log('handleRequestCreatePersona :: appearanceOverlaysData', appearanceOverlaysData);

    const appearanceOverlays =
    {
        data: appearanceOverlaysData,
    }

    // console.log('handleRequestCreatePersona :: appearanceOverlays', JSON.stringify(appearanceOverlays));

    const appearanceOverlaysCustomizable =
    {
        hasFacialHair: !!overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_FACIAL_HAIR],

        headHairStyle: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_HEAD_HAIR]?.styleIndex,
        headHairOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_HEAD_HAIR]?.opacity,

        foundationColor: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_FOUNDATION]?.colorIndex,
        foundationOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_FOUNDATION]?.opacity,
    
        lipstickColor: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_LIPSTICK]?.colorIndex,
        lipstickOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_LIPSTICK]?.opacity,
    
        facePaintColor: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_FACE_PAINT]?.colorIndex,
        facePaintOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_FACE_PAINT]?.opacity,
    
        eyeshadowColor: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_EYESHADOW]?.colorIndex,
        eyeshadowOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_EYESHADOW]?.opacity,
    
        eyelinerColor: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_EYELINER]?.colorIndex,
        eyelinerOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_EYELINER]?.opacity,
    
        eyebrowsStyle: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_EYEBROWS]?.styleIndex,
        eyebrowsColor: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_EYEBROWS]?.colorIndex,
        eyebrowsOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_EYEBROWS]?.opacity,

        blusherStyle: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_BLUSHER]?.styleIndex,
        blusherColor: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_BLUSHER]?.colorIndex,
        blusherOpacity: overlayLayersMap[eOverlayLayer.MPC_OVERLAY_LAYER_BLUSHER]?.opacity,
    };

    // console.log('handleRequestCreatePersona :: appearanceOverlaysCustomizable', JSON.stringify(appearanceOverlaysCustomizable));

    try
    {
        await this.personaService.createPersona(
            userId,
            firstName, lastName, 19,
            appearance,
            appearanceCustomizable,
            appearanceOverlays,
            appearanceOverlaysCustomizable,

            equippedApparelsByType,
        );
    }
    catch(e)
    {
        this.logger.error(e);

        throw new Error('Ocorreu um error ao finalizar a criação do seu personagem, contate a Staff!');
    }
}