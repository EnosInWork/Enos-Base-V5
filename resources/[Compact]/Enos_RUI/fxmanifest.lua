fx_version 'adamant'

game 'gta5'

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
    '@es_extended/locale.lua',
    'dpemotes/cl_anim.lua',
    'DigitalDen/client.lua',
    'hs0_boatlocation/client.lua',
    'hs0_heliclocation/client.lua',
    'hs0_planelocation/client.lua',
    'location/locenos.lua',
    'hs0_bank/client.lua',
    'auto-ecole/client.lua',
    'rui_camera_lspd/client.lua',
    'blanchiment/client/client.lua',
    'ammu/client.lua',
    'shop/client.lua',
    'h4ci_garage/client.lua',
    'drogues/weed/cl_weed.lua',
    'drogues/coke/cl_coke.lua',
    'drogues/opium/cl_opium.lua',
    'drogues/meth/cl_meth.lua',
    'drogues/ecstasy/cl_ecstasy.lua',
    'drogues/lsd/cl_lsd.lua',
    'drogues/vente/vente.lua',
    'pnj_sale/cl_shop.lua',
    'sWipe/client/client.lua',
    'Propertiesmenu/client.lua',
    'NPC_Drugs_RageUI/cl_main.lua',
    'NPC_Drugs_RageUI/cl_functions.lua',
    'orangerun/cl_orange.lua',
    'h4ci_sautparachute/client.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'DigitalDen/server.lua',
    'hs0_boatlocation/server.lua',
    'hs0_heliclocation/server.lua',
    'hs0_planelocation/server.lua',
    'location/enoss.lua',
    'hs0_bank/server.lua',
    'auto-ecole/server.lua',
    'rui_camera_lspd/server.lua',
    'blanchiment/server.lua',
    'ammu/server.lua',
    'shop/server.lua',
    'h4ci_garage/server.lua',
    'drogues/server/server.lua',
    'pnj_sale/sv_shop.lua',
    'sWipe/server/server.lua',
    'Propertiesmenu/server.lua',
    'NPC_Drugs_RageUI/sv_main.lua',
    'orangerun/sv_orange.lua',
    'h4ci_sautparachute/server.lua'
}

dependencies {
	'es_extended'
}
