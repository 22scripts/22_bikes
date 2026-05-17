fx_version 'cerulean'
game 'gta5'
author '22scripts, xLaugh'
version '1.0.1'

lua54 'yes'

escrow_ignore {
    'config.lua',
    'bridge/client.lua',
    'bridge/server.lua',
    'client/client.lua',
    'server/server.lua'
}

dependencies {
    'ox_inventory',
    'ox_target'
}

shared_scripts {
    'config.lua'
}

client_scripts {
    'bridge/client.lua',
    'client/client.lua'
}

server_scripts {
    'bridge/server.lua',
    'server/server.lua'
}
