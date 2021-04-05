fx_version 'adamant'

game 'gta5'

server_script '@mysql-async/lib/MySQL.lua'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",

    "src/components/*.lua",

    "src/menu/elements/*.lua",

    "src/menu/items/*.lua",

    "src/menu/panels/*.lua",

    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

}


client_scripts {
	'accessories_shop/client/client.lua',
    'accessories_shop/client/config.lua',
    'clotheshop/client.lua'
}

server_scripts {
	'accessories_shop/server/server.lua',
    'clotheshop/server.lua'
}
