fx_version 'adamant'

game 'gta5'

files {
    "index.html"
}

ui_page_preload "index.html"

loadscreen "index.html"


client_scripts {
    'client.lua',
    'hud_xtrem/client.lua'
}

server_scripts {
    'server.lua',
    'hud_xtrem/server.lua'
}

ui_page 'hud_xtrem/html/ui.html'

files {
	-- Main Images
	'hud_xtrem/html/ui.html',
	'hud_xtrem/html/style.css',
	'hud_xtrem/html/grid.css',
	'hud_xtrem/html/main.js',
	'hud_xtrem/html/font/pricedown.ttf',
	-- Money Images
	'hud_xtrem/html/img/credit-card.png',
	'hud_xtrem/html/img/money-bag.png',
	'hud_xtrem/html/img/wallet.png',
	'hud_xtrem/html/img/bank.png'
}

