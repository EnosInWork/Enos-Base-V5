fx_version 'adamant'
games { 'gta5' };

client_scripts {
    'ValUI/src/vMenu.lua',
    'ValUI/src/menu/ValUI.lua',
    'ValUI/src/menu/Menu.lua',
    'ValUI/src/menu/MenuController.lua',

    'ValUI/src/components/*.lua',

    'ValUI/src/menu/elements/*.lua',

    'ValUI/src/menu/items/*.lua',

    'ValUI/src/menu/panels/*.lua',

    'ValUI/src/menu/panels/*.lua',
    'ValUI/src/menu/windows/*.lua',
    
    
    'config.lua',
    'messages.lua',
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}