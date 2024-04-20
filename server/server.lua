local Tunnel = module('frp_core', 'lib/Tunnel')
local Proxy = module('frp_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


RegisterNetEvent('PersonaCreatorHandler.setPlayerRoutingBucket')
AddEventHandler('PersonaCreatorHandler.setPlayerRoutingBucket', function()
    local _source = source
    SetPlayerRoutingBucket(_source, _source)
end)

RegisterNetEvent('PersonaCreatorHandler.setRoutingBucket')
AddEventHandler('PersonaCreatorHandler.setRoutingBucket', function(entityId)
    local _source = source
    SetEntityRoutingBucket(NetworkGetEntityFromNetworkId(entityId), _source)
end)


local function sliptStringToArray(string)
    local words = {}

    for word in string.gmatch(string, "%S+") do
        table.insert(words, word)
    end

    return words
end


RegisterNetEvent('PersonaCreatorHandler.requestCreatePersona')
AddEventHandler('PersonaCreatorHandler.requestCreatePersona', function(playerProfileCreation)
    local _source = source
    local User = API.getUserFromSource(_source)

    local names = sliptStringToArray(playerProfileCreation.name)

    local charId = User:createCharacter(names[1], names[2], playerProfileCreation.age, playerProfileCreation)

    if charId then
        -- local Character = User:setCharacter(charId)
        -- Character:setData(Character:getId(), "metaData", "hunger", 100)
        -- Character:setData(Character:getId(), "metaData", "thirst", 100)

        -- local encoded = json.encode({-1099.470,-1839.129,60.327})
        -- Character:setData(Character:getId(), "metaData", "position", encoded)

        User:setCharacter( charId ) -- Will draw itself
    end

    Wait(1000)

    SetPlayerRoutingBucket(_source, 0)

    TriggerClientEvent('FRP:CREATOR:FirstSpawn', _source)
end)


