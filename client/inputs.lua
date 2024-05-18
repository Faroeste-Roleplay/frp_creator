Game.Inputs = {}

Game.Inputs.enabled = false

eIoContextType =
{
    -- CtxInvalid = -1,
    
    -- CTX_MOUSE_NORMALIZED_AXIS_X,
    -- CTX_MOUSE_NORMALIZED_AXIS_Y,
    -- CTX_MOUSE_NORMALIZED_IAXIS_X,
    -- CTX_MOUSE_NORMALIZED_iAXIS_Y,

    Invalid = -1,

    MouseNormalizedAxisXRight = 0 ,
    MouseNormalizedAxisXLeft = 1,
    MouseNormalizedAxisYDown = 2,
    MouseNormalizedAxisYUp = 3,

    MouseLeftClick = 4,

    KeyboardSpace = 5,
    KeyboardW = 6,
    KeyboardS = 7,
    KeyboardLeftShift = 8,
    KeyboardLeftControl = 9,

    KeyboardLeftArrow = `INPUT_FRONTEND_LEFT`,
    KeyboardRightArrow = `INPUT_FRONTEND_RIGHT`,
    
    KeyboardEnter = `INPUT_FRONTEND_ACCEPT`,
    LeftAlt = 13
}

eIoContextSubscriberType =
{
    OnPressed  = IsControlJustPressed,
    OnReleased = IsControlJustReleased,

    OnPressedAndReleased = IsControlEnabled,
}


Game.Inputs.On = function(subscriberType, contextTypes, fn)
    CreateThread(function()
        while Game.Inputs.enabled do
            local inputFn = eIoContextSubscriberType[subscriberType]
            if inputFn(0, contextTypes) then
                fn()
            end
            Wait(0)
        end
    end)
end