local amount = 1000

RegisterNetEvent('eerste-resource:server:betaalBorg', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player == nil then
        return
    end

    if Player.Functions.RemoveMoney('cash', amount, 'neon-borg') == false then
        TriggerClientEvent('QBCore:Notify', source, "Not enough money!", "error")
        return
    end

    TriggerClientEvent('eerste-resource:client:spawnNeon', source)
    TriggerClientEvent('QBCore:Notify', source, "Car rented", "success")
end)

RegisterNetEvent('eerste-resource:server:returnBorg', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player == nil then
        return
    end

    Player.Functions.AddMoney('cash', amount, 'neon-borg')
    TriggerClientEvent('QBCore:Notify', source, "Rental car money returned", "success")
end)