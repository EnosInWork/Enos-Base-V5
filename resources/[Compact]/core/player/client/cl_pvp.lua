AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

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

---KO
local knockedOut = false
local wait = 15
local count = 60

Citizen.CreateThread(function()
	while true do
		Wait(1)
		local myPed = GetPlayerPed(-1)
		if IsPedInMeleeCombat(myPed) then
			if GetEntityHealth(myPed) < 115 then
				SetPlayerInvincible(PlayerId(), true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				ShowNotification("ðŸ¤¬ TU ES ~r~K.O!")
				wait = 15
				knockedOut = true
				SetEntityHealth(myPed, 116)
			end
		end
		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
					SetEntityHealth(myPed, GetEntityHealth(myPed)+4)
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
	end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end