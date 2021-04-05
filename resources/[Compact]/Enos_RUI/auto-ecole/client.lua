ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)

local CurrentTest           = nil
local CurrentCheckPoint     = 0
local DriveErrors 		    = 0
local LastCheckPoint        = -1
local CurrentBlip           = nil
local CurrentZoneType       = nil
local IsAboveSpeedLimit     = false
local VehicleHealth     	= nil
local success               = false
local pieton                = false
local startedconduite 		= false
local drivetest = nil
local cvrai = 0
local blockitvoiture = false
local blockitmoto = false
local blockitcamion = false
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
permisencours = ""
-----------------------------------------------------------------------------------------------------------------------

local function StopDriveTest(success)
	if success then
		TriggerServerEvent('haciadmin:addpermis', permisencours)
		RemoveBlip(CurrentBlip)
		ESX.ShowAdvancedNotification('Amanda', '~r~Bravo~w~', 'Vous avez reçu votre permis !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
	else
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
		ESX.ShowAdvancedNotification('Amanda', '~r~Malheureusement~w~', 'Vous avez raté le test !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')			
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end
	end
	SetEntityCoords(pietonped, 394.12, -111.84, 65.23, false, false, false, true)
	SetEntityHeading(pietonped, 234.62)
	CurrentTest     = nil
	CurrentTestType = nil
end


local function SetCurrentZoneType(type)
    CurrentZoneType = type
end


local CheckPoints = {

	{
		Pos = {x = 216.204, y = 370.29, z = 106.323},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Allons sur la route, tournez à gauche, vitesse limitée à~w~ ~y~80km/h", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 236.32, y = 346.78, z = 105.57},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 403.16, y = 300.05, z = 103.00},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attentions au feu", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 548.00, y = 247.555, z = 103.09},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attentions au feu", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 658.73, y = 213.41, z = 95.93},
        Action = function(playerPed, setCurrentZoneType)
            ESX.ShowAdvancedNotification('Amanda', 'Tournez !~w~', "Tournez à droite, n'oubliez pas vos clignotants", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 670.106, y = 194.68, z = 93.19},
		Action = function(playerPed, setCurrentZoneType)
            ESX.ShowAdvancedNotification('Amanda', 'Zone résidentielle !~w~', "Vous entrez dans une zone résidentielle, limite ~y~50km/h", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 0
		end
	},

	{
		Pos = {x = 625.11, y = 69.87, z = 90.11},
		Action = function(playerPed, setCurrentZoneType)
			setCurrentZoneType('town')
            ESX.ShowAdvancedNotification('Amanda', 'Tournez~w~', "Prenez à droite, vitesse limite ~y~80km/h", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 534.88, y = 75.044, z = 96.37},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Tournez à gauche quand le feu est vert", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 484.05, y = 39.68, z = 92.18},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Allez vers le prochain passage", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},	

	{
		Pos = {x = 401.702, y = -108.51, z = 65.19}, 
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Laissez passer le pieton.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL') --## 393.65, -111.565, 65.29
			TesOuFDPRendMonQuad = 1
			pieton = true
		end
	},
 --
	{
		Pos = {x = 358.86, y = -245.34, z = 53.97},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 317.28, y = -362.89, z = 45.25},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 294.85, y = -456.19, z = 43.28},
		Action = function(playerPed, setCurrentZoneType)
			setCurrentZoneType("freeway")
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Tournez à droite, vitesse limitée à~y~ 120km/h.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = 68.52, y = -479.70, z = 34.06},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -138.31, y = -494.899, z = 29.42},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -688.59, y = -497.28, z = 25.19},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -989.10, y = -546.41, z = 18.35},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Ralentissez.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -1157.47, y = -638.79, z = 22.72},
		Action = function(playerPed, setCurrentZoneType)
			setCurrentZoneType("town")
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Tournez à gauche vitesse limite ~y~80km/h.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = -1142.446, y = -691.37, z = 21.63},
		Action = function(playerPed, setCurrentZoneType)
			setCurrentZoneType("freeway")
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Tournez à gauche, attention au feu.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -1016.85, y = -616.55, z = 18.26},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit, vitesse limite ~y~120km/h.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -849.54, y = -541.89, z = 22.83},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -490.50, y = -530.48, z = 25.33},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = -26.30, y = -527.42, z = 33.25},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit, préparez vous à tournez à droite et ralentissez.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 2
		end
	},

	{
		Pos = {x = 91.53, y = -544.01, z = 33.84},
		Action = function(playerPed, setCurrentZoneType)
			setCurrentZoneType("town")
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit, vitesse limitée à ~y~80km/h.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 252.99, y = -543.60, z = 43.21},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Tournez à gauche, attention au feu.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 306.79, y = -459.09, z = 43.32},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 318.32, y = -410.10, z = 45.12},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu, continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 351.15, y = -293.01, z = 53.88},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu, continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 400.48, y = -149.67, z = 64.69},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu, continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},
	
	{
		Pos = {x = 508.28, y = 56.62, z = 95.80},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu, continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},
	
	{
		Pos = {x = 563.84, y = 228.76, z = 103.04},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu, tournez à gauche.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 437.77, y = 293.12, z = 102.99},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu, continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 275.69, y = 337.76, z = 105.51},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Attention au feu, continuez tout droit.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 223.73, y = 356.74, z = 105.85},
		Action = function(playerPed, setCurrentZoneType)
			ESX.ShowAdvancedNotification('Amanda', 'Bien~w~', "Tournez à droite.", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
			TesOuFDPRendMonQuad = 1
		end
	},

	{
		Pos = {x = 213.72, y = 389.25, z = 106.84},
		Action = function(playerPed, setCurrentZoneType)
			startedconduite = false
			if DriveErrors < 5 then
				StopDriveTest(true)
			else
				StopDriveTest(false)
			end
		end
	},

}


