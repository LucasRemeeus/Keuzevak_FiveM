QBCore = exports['qb-core']:GetCoreObject()
ContractAccepted = false

-- Spawn mission giver
CreateThread(function()
	exports['qb-target']:SpawnPed({
		model = "g_m_m_chicold_01",
		coords = vector4(114.05, 6611.48, 31.86, 253.15),
		minusOne = true,
		spawnNow = true,
		blockevents = true,
		scenario = 'WORLD_HUMAN_SMOKING_POT',
		target = {
			useModel = false,
			options = {
				{
					num = 1,
					icon = 'fas fa-hands',
					label = 'Accept mission',
					action = function()
						QBCore.Functions.Notify('Mission Accepted, kill the police officer', 'success')
						SpawnPoliceOfficer()
						SetNewWaypoint(-447.63, 6027.61)
						ContractAccepted = true
					end
				},
				{
					num = 2,
					icon = 'fas fa-check',
					label = 'Finish mission',
					action = function()
						if QBCore.Functions.HasItem("filled_evidence_bag") then
							QBCore.Functions.Notify('Mission complete', 'success')
							TriggerServerEvent('eerste-resource:server:finishMission', "filled_evidence_bag")
							ContractAccepted = false
						else
							QBCore.Functions.Notify('No item found!', 'error')
						end
					end
				},
				{
					num = 3,
					icon = 'fas fa-car',
					label = 'Rent Car',
					action = function()
						TriggerServerEvent('eerste-resource:server:betaalBorg')
					end
				},
				
				{
					num = 4,
					icon = 'fas fa-car',
					label = 'Return Car (Get rent money back)',
					action = function()
						if IsPedInAnyVehicle(PlayerPedId(), true) then
							TriggerServerEvent('eerste-resource:server:returnBorg')
							DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
						else
							QBCore.Functions.Notify('Please enter vehicle to return', 'success')
						end
					end
				}
			},
			distance = 20,
		},
	})
end)

-- Spawn Police Officer
function SpawnPoliceOfficer()
	CreateThread(function()
		local weapon = "WEAPON_PISTOL"
		local pedModel = "s_f_y_ranger_01"
		local pedCoords = vector4(-447.63, 6027.61, 31.49, 348.27)

		RequestModel(GetHashKey(pedModel))
		while not HasModelLoaded(GetHashKey(pedModel)) do
			Wait(10)
		end

		NPC_PoliceOfficer = CreatePed(4, GetHashKey(pedModel), pedCoords.x, pedCoords.y, pedCoords.z, pedCoords.w, true, true)
		SetEntityAsMissionEntity(NPC_PoliceOfficer, true, true)
		SetModelAsNoLongerNeeded(GetHashKey(pedModel))
		SetBlockingOfNonTemporaryEvents(NPC_PoliceOfficer, true)
		TaskStartScenarioInPlace(NPC_PoliceOfficer, 'WORLD_HUMAN_SMOKING', 0, false)
		SetPedHasAiBlip(NPC_PoliceOfficer, true)
		SetPedAiBlipForcedOn(NPC_PoliceOfficer, true)
		GiveWeaponToPed(NPC_PoliceOfficer, weapon, 10, false, true)
		SetPedCanSwitchWeapon(NPC_PoliceOfficer, true)
		TaskCombatPed(NPC_PoliceOfficer, GetPlayerPed(-1), 0, 16)
		

		Wait(500)

		while true do
			Wait(500)
			if IsPedDeadOrDying(NPC_PoliceOfficer, true) then
				SetEntityAsMissionEntity(NPC_PoliceOfficer, false, false)
				QBCore.Functions.Notify('Evidence bag received. Return to gangster', 'success')
				SetNewWaypoint(114.05, 6611.48)
				TriggerServerEvent('eerste-resource:server:giveItem', "filled_evidence_bag", 1)
				break
			end
		end
	end)
end
