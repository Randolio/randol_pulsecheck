fx_version 'cerulean'
game 'gta5'

description 'Randolio Pulse Check'
version '1.0.0'

shared_scripts {
	'@ox_lib/init.lua',
}

client_scripts {
    'bridge/client/**.lua',
    'cl_pulse.lua',
}

server_scripts {
    'bridge/server/**.lua',
    'sv_pulse.lua',
}

lua54 'yes'
