Game.Utils = {}



Game.Utils.WrapAngle = function(angle)
    -- reduce the angle  
    angle =  angle % 360; 

    -- force it to be the positive remainder, so that 0 <= angle < 360  
    angle = (angle + 360) % 360;  

    -- force into the minimum absolute value residue class, so that -180 < angle <= 180  
    
    if (angle > 180)  then
        angle -= 360;
    end
    
    return angle;
end

Game.Utils.FixStuckAmmoClothingPiece = function(ped)
    if Game.Utils.IsModelMp(ped) then
        -- #TODO: Usar o MPCS para remover.

        -- RemoveTagFromMetaPed
        N_0xd710a5007c2ac539(ped, GetHashKey('AMMO_PISTOLS'), 0);

        -- UpdatePedVariation
        N_0xcc8ca3e88256e58f(ped, 0, 1, 1, 1, 0);
    end
end

Game.Utils.IsModelMp = function(ped) 
    local pedModel = GetEntityModel(ped)

    return pedModel == `mp_male` or `mp_female`
end