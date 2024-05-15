local Tunnel = module("frp_lib", "lib/Tunnel")
local Proxy = module("frp_lib", "lib/Proxy")

API = Tunnel.getInterface("API")
cAPI = Proxy.getInterface("API")

Tunnel.bindInterface("frp_creator", Game)
Proxy.addInterface("frp_creator", Game)

Appearance = Proxy.getInterface("frp_appearance")
SpawnSelector = Proxy.getInterface("frp_spawn_selector")
