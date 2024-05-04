fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
	"@ox_lib/init.lua",
	"@frp_core/lib/utils.lua",
	"data/apparatus.lua"
}

client_scripts {
	"config.lua",
	"client/main.lua",
	"client/inputs.lua",
	"client/scene.lua",
	"client/player.lua",
	"client/utils.lua",
}

server_scripts {
	'server/main.lua',
	'server/utils.js'
}

lua54 'yes'