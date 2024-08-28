fx_version "adamant"
game "gta5"
author 'baTu'
version '1.0.1'


server_script {
    'server/sv_plaka.lua',
    'server/version.lua'
}

client_script {
    'client/cl_plaka.lua'
}

shared_script {
    'config.lua'
}