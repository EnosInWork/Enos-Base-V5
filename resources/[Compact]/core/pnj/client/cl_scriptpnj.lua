Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) 
		SetPedDensityMultiplierThisFrame(2.0) 
		SetRandomVehicleDensityMultiplierThisFrame(0.0) 
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) 
		SetVehicleModelIsSuppressed(GetHashKey("rubble"), true)
        SetVehicleModelIsSuppressed(GetHashKey("taco"), true)
        SetVehicleModelIsSuppressed(GetHashKey("biff"), true)
		SetGarbageTrucks(false) 
		SetRandomBoats(false) 
		SetCreateRandomCops(false) 
		SetCreateRandomCopsNotOnScenarios(false) 
		SetCreateRandomCopsOnScenarios(false) 
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);

        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then

            if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),false),-1) == GetPlayerPed(-1) then
                SetVehicleDensityMultiplierThisFrame(0.0)
                SetParkedVehicleDensityMultiplierThisFrame(0.0)
            else
                SetVehicleDensityMultiplierThisFrame(0.0)
                SetParkedVehicleDensityMultiplierThisFrame(0.0)
            end
        else
          SetParkedVehicleDensityMultiplierThisFrame(0.0)
          SetVehicleDensityMultiplierThisFrame(0.0)
        end
	end
end)