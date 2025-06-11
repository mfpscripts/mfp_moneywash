fx_version 'bodacious'
game 'gta5'
  
description 'mfp_moneywash | Native UI'
author 'MFPSCRIPTS'
version '1.2'

lua54 'yes'

escrow_ignore {
	'config.lua',
	'client.lua',
}  

client_scripts {
  '@NativeUI/NativeUI.lua', -- enable if you're using NativeUI
  --'@NativeUILua_Reloaded/src/NativeUIReloaded.lua', -- enable if you're using NativeUI Reloaded
  'config.lua',
  'client.lua'
}

server_scripts {
  'config.lua',
  'server.lua'
}

-- shared_script '@es_extended/imports.lua' -- enable if you're using newest ESX version

-- visit mfp.tebex.io for more! --