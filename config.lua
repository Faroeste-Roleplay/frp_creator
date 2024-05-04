
ePersonaCreationState =
{
    Stopped = -1,
    Starting = 0,
    Selecting = 1,
    Transitioning = 2,
    Customizing = 3,
    StoreCloth = 4,
    Barbershop = 5
}

eLineupGender = {
    Male = 0,
    Female = 1
}

eMetapedBodyApparatusGender =
{
    Invalid = -1,
    Female = 0,
    Male = 1,
}

eMetapedBodyApparatusType = 
{
    Invalid           = -1,
    Hair              = 0,
    Heads             = 1,
    BodiesLower       = 2,
    BodiesUpper       = 3,
    Teeth             = 4,
    Eyes              = 5,
    Hats              = 6,
    ShirtsFull        = 7,
    Vests             = 8,
    Coats             = 9,
    CoatsClosed       = 10,
    Pants             = 11,
    Boots             = 12,
    BootAccessories   = 13,
    Cloaks            = 14,
    Chaps             = 15,
    Badges            = 16,
    Masks             = 17,
    Spats             = 18,
    Neckwear          = 19,
    Accessories       = 20,
    JewelryRingsRight = 21,
    JewelryRingsLeft  = 22,
    JewelryBracelets  = 23,
    Gauntlets         = 24,
    Neckties          = 25,
    Loadouts          = 26,
    Suspenders        = 27,
    Satchels          = 28,
    Gunbelts          = 29,
    Belts             = 30,
    BeltBuckles       = 31,
    HolstersLeft      = 32,
    Ponchos           = 33,
    Armor             = 34,
    Eyewear           = 35,
    Gloves            = 36,
    LegsAcessories    = 37,
    Skirts = 38,
    BeardsComplete = 39,
    HairAccessories = 40,
}


eMetapedBodyApparatusTypeToStr = 
{
    'Invalid',
    'Hair',
    'Heads',
    'BodiesLower',
    'BodiesUpper',
    'Teeth',
    'Eyes',
    'Hats',
    'ShirtsFull',
    'Vests',
    'Coats',
    'CoatsClosed',
    'Pants',
    'Boots',
    'BootAccessories',
    'Cloaks',
    'Chaps',
    'Badges',
    'Masks',
    'Spats',
    'Neckwear',
    'Accessories',
    'JewelryRingsRight',
    'JewelryRingsLeft',
    'JewelryBracelets',
    'Gauntlets',
    'Neckties',
    'Loadouts',
    'Suspenders',
    'Satchels',
    'Gunbelts',
    'Belts',
    'BeltBuckles',
    'HolstersLeft',
    'Ponchos',
    'Armor',
    'Eyewear',
    'Gloves',
    'LegsAcessories',
    'Skirts',
    'BeardsComplete',
    'HairAccessories',
}

eOverlayLayer = {
    NONE = 0,
    MPC_OVERLAY_LAYER_FACIAL_HAIR = 1,
    MPC_OVERLAY_LAYER_FOUNDATION = 2,
    MPC_OVERLAY_LAYER_HEAD_HAIR = 3,
    MPC_OVERLAY_LAYER_COMPLEXION = 4,
    MPC_OVERLAY_LAYER_ROOT = 5,
    MPC_OVERLAY_LAYER_EYESHADOW = 6,
    MPC_OVERLAY_LAYER_LIPSTICK = 7,
    MPC_OVERLAY_LAYER_FACE_PAINT = 8,
    MPC_OVERLAY_LAYER_COMPLEXION_2 = 9,
    MPC_OVERLAY_LAYER_EYELINER = 10,
    MPC_OVERLAY_LAYER_INVALID = 11,
    MPC_OVERLAY_LAYER_SKIN_MOTTLING = 12,
    MPC_OVERLAY_LAYER_FRECKLES = 13,
    MPC_OVERLAY_LAYER_AGEING = 14,
    MPC_OVERLAY_LAYER_BLUSHER = 15,
    MPC_OVERLAY_LAYER_EYEBROWS = 16,
    MPC_OVERLAY_LAYER_GRIME = 17,
    MPC_OVERLAY_LAYER_SPOTS = 18,
    MPC_OVERLAY_LAYER_MOLES = 19,
    MPC_OVERLAY_LAYER_SCAR = 20,
}

