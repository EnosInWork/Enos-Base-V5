local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local LoadedPropList = {}
local coyottestate = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	if Config.ShowRadarProps then
		LoadRadarProps()
	end
end)

-- create radar props
function LoadRadarProps()
	local propName = 'prop_cctv_pole_01a'
	RequestModel(propName)
	while not HasModelLoaded(propName) do
		Citizen.Wait(100)
	end

	for k, v in pairs(Config.Radars) do
		local radar = CreateObject(GetHashKey(propName), v.x, v.y, v.z - 7, true, true, true)

		SetObjectTargettable(radar, true)
		SetEntityHeading(radar, v.heading - 115)
		SetEntityAsMissionEntity(radar, true, true)
		FreezeEntityPosition(radar, true)

		table.insert(LoadedPropList, radar)
	end
end

function UnloadRadarProps()
	for k, v in pairs(LoadedPropList) do
		DeleteEntity(v)
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		UnloadRadarProps()
	end
end)
local Blips = {}
RegisterNetEvent('esx_jb_radars:ShowRadarBlip')
AddEventHandler('esx_jb_radars:ShowRadarBlip', function()
	coyottestate = true
	for k,v in pairs (Config.Radars) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite  (blip, 1)
		SetBlipDisplay (blip, 4)
		SetBlipScale   (blip, 1.0)
		SetBlipCategory(blip, 3)
		SetBlipColour  (blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(('Radar fixe: %s (%s)'):format(k, v.maxSpeed))
		EndTextCommandSetBlipName(blip)
		table.insert(Blips, blip)
	end
end)

RegisterNetEvent('esx_jb_radars:ShowRadarProp')
AddEventHandler('esx_jb_radars:ShowRadarProp', function()
	LoadRadarProps()
end)

RegisterNetEvent('esx_jb_radars:RemoveRadarBlip')
AddEventHandler('esx_jb_radars:RemoveRadarBlip', function()
	coyottestate = false
	for i=1, #Blips, 1 do
		RemoveBlip(Blips[i])
		Blips[i] = nil
	end
end)

-- Determines if player is close enough to trigger cam
function HandlespeedCam(kmhSpeed, maxSpeed, Plate, vehicleModel, radarStreet)
	local fine = 0
	local TooMuchSpeed = tonumber(kmhSpeed) - tonumber(maxSpeed)
	if TooMuchSpeed >= 25 and TooMuchSpeed <= 50 then
		fine =500 + (TooMuchSpeed*Config.KmhFine)
	elseif TooMuchSpeed > 50 and TooMuchSpeed <= 100 then
		fine =750 + (TooMuchSpeed*Config.KmhFine)
	elseif TooMuchSpeed > 100 and TooMuchSpeed <= 125 then
		fine =1000 + (TooMuchSpeed*Config.KmhFine)
	elseif TooMuchSpeed > 125 and TooMuchSpeed <= 150 then
		fine =1250 + (TooMuchSpeed*Config.KmhFine)
	elseif TooMuchSpeed > 150 and TooMuchSpeed <= 175 then
		fine =1500 + (TooMuchSpeed*Config.KmhFine)
	elseif TooMuchSpeed > 175 then
		fine =1750 + (TooMuchSpeed*Config.KmhFine)
	end
	if TooMuchSpeed >= 25 then
		SetTimeout(math.random(Config.MinWaitTimeBeforeGivingFine*1000, Config.MaxWaitTimeBeforeGivingFine*1000), function()
			TriggerServerEvent('esx_jb_radars:PayFine',GetPlayerServerId(PlayerId()), Plate, kmhSpeed, maxSpeed, fine, vehicleModel, radarStreet)
		end)
	end
end

local highspeed = 0
local numberPlate = ""
local model = ""
local street1 = ""

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for k,v in pairs (Config.Radars) do
			local myPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(myPed, false)
			if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == myPed then
				local coords      = GetEntityCoords(myPed)
				local distance = GetDistanceBetweenCoords(v.x, v.y, v.z,coords, true)
				if distance < Config.SpeedCamRange then
					if coyottestate then
						SendNUIMessage({playsong = 'true', songname= ESX.Math.Round(v.maxSpeed / 10)*10})
					end
					while GetDistanceBetweenCoords(v.x, v.y, v.z, GetEntityCoords(myPed), true) < Config.SpeedCamRange do
						if GetVehicleClass(vehicle) ~= 18 then
							local kmhSpeed = math.ceil(GetEntitySpeed(vehicle)* 3.6)
							numberPlate = GetVehicleNumberPlateText(vehicle)
							local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0,v.x, v.y, v.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
							street1 = GetStreetNameFromHashKey(s1)
							model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
							if (tonumber(kmhSpeed) > tonumber(v.maxSpeed)) and (tonumber( highspeed) < tonumber(kmhSpeed)) then
								highspeed = kmhSpeed
							end
						end
						Citizen.Wait(100)
					end
					if highspeed ~= 0 then
						HandlespeedCam(highspeed, v.maxSpeed, numberPlate, model, street1)
						Citizen.Wait(500)
					end
					highspeed = 0
					Citizen.Wait(500)
				end
			end
		end
	end
end)

function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end
