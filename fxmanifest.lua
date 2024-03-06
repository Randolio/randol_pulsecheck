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
    '@oxmysql/lib/MySQL.lua', -- need this for esx apparently to get death status.
    'bridge/server/**.lua',
    'sv_pulse.lua',
}

lua54 'yes'