eOverlayToStr = {
    [0] = "NONE",
    [1] = "MPC_OVERLAY_LAYER_FACIAL_HAIR",
    [2] = "MPC_OVERLAY_LAYER_FOUNDATION",
    [3] = "MPC_OVERLAY_LAYER_HEAD_HAIR",
    [4] = "MPC_OVERLAY_LAYER_COMPLEXION",
    [5] = "MPC_OVERLAY_LAYER_ROOT",
    [6] = "MPC_OVERLAY_LAYER_EYESHADOW",
    [7] = "MPC_OVERLAY_LAYER_LIPSTICK",
    [8] = "MPC_OVERLAY_LAYER_FACE_PAINT",
    [9] = "MPC_OVERLAY_LAYER_COMPLEXION_2",
    [10] = "MPC_OVERLAY_LAYER_EYELINER",
    [11] = "MPC_OVERLAY_LAYER_INVALID",
    [12] = "MPC_OVERLAY_LAYER_SKIN_MOTTLING",
    [13] = "MPC_OVERLAY_LAYER_FRECKLES",
    [14] = "MPC_OVERLAY_LAYER_AGEING",
    [15] = "MPC_OVERLAY_LAYER_BLUSHER",
    [16] = "MPC_OVERLAY_LAYER_EYEBROWS",
    [17] = "MPC_OVERLAY_LAYER_GRIME",
    [18] = "MPC_OVERLAY_LAYER_SPOTS",
    [19] = "MPC_OVERLAY_LAYER_MOLES",
    [20] = "MPC_OVERLAY_LAYER_SCAR",
}


Config = {}

Config.Ipls = {
    -1699673416,
    1679934574,
    183712523
}

Config.LineupPeds = {
    male = {
        camera = {
            x = -561.4727783203125,
            y = -3775.670166015625,
            z = 239.1591033935547,
            pitch = -9.3548002243042,
            roll = -0.0031999999191612005,
            yaw = -90.04989624023438
        },
        position = {
            x = -558.559,
            y = -3775.616,
            z = 237.590,
            heading = 95.0
        }
    },
    female = {
        camera = {
            x = -561.5078125,
            y = -3776.888427734375,
            z = 239.14599609375,
            pitch = -9.3548002243042,
            roll = -0.0031999999191612005,
            yaw = -90.04989624023438
        },
        position = {
            x = -558.559,
            y = -3776.978,
            z = 237.590,
            heading = 95.0
        }
    }
}

Config.PedsInitialSettings = 
{
    [eMetapedBodyApparatusGender.Female] = 
    {
        {
            type = eMetapedBodyApparatusType.Hair,
            id = 14,
            styleId = 5,
        },
        {
            type = eMetapedBodyApparatusType.Heads,
            id = 0,
            styleId = 2,
        },
        {
            type = eMetapedBodyApparatusType.BodiesLower,
            id = 1,
            styleId = 2,
        },
        {
            type = eMetapedBodyApparatusType.BodiesUpper,
            id = 1,
            styleId = 2,
        },
        {
            type = eMetapedBodyApparatusType.Eyes,
            id = 0,
            styleId = 1,
        },
        {
            type = eMetapedBodyApparatusType.Teeth,
            id = 0,
            styleId = 0,
        },
        {
            type = eMetapedBodyApparatusType.Pants,
            id = 2,
            styleId = 0,
        },
        {
            type = eMetapedBodyApparatusType.ShirtsFull,
            id = 2,
            styleId = 0,
        },
        {
            type = eMetapedBodyApparatusType.Boots,
            id = 1,
            styleId = 0,
        },
    },
    [eMetapedBodyApparatusGender.Male] =
    {
        {
            type = eMetapedBodyApparatusType.Hair,
            id = 14,
            styleId = 3,
        },
        {
            type = eMetapedBodyApparatusType.Heads,
            id = 0,
            styleId = 2,
        },
        {
            type = eMetapedBodyApparatusType.BodiesLower,
            id = 1,
            styleId = 2,
        },
        {
            type = eMetapedBodyApparatusType.BodiesUpper,
            id = 1,
            styleId = 2,
        },
        {
            type = eMetapedBodyApparatusType.Eyes,
            id = 0,
            styleId = 5,
        },
        {
            type = eMetapedBodyApparatusType.Teeth,
            id = 0,
            styleId = 0,
        },
        {
            type = eMetapedBodyApparatusType.Pants,
            id = 2,
            styleId = 0,
        },
        {
            type = eMetapedBodyApparatusType.ShirtsFull,
            id = 1,
            styleId = 0,
        },
        {
            type = eMetapedBodyApparatusType.Boots,
            id = 1,
            styleId = 0,
        },
    }
}


