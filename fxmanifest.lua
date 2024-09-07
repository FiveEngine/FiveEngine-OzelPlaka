fx_version "adamant"
game "gta5"
author 'baTu'
description 'FiveEngine Discord: https://discord.gg/e9heam9b6S'
version '1.0.4'


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
