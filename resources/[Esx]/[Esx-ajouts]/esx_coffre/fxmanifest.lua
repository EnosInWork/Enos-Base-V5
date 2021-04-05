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
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/classes/c_truck.lua',
  'server/truck.lua',
  'server/main.lua'
}