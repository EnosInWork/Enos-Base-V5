description 'Script made by Jager Bom'

ui_page 'html/ui.html'
client_script { 
	"esx_jb_radars_cl.lua",
	"config.lua",
}
	
server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"esx_jb_radars_sv.lua",
	"config.lua",
	-- 'version.lua',
}

files {
	'html/sound/Rf30.ogg',
	'html/sound/Rf50.ogg',
	'html/sound/Rf70.ogg',
	'html/sound/Rf80.ogg',
	'html/sound/Rf90.ogg',
	'html/sound/Rf110.ogg',
	'html/sound/Rf120.ogg',
	'html/sound/Rf130.ogg',
	'html/ui.html',
	'html/app.js',
}