local function GoToTargetWalking()
	pieton = false
	FreezeEntityPosition(pietonped, false)
    TaskGoToCoordAnyMeans(pietonped, 414.1815, -124.91, 63.71, 1.0, 0, 0, 786603, 0xbf800000)
    distanceToTarget = GetDistanceBetweenCoords(pietonped, 414.1815, -124.91, 63.71, true)
    if distanceToTarget <= 1 then
        FreezeEntityPosition(pietonped, true)
    end
end


local function StartConduite()
	startedconduite = true
	while startedconduite do
		Wait(0)

		if CurrentTest == 'drive' then

			if pieton then
				GoToTargetWalking()
			end

			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				while not IsPedheadshotReady(RegisterPedheadshot(PlayerPedId())) or not IsPedheadshotValid(RegisterPedheadshot(PlayerPedId())) do
					Wait(100)
				end
		
				BeginTextCommandThefeedPost("PS_UPDATE")
				AddTextComponentInteger(50)
			
				EndTextCommandThefeedPostStats("PSF_DRIVING", 14, 50, 25, false, GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())), GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())))
			
				EndTextCommandThefeedPostTicker(false, true)
				
				UnregisterPedheadshot(RegisterPedheadshot(PlayerPedId()))

			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 90.0 then
					DrawMarker(36, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPoints[nextCheckPoint].Action(PlayerPedId(), SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end

			----------

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then

				local vehicle      = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local speed        = GetEntitySpeed(vehicle) * 3.6
				local tooMuchSpeed = false
				local GetSpeed = math.floor(GetEntitySpeed(vehicle) * 3.6)
				local speed_limit_residence = 50.0
				local speed_limit_ville = 80.0
				local speed_limit_otoroute = 120.0

				local DamageControl = 0

				if TesOuFDPRendMonQuad == 0 and GetSpeed >= speed_limit_residence then
					tooMuchSpeed 	  = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					ESX.ShowAdvancedNotification('Amanda', '~r~Vous avez fait une erreur~w~', "Vous roulez trop vite, vitesse limite : " ..speed_limit_residence.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000) -- evite bug
				end

				if TesOuFDPRendMonQuad == 1 and GetSpeed >= speed_limit_ville then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					ESX.ShowAdvancedNotification('Amanda', '~r~Vous avez fait une erreur~w~', "Vous roulez trop vite, vitesse limite : " ..speed_limit_ville.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if TesOuFDPRendMonQuad == 2 and GetSpeed >= speed_limit_otoroute then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					ESX.ShowAdvancedNotification('Amanda', '~r~Vous avez fait une erreur~w~', "Vous roulez trop vite, vitesse limite : " ..speed_limit_otoroute.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if HasEntityCollidedWithAnything(vehicle) and DamageControl == 0 then
					DriveErrors       = DriveErrors + 1
					ESX.ShowAdvancedNotification('Amanda', '~r~Vous avez fait une erreur~w~', "Votre vehicule c\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				if GetEntityHealth(vehicle) < GetEntityHealth(vehicle) then

					DriveErrors = DriveErrors + 1

					ESX.ShowAdvancedNotification('Amanda', '~r~Vous avez fait une erreur~w~', "Votre vehicule c\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					
					VehicleHealth = GetEntityHealth(vehicle)
					Wait(2000)
				end
				if DriveErrors >= 5 then
					CurrentCheckPoint = 10
					RemoveBlip(CurrentBlip)
					SetNewWaypoint(204.82, 377.133)
					DrawMarker(36, 204.82, 377.133, 107.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					local dist = Vdist2(GetEntityCoords(PlayerPedId()), 204.82, 377.133, 107.24)
					if dist <= 2.5 then
						HelpNotif("Appuyez sur ~INPUT_TALK~ pour rendre le véhicule.")
						if IsControlJustPressed(0, 51) then
							StopDriveTest(false)
							DriveErrors = 0
							CurrentCheckPoint = 0
							RemoveBlip(CurrentBlip)
						end
					end
				end
			end
		else -- si jamais il prend pas en compte
			Wait(500)
		end
	end
end

local function StartDriveTest()
	CurrentTest       = 'drive'
	CurrentTestType   = type
	startedconduite = true
    permisencours = "drive"
	drivetest = "voiture"

	RequestModel(GetHashKey("rhapsody"))

	while not HasModelLoaded(GetHashKey("rhapsody")) do
        Wait(100)
    end

	local veh = CreateVehicle(GetHashKey("rhapsody"), 213.61, 389.34, 106.85, 171.44, 1, 0)
	TaskEnterVehicle(GetPlayerPed(-1), veh, 20000, -1, 2.0, 3, 0)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	ESX.ShowAdvancedNotification('Amanda', '~r~Me voila !~w~', 'Tenez votre voiture, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')

	StartConduite()
end

local function StartDriveTestMoto()
	CurrentTest = 'drive'
	startedconduite = true
permisencours = "bike"
	drivetest = "moto"

	RequestModel(GetHashKey("bati"))

	while not HasModelLoaded(GetHashKey("bati")) do
        Wait(100)
	end
	
    local veh = CreateVehicle(GetHashKey("bati"), 213.61, 389.34, 106.85, 171.44, 1, 0)
	TaskEnterVehicle(GetPlayerPed(-1), veh, 20000, -1, 2.0, 3, 0)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	ESX.ShowAdvancedNotification('Amanda', '~r~Me voila !~w~', 'Tenez votre moto, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')

	StartConduite()
end

local function StartDriveTestCamion()
	CurrentTest = 'drive'
permisencours = "truck"
	drivetest = "camion"

	startedconduite = true

	RequestModel(GetHashKey("mule"))

	while not HasModelLoaded(GetHashKey("mule")) do
        Wait(100)
	end
	
    local veh = CreateVehicle(GetHashKey("mule"), 213.61, 389.34, 106.85, 171.44, 1, 0)
	TaskEnterVehicle(GetPlayerPed(-1), veh, 20000, -1, 2.0, 3, 0)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	ESX.ShowAdvancedNotification('Amanda', '~r~Me voila !~w~', 'Tenez votre camion, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')

	StartConduite()
end

------------------------------------------------------------------------------------------------------------------------

RMenu.Add('permis', 'main', RageUI.CreateMenu("Permis", "~b~Bienvenue à l\'auto-ecole"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('permis', 'main'), true, true, true, function()

				RageUI.ButtonWithStyle("Passer le permis voiture", "Passer le permis voiture pour 1200$.", { RightLabel = "1200$" }, true, function(_, _, Selected)
					if Selected then
						StartDriveTest()
						RageUI.CloseAll()
					end
				end)

                    RageUI.ButtonWithStyle("Passer le permis moto", "Passer le permis moto pour 1000$.", { RightLabel = "1000$" }, true, function(_, _, Selected)
                        if Selected then
                            StartDriveTestMoto()
                            RageUI.CloseAll()
                        end
                    end)
    
                    RageUI.ButtonWithStyle("Passer le permis camion", "Passer le permis camion pour 1500$.", { RightLabel = "1500$" }, true, function(_, _, Selected)
                        if Selected then
                            StartDriveTestCamion()
                            RageUI.CloseAll()
                        end
                    end)

        end, function()
        end)

        Citizen.Wait(0)
    end
end)

    ---------------------------------------- Position du Menu --------------------------------------------

    Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            while true do
                Wait(0)
        
                    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                    if IsEntityAtCoord(PlayerPedId(), 228.21, 373.4, 106.11, 1.5, 1.5, 1.5, 0, 1, 0) then 
                        
                              RageUI.Text({
                                message = "[~b~E~w~] Pour ouvrir le menu d'auto-école",
                                time_display = 1
                            })
                                if IsControlJustPressed(1, 51) then
                                    RageUI.Visible(RMenu:Get('permis', 'main'), not RageUI.Visible(RMenu:Get('permis', 'main')))
                                end
                            end
                    end    
            end)

    

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end


CreateThread(function()
    local hash = GetHashKey("cs_bankman")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(2000)
    end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_bankman", 228.55, 374.62, 105.11, 161.96, false, true) 
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	
	local blipauto = AddBlipForCoord(228.55, 374.62, 105.11)
	SetBlipSprite (blipauto, 525)
	SetBlipDisplay(blipauto, 4)
	SetBlipScale  (blipauto, 0.7)
	SetBlipAsShortRange(blipauto, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Auto-école")
	EndTextCommandSetBlipName(blipauto)
end)