local LastVehicle = nil
local LicencePlate = {}
LicencePlate.Index = false
LicencePlate.Number = false

RegisterCommand("enleveplaque", function()
    if not LicencePlate.Index and not LicencePlate.Number then
        local PlayerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPed)
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        local VehicleCoords = GetEntityCoords(Vehicle)
        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)
        if Distance < 3.5 and not IsPedInAnyVehicle(PlayerPed, false) then
			LastVehicle = Vehicle
            Animation()
			SendNUIMessage({type = "ui",display = true,time = 6000,text = "vous enlevez la plaque..."}) --PROGRESSBAR
			StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
            Citizen.Wait(6000)
            LicencePlate.Index = GetVehicleNumberPlateTextIndex(Vehicle)
            LicencePlate.Number = GetVehicleNumberPlateText(Vehicle)
            SetVehicleNumberPlateText(Vehicle, " ")
        else
			TriggerEvent('esx:showNotification', '~r~ Pas de véhicule.')
        end
    else
		TriggerEvent('esx:showNotification', '~r~ Vous n/avez pas de plaques sur vous.')
    end
end)

RegisterCommand("remetplaque", function()
    if LicencePlate.Index and LicencePlate.Number then
        local PlayerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPed)
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        local VehicleCoords = GetEntityCoords(Vehicle)
        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)
        if ( (Distance < 3.5) and not IsPedInAnyVehicle(PlayerPed, false) ) then
		if (Vehicle == LastVehicle) then
				LastVehicle = nil
				Animation()
				SendNUIMessage({type = "ui",display = true,time = 6000,text = "Vous remettez la plaque..."}) --PROGRESSBAR
				StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
			Citizen.Wait(6000)
			SetVehicleNumberPlateTextIndex(Vehicle, LicencePlate.Index)
			SetVehicleNumberPlateText(Vehicle, LicencePlate.Number)
			LicencePlate.Index = false
			LicencePlate.Number = false
		else
			TriggerEvent('esx:showNotification', "~r~Cette plaque n'a pas sa place ici")
		end
        else
			TriggerEvent('esx:showNotification', "~r~Il n'y a pas de véhicule.")
        end
    else
		TriggerEvent('esx:showNotification', "~r~Vous n'avez pas de plaque d'immatriculation sur vous.")
    end
end)

---Animation
function Animation()
    local pid = PlayerPedId()
    RequestAnimDict("mini")
    RequestAnimDict("mini@repair")
    while (not HasAnimDictLoaded("mini@repair")) do 
		Citizen.Wait(10) 
	end
    TaskPlayAnim(pid,"mini@repair","fixing_a_player",1.0,-1.0, 5000, 0, 1, true, true, true)
end