fx_version 'adamant'
game 'gta5'

shared_script 'config.lua'

server_scripts{
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
    '3dme/server.lua',
    'bennylift/server.lua',
    'znax-kevlar/server/main.lua',
    'replyandreport/server.lua',
    'notif/kylian_server.lua',
    'esx_blowtorch/server/main.lua',
    'esx_entitysync/server/main.lua',
    'clip/cl_clip.lua',
    'jumelle/jumelles_cl.lua',
    'heli/heli_client.lua',
    'esx_legacyfuel/source/fuel_server.lua'
} 

client_scripts{
	'@es_extended/locale.lua',
    '3dme/client.lua',
    'bennylift/client.lua',
    'znax-kevlar/client/main.lua',
    'replyandreport/client.lua',
    'weapon_switch_anim/client.lua',
    'divers/client/cl_cctv.lua',
	'divers/client/cl_pnjprison.lua',
	'divers/client/cl_tasereffet.lua',
    'esx_blowtorch/client/main.lua',
    'esx_entitysync/client/main.lua',
    'clip/sv_clip.lua',
    'jumelle/jumelles_sv.lua',
    'heli/heli_server.lua',
    'mhacking/mhacking.lua',
    'mhacking/sequentialhack.lua',
    'holsterweapon/client.lua',
    'holsterweapon/config.lua',
    'esx_legacyfuel/source/fuel_client.lua'
}

files {
    'mhacking/phone.png',
    'mhacking/snd/beep.ogg',
    'mhacking/snd/correct.ogg',
    'mhacking/snd/fail.ogg', 
    'mhacking/snd/start.ogg',
    'mhacking/snd/finish.ogg',
    'mhacking/snd/wrong.ogg',
    'mhacking/hack.html'
}


files {
    'weapons.meta',
    'weaponbullpuprifle.meta',
    'weaponcombatpdw.meta',
    'weaponcompactrifle.meta',
    'weaponflaregun.meta',
    'weapongusenberg.meta',
    'weaponheavypistol.meta',
    'weaponheavyshotgun.meta',
    'weaponmachinepistol.meta',
    'weaponmarksmanpistol.meta',
    'weaponmarksmanrifle.meta',
    'weaponmusket.meta',
    'weaponrevolver.meta',
    'weaponsnspistol.meta',
    'weaponvintagepistol.meta',

}

data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponbullpuprifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponcombatpdw.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponcompactrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponflaregun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weapongusenberg.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponheavypistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponheavyshotgun.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponmachinepistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponmarksmanpistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponmarksmanrifle.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponmusket.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponrevolver.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponsnspistol.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'weaponvintagepistol.meta'

files {
    'audio/sfx/resident/explosions.awc',
    'audio/sfx/resident/vehicles.awc',
    'audio/sfx/resident/weapons.awc',
    'audio/sfx/weapons_player/lmg_combat.awc',
    'audio/sfx/weapons_player/lmg_mg_player.awc',
    'audio/sfx/weapons_player/mgn_sml_am83_vera.awc',
    'audio/sfx/weapons_player/mgn_sml_am83_verb.awc',
    'audio/sfx/weapons_player/mgn_sml_sc__l.awc',
    'audio/sfx/weapons_player/ptl_50cal.awc',
    'audio/sfx/weapons_player/ptl_combat.awc',
    'audio/sfx/weapons_player/ptl_pistol.awc',
    'audio/sfx/weapons_player/ptl_px4.awc',
    'audio/sfx/weapons_player/ptl_rubber.awc',
    'audio/sfx/weapons_player/sht_bullpup.awc',
    'audio/sfx/weapons_player/sht_pump.awc',
    'audio/sfx/weapons_player/smg_micro.awc',
    'audio/sfx/weapons_player/smg_smg.awc',
    'audio/sfx/weapons_player/snp_heavy.awc',
    'audio/sfx/weapons_player/snp_rifle.awc',
    'audio/sfx/weapons_player/spl_grenade_player.awc',
    'audio/sfx/weapons_player/spl_minigun_player.awc',
    'audio/sfx/weapons_player/spl_prog_ar_player.awc',
    'audio/sfx/weapons_player/spl_railgun.awc',
    'audio/sfx/weapons_player/spl_rpg_player.awc',
    'audio/sfx/weapons_player/spl_tank_player.awc',
  }
  
data_file 'AUDIO_WAVEPACK' 'audio/sfx/resident'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/weapons_player'

exports {
	'GetFuel',
	'SetFuel'
}
