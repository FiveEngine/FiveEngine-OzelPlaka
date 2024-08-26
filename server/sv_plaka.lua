local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('baTu-plaka:ozelplaka', function(oldPlate, newPlate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local playerName = GetPlayerName(src)
    local playerID = tostring(src)
    local steamHex = string.format('%s', GetPlayerIdentifier(src, 0))
    local discordID = string.format('%s', GetPlayerIdentifier(src, 1))
    TriggerClientEvent('baTu-plaka:getVehicleInfo', src, oldPlate, newPlate, citizenid, playerName, playerID, steamHex, discordID)
end)
RegisterServerEvent('baTu-plaka:ozelplakaComplete')
AddEventHandler('baTu-plaka:ozelplakaComplete', function(vehicleName, oldPlate, newPlate, citizenid, playerName, playerID, steamHex, discordID)
    local src = source
    local result = exports.oxmysql:executeSync('UPDATE player_vehicles SET plate = ? WHERE plate = ? AND citizenid = ?', {
        newPlate, oldPlate, citizenid
    })
    if result.affectedRows and result.affectedRows > 0 then
        TriggerClientEvent('baTu-plaka:guncellenmisplak', src, newPlate)
        TriggerClientEvent('QBCore:Notify', src, "Plaka başarıyla güncellendi", "success")
        TriggerClientEvent('vehiclekeys:client:SetOwner', src, newPlate)
        TriggerClientEvent('QBCore:Notify', src, "Yeni araç anahtarını aldınız", "success")
        local message = {
            username = baTu.BotAdi,
            embeds = {
                {
                    title = baTu.MesajBilgisi,
                    color = 65280,
                    fields = {
                        { name = "Oyuncu", value = playerName, inline = true },
                        { name = "Oyuncu ID", value = playerID, inline = true },
                        { name = "Steam Hex", value = steamHex, inline = true },
                        { name = "Discord ID", value = discordID, inline = true },
                        { name = "Araç Modeli", value = vehicleName, inline = true },
                        { name = "Eski Plaka", value = oldPlate, inline = true },
                        { name = "Yeni Plaka", value = newPlate, inline = true },
                    },
                    footer = {
                        text = os.date('%Y-%m-%d %H:%M:%S'),
                    }
                }
            }
        }
        PerformHttpRequest(baTu.Vebhook, function(err, text, headers) end, 'POST', json.encode(message), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent('QBCore:Notify', src, "Plaka güncellenemedi", "error")
    end
end)
RegisterServerEvent('baTu-plaka:adminchecker')
AddEventHandler('baTu-plaka:adminchecker', function()
    local src = source
    if IsPlayerAceAllowed(src, "command") then
        TriggerClientEvent('baTu-plaka:komutlar', src)
    else
        TriggerClientEvent('QBCore:Notify', src, "Bu komutu sadece adminler kullanabilir", "error")
    end
end)

