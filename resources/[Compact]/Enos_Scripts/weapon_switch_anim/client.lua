Config = {}

-- Lägg till alla vapen det ska fungera på
Config.WeaponList = {
	-1716189206, --knife
	1737195953,
	1317494643,
	-1786099057,
	-2067956739,
	1141786504,
	-102323637,
	-1834847097,
	-102973651,
	-656458692,
	-581044007,
	-1951375401,
	-538741184,
	324215364,
	-619010992,
	736523883,
	2024373456,
	-270015777,
	171789620,
	-1660422300,
	2144741730,
	3686625920,
	1627465347,
	-1121678507,
	-1074790547,
	961495388,
	-2084633992,
	4208062921,
	-1357824103,
	-1063057011,
	2132975508,
	1649403952,
	100416529,
	205991906,
	177293209,
	-952879014,
	487013001,
	2017895192,
	-1654528753,
	-494615257,
	-1466123874,
	984333226,
	-275439685,
	317205821,
	-1568386805,
	-1312131151,
	1119849093,
	2138347493,
	1834241177,
	1672152130,
	1305664598,
	125959754,
	-1813897027,
	741814745,
	-1420407917,
	-1600701090,
	615608432,
	101631238,
	883325847,
	1233104067,
	600439132,
	126349499,
	-37975472,
	-1169823560,
}

Config.PedAbleToWalkWhileSwapping = true
Config.UnarmedHash = -1569615261

Citizen.CreateThread(function()
	local animDict = 'reaction@intimidation@1h'

	local animIntroName = 'intro'
	local animOutroName = 'outro'

	local animFlag = 0

	RequestAnimDict(animDict)
	  
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(100)
	end

	local lastWeapon = nil

	while true do
		Citizen.Wait(0)

		if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			if Config.PedAbleToWalkWhileSwapping then
				animFlag = 48
			else
				animFlag = 0
			end

			for i=1, #Config.WeaponList do
				if lastWeapon ~= nil and lastWeapon ~= Config.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.WeaponList[i] then
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.UnarmedHash, true)
					TaskPlayAnim(GetPlayerPed(-1), animDict, animIntroName, 8.0, -8.0, 2700, animFlag, 0.0, false, false, false)

					Citizen.Wait(1000)
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.WeaponList[i], true)
				end

				if lastWeapon ~= nil and lastWeapon == Config.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.UnarmedHash then
					TaskPlayAnim(GetPlayerPed(-1), animDict, animOutroName, 8.0, -8.0, 2100, animFlag, 0.0, false, false, false)

					Citizen.Wait(1000)
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.UnarmedHash, true)
				end
			end
		end

		lastWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
	end
end)