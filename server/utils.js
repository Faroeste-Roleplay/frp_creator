const eOverlayLayer = {
    NONE : 0,
    MPC_OVERLAY_LAYER_FACIAL_HAIR : 1,
    MPC_OVERLAY_LAYER_FOUNDATION : 2,
    MPC_OVERLAY_LAYER_HEAD_HAIR : 3,
    MPC_OVERLAY_LAYER_COMPLEXION : 4,
    MPC_OVERLAY_LAYER_ROOT : 5,
    MPC_OVERLAY_LAYER_EYESHADOW : 6,
    MPC_OVERLAY_LAYER_LIPSTICK : 7,
    MPC_OVERLAY_LAYER_FACE_PAINT : 8,
    MPC_OVERLAY_LAYER_COMPLEXION_2 : 9,
    MPC_OVERLAY_LAYER_EYELINER : 10,
    MPC_OVERLAY_LAYER_INVALID : 11,
    MPC_OVERLAY_LAYER_SKIN_MOTTLING : 12,
    MPC_OVERLAY_LAYER_FRECKLES : 13,
    MPC_OVERLAY_LAYER_AGEING : 14,
    MPC_OVERLAY_LAYER_BLUSHER : 15,
    MPC_OVERLAY_LAYER_EYEBROWS : 16,
    MPC_OVERLAY_LAYER_GRIME : 17,
    MPC_OVERLAY_LAYER_SPOTS : 18,
    MPC_OVERLAY_LAYER_MOLES : 19,
    MPC_OVERLAY_LAYER_SCAR : 20,
}

const eOverlayToStr = {
    [0] : "NONE",
    [1] : "MPC_OVERLAY_LAYER_FACIAL_HAIR",
    [2] : "MPC_OVERLAY_LAYER_FOUNDATION",
    [3] : "MPC_OVERLAY_LAYER_HEAD_HAIR",
    [4] : "MPC_OVERLAY_LAYER_COMPLEXION",
    [5] : "MPC_OVERLAY_LAYER_ROOT",
    [6] : "MPC_OVERLAY_LAYER_EYESHADOW",
    [7] : "MPC_OVERLAY_LAYER_LIPSTICK",
    [8] : "MPC_OVERLAY_LAYER_FACE_PAINT",
    [9] : "MPC_OVERLAY_LAYER_COMPLEXION_2",
    [10] : "MPC_OVERLAY_LAYER_EYELINER",
    [11] : "MPC_OVERLAY_LAYER_INVALID",
    [12] : "MPC_OVERLAY_LAYER_SKIN_MOTTLING",
    [13] : "MPC_OVERLAY_LAYER_FRECKLES",
    [14] : "MPC_OVERLAY_LAYER_AGEING",
    [15] : "MPC_OVERLAY_LAYER_BLUSHER",
    [16] : "MPC_OVERLAY_LAYER_EYEBROWS",
    [17] : "MPC_OVERLAY_LAYER_GRIME",
    [18] : "MPC_OVERLAY_LAYER_SPOTS",
    [19] : "MPC_OVERLAY_LAYER_MOLES",
    [20] : "MPC_OVERLAY_LAYER_SCAR",
}

async function formatOverlaysToSave(overlayLayersMap) 
{
    
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

        const overlayLayerType = Number(overlayLayerTypeAsString);

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

    const appearanceOverlays = appearanceOverlaysData

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

    return {appearanceOverlays, appearanceOverlaysCustomizable}
}
exports('formatOverlaysToSave', formatOverlaysToSave)