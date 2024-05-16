fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
	"@ox_lib/init.lua",
	"@frp_lib/lib/utils.lua",
	"@frp_lib/lib/i18n.lua",
	"data/apparatus.lua",

	"locale/*.lua"
}

client_scripts {
	"config.lua",
	"client/main.lua",
	'framework.lua',
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