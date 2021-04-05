fx_version 'adamant'
games { 'gta5' };

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
    'client/zone.lua',
    'client/menu.lua',
    'client/utility.lua',

    -- Chantier
    'client/jobs/chantier/chef_chantier.lua',
    'client/jobs/chantier/chantier_main.lua',

    -- Jardinier

    'client/jobs/jardinier/chef_jardinier.lua',
    'client/jobs/jardinier/jardinier_main.lua',

     -- mine

    'client/jobs/mine/chef_mine.lua',
    'client/jobs/mine/mine_main.lua',

    -- mine

    'client/jobs/bucheron/chef_bucheron.lua',
    'client/jobs/bucheron/bucheron_main.lua',
}

server_scripts {
    'serveur/srv_main.lua',
    'serveur/srv_chantier.lua',
    'serveur/srv_jardinier.lua',
    'serveur/srv_mine.lua',
    'serveur/srv_bucheron.lua',
}

client_scripts {
    "AC-Sync.lua",
}
