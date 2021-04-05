fx_version 'adamant'
games { 'gta5' };

name 'Original_progressbar';
description 'Porgressbar faite par d4rktoxe pour Original'

client_script {
    'client/main.lua'
}
  
ui_page {
  'ui/index.html'
}

files {
  'ui/index.html',
  'ui/style.css',
}

exports {
  'AfficherProgressbar',
  'CacherProgressbar'
}

client_scripts {
  "AC-Sync.lua",
}
