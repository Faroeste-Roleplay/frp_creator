fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	"@ox_lib/init.lua",
	"@frp_core/lib/utils.lua",
	"@frp_core/data/Components.lua",
	"@frp_core/data/Overlays.js",

    'config.lua',
	--'config/components.lua',
	--'config/overlay.js',
	'config/data_ui.js',

	'client/customization.lua',
	'client/scene.lua',
	'client/spawn.lua',
	--'client/overlay.lua',
}

server_scripts {
	"@frp_core/lib/utils.lua",
	'server/server.lua'
}

dependencies {
    '/onesync',
    '/native:0x635E5289',
    '/native:0x6504EB38',
}

files{
	'./ui/*',
	'./ui/css/*',
	'./ui/js/*',
	'./ui/img/*.png'
}

ui_page 'ui/index.html'

exports {	
	'setOverlayData',
	'colorPalettes',
	'textureTypes',
	'overlaysInfo',
	'clothOverlayItems',
	'overlayAllLayers',
	'setOverlaySelected',
	'getDataCreator'
}


lua54 'yes'