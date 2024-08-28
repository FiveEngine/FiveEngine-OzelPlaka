local QBCore = exports['qb-core']:GetCoreObject()
RegisterCommand(baTu.Komutnedir, function()
    TriggerServerEvent('baTu-plaka:adminchecker')
end)
RegisterNetEvent('baTu-plaka:komutlar')
AddEventHandler('baTu-plaka:komutlar', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle == 0 then
        QBCore.Functions.Notify("Araçta değilsiniz", "error")
        return
    end

    local dialog = exports['qb-input']:ShowInput({
        header = baTu.MenuHeader,
        submitText = baTu.OnayMesaji,
        inputs = {
            {
                text = baTu.InputdaYazicakMesaj,
                name = "plate",
                type = "text",
                isRequired = true,
                min = baTu.minimumplaka,
                max = baTu.maxplaka
            }
        }
    })
    if not dialog or not dialog.plate then
        QBCore.Functions.Notify("Plaka girişi iptal edildi", "error")
        return
    end
    local newPlate = dialog.plate
    if #newPlate < 2 or #newPlate > 8 then
        QBCore.Functions.Notify("Plaka 1 ile 8 karakter arasında olmalıdır", "error")
        return
    end
    local oldPlate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('baTu-plaka:ozelplaka', oldPlate, newPlate)
end)
RegisterNetEvent('baTu-plaka:guncellenmisplak', function(newPlate)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= 0 then
        SetVehicleNumberPlateText(vehicle, newPlate)
    end
end)
RegisterNetEvent('baTu-plaka:getVehicleInfo', function(oldPlate, newPlate, citizenid, playerName, playerID, steamHex, discordID)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle == 0 then
        TriggerEvent('QBCore:Notify', "Bu işlemi sadece araçtayken yapabilirsiniz", "error")
        return
    end
    local vehicleModel = GetEntityModel(vehicle)
    local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
    TriggerServerEvent('baTu-plaka:ozelplakaComplete', vehicleName, oldPlate, newPlate, citizenid, playerName, playerID, steamHex, discordID)
end)
