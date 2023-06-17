QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('eerste-resource:server:giveItem', function(item, ammount)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player == nil then
        return
    end

    Player.Functions.AddItem(item, ammount)
end)

RegisterNetEvent('eerste-resource:server:finishMission', function(item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player == nil then
        return
    end

    Player.Functions.AddMoney('cash', 2000, 'Mission complete')
    Player.Functions.RemoveItem(item, 1)
end)