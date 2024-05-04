Game.Player = {}

Game.Player.SetPlayerPosition = function(pos)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, pos)
end

Game.Player.ControlEnabled = function(bool)
    local playerPed = PlayerPedId()

    SetEntityVisible(playerPed, bool)
    
    NetworkSetEntityInvisibleToNetwork(not bool)
    SetEntityInvincible(playerPed, not bool)
    FreezeEntityPosition(playerPed, not bool)
end