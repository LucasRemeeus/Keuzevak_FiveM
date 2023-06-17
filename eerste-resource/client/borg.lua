SpawnPoint = vector4(122.76, 6609.19, 31.54, 313.54)

RegisterNetEvent('eerste-resource:client:spawnNeon', function()
    QBCore.Functions.SpawnVehicle('neon', function(veh)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true, false)
    end, SpawnPoint, true, true)
end)