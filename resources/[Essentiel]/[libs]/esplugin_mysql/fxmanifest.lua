fx_version 'bodacious'
games { 'rdr3', 'gta5' }

author 'Kanersps'
description 'A MySQL plugin for EssentialMode'

--[[migration_files {
    'migrations/0001_create_user.cs',
	'migrations/0002_add_roles.cs'
}]]

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	--'@fxmigrant/helper.lua',
	'server.lua'
}

dependencies {
	'essentialmode',
	'mysql-async'
	--'fxmigrant'
}
