local Tunnel = module("frp_core", "lib/Tunnel")
local Proxy = module("frp_core", "lib/Proxy")

Tunnel.bindInterface("frp_creator", Game)
Proxy.addInterface("frp_creator", Game)