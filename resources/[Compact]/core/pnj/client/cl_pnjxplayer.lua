local vehWeapons = {
	0x1D073A89, -- Fusil à Pompe
	0x83BF0278, -- M4
	0x5FC3C11, -- Sniper
}
local pedindex = {}
local hasBeenInPoliceVehicle = false
local alreadyHaveWeapon = {}

---Réduit les dégats
Citizen.CreateThread(function()
    while true do
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.3) --Dégâts Coups de poigs
    N_0x4757f00bc6323cfe(-1553120962, 0.2) --Dégâts Véhicules
	Wait(0)
    end
end)

---Désactive les coups de crosse
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	       DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

---Désactive les étoiles de recherches

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisablePlayerVehicleRewards(PlayerId())
    end
end)

--Désactive le spawn des pnj de police

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 100.0, 0)
    end
end)

Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
       
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
    end
end)

---Désactive les armes drop par les pnj

function SetWeaponDrops() -- This function will set the closest entity to you as the variable entity.
    local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    repeat 
        if not IsEntityDead(ped) then
                pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then -- set all peds to not drop weapons on death.
            SetPedDropsWeaponsWhenDead(peds, false) 
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        SetWeaponDrops()
    end
end)

---Supprime les armes des véhicules de pnj

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
			if(not hasBeenInPoliceVehicle) then
				hasBeenInPoliceVehicle = true
			end
		else
			if(hasBeenInPoliceVehicle) then
				for i,k in pairs(vehWeapons) do
					if(not alreadyHaveWeapon[i]) then
						TriggerServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon",k)
					end
				end
				hasBeenInPoliceVehicle = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
			for i=1,#vehWeapons do
				if(HasPedGotWeapon(GetPlayerPed(-1), vehWeapons[i], false)==1) then
					alreadyHaveWeapon[i] = true
				else
					alreadyHaveWeapon[i] = false
				end
			end
		end
		Citizen.Wait(5000)
	end
end)

RegisterNetEvent("PoliceVehicleWeaponDeleter:drop")
AddEventHandler("PoliceVehicleWeaponDeleter:drop", function(wea)
	RemoveWeaponFromPed(GetPlayerPed(-1), wea)
end)

---Enleve le réticule

Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)

    	local ped = GetPlayerPed(-1)
		local currentWeaponHash = GetSelectedPedWeapon(ped)

		if currentWeaponHash == 100416529 then
			isSniper = true
		elseif currentWeaponHash == 205991906 then
			isSniper = true
		elseif currentWeaponHash == -952879014 then
			isSniper = true
		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
		else
			isSniper = false
		end

		if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)