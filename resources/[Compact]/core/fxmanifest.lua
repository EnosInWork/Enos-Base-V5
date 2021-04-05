fx_version 'cerulean'
game 'gta5'
Auteur 'Riyane'

ui_page 'enleverplaque.html'

client_scripts {
	'player/config.lua',
	'player/client/cl_3dme.lua',
	'player/client/cl_chasse.lua',
	'player/client/cl_pvp.lua',
	'player/client/cl_recul.lua',
	'player/client/cl_hud.lua',
	'player/client/cl_weaponanim.lua',
	'player/client/server_name.lua',
	'player/client/cl_drift.lua',
	'player/client/cl_kevlar.lua',
	'player/client/cl_weaponme.lua',
	'player/client/cl_switchanim.lua',
	'player/client/ShowID.lua',
	'pnj/client/cl_aircontrol.lua',
	'pnj/client/cl_calmai.lua',
	'pnj/client/cl_delarmecar.lua',
	'pnj/client/cl_disabledispatch.lua',
	'pnj/client/cl_pnjxplayer.lua',
	'pnj/client/cl_removecops.lua',
	'pnj/client/cl_scriptpnj.lua',
	'vehicules/client/cl_changerplace.lua',
	'vehicules/client/cl_degats.lua',
	'vehicules/client/cl_enleverplaque.lua',
	'vehicules/client/cl_hideintrunk.lua',
	'vehicules/client/cl_vehiclepush.lua',
	'vehicules/client/cl_sirene.lua',
	'vehicules/client/cl_sireneenumerator.lua',
	'vehicules/client/cl_sireneinstructions.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'player/config.lua',
	'player/server/sv_3dme.lua',
	'player/server/sv_chasse.lua',
	'pnj/server/sv_delarmecar.lua',
	'pnj/server/sv_pnjxplayer.lua',
	'pnj/server/sv_scriptpnj.lua',
	'vehicules/server/sv_degats.lua',
}

files {
	'pnj/files/events.meta',
	'pnj/files/relationships.dat',
	'vehicules/html/enleverplaque.html',
	'vehicules/sirene/include.lua'
}

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'pnj/files/events.meta'

export 'SetInstructionalButton'

client_scripts {
	'@es_extended/locale.lua',
	'needs/locales/fr.lua',
	'needs/config.lua',
	'needs/client/cl_basicneeds.lua',
	'needs/client/cl_drugeffects.lua',
	'needs/client/cl_optionalneeds.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'needs/locales/fr.lua',
	'needs/config.lua',
	'needs/server/sv_basicneeds.lua',
	'needs/server/sv_drugeffects.lua',
	'needs/server/sv_optionalneeds.lua'
}