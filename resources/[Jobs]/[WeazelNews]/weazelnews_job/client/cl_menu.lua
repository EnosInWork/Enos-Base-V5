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

local PlayerData, CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false
blip = nil

local attente = 0

function OpenBillingMenu()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_journaliste', ('journaliste'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end


  ESX = nil

  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local PlayerData = {}
local ped = PlayerPedId()
local vehicle = GetVehiclePedIsIn( ped, false )
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
RMenu.Add('journaliste', 'main', RageUI.CreateMenu("WeazelNews", "Intéraction"))
RMenu.Add('journaliste', 'inter', RageUI.CreateSubMenu(RMenu:Get('journaliste', 'main'), "Weazel", "Intéraction"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('journaliste', 'main'), true, true, true, function()

		RageUI.ButtonWithStyle("Annonces",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
		end, RMenu:Get('journaliste', 'inter'))

	
		RageUI.ButtonWithStyle("Faire une facture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			if Selected then
				RageUI.CloseAll()        
				OpenBillingMenu() 
			end
		end)

		RageUI.ButtonWithStyle("Sortir la caméra",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				ExecuteCommand("cam")
			end
		end)

		RageUI.ButtonWithStyle("Sortir le micro",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				ExecuteCommand("mic") 
			end
		end)

		RageUI.ButtonWithStyle("Sortir le micro perche",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				ExecuteCommand("bmic")
			end
		end)

    end, function()
	end)


	RageUI.IsVisible(RMenu:Get('journaliste', 'inter'), true, true, true, function()

		RageUI.ButtonWithStyle("Ouvert",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('Open:Adss')
			end
		end)

		RageUI.ButtonWithStyle("Fermer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('Close:Adss')
			end
		end)

		RageUI.ButtonWithStyle("Recrutement",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				TriggerServerEvent('Recrutement:Ads')
			end
		end)

		RageUI.ButtonWithStyle("Personnalisée",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
			if Selected then
				local te = KeyboardInput("Message", "", 100)
				ExecuteCommand("wea " ..te)
			end
		end)

end, function()
end)

Citizen.Wait(0)
end
end)

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'journaliste' then 
        --    RegisterNetEvent('esx_journalistejob:onDuty')
            if IsControlJustReleased(0 ,167) then
                RageUI.Visible(RMenu:Get('journaliste', 'main'), not RageUI.Visible(RMenu:Get('journaliste', 'main')))
            end
        end
        end
    end)

    RegisterNetEvent('openf6')
    AddEventHandler('openf6', function()
    RageUI.Visible(RMenu:Get('journaliste', 'main'), not RageUI.Visible(RMenu:Get('journaliste', 'main')))
    end)


AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_journalistejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_journalistejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)


local blips = {
	-- Example {title="", colour=, id=, x=, y=, z=},
  
	 {title="Weazel News", colour=1, id=135, x = -545.97, y = -908.20, z = 23.0},
  
  }
	  
  
  
  Citizen.CreateThread(function()    
	Citizen.Wait(0)    
  local bool = true     
  if bool then    
		 for _, info in pairs(blips) do      
			 info.blip = AddBlipForCoord(info.x, info.y, info.z)
						 SetBlipSprite(info.blip, info.id)
						 SetBlipDisplay(info.blip, 4)
						 SetBlipScale(info.blip, 0.9)
						 SetBlipColour(info.blip, info.colour)
						 SetBlipAsShortRange(info.blip, true)
						 BeginTextCommandSetBlipName("STRING")
						 AddTextComponentString(info.title)
						 EndTextCommandSetBlipName(info.blip)
		 end        
	 bool = false     
   end
  end)


  ---------------------

  function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

-------------------------------

-- Garage

-------garage

RMenu.Add('garage', 'main', RageUI.CreateMenu("Garage", "Garage"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garage', 'main'), true, true, true, function() 
            RageUI.ButtonWithStyle("Ranger la voiture", "Pour ranger une voiture.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 4 then
                DeleteEntity(veh)
            end 
        end
    end) 

        RageUI.ButtonWithStyle("Van", "Pour sortir un van.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Citizen.Wait(1)  
            spawnuniCar("newsvan")
            end
        end)
            

            
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garage.position.x, Config.pos.garage.position.y, Config.pos.garage.position.z)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'journaliste' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'journaliste' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garage', 'main'), not RageUI.Visible(RMenu:Get('garage', 'main')))
                    end   
                end
               end 
        end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Config.pos.spawnvoiture.position.x, Config.pos.spawnvoiture.position.y, Config.pos.spawnvoiture.position.z, Config.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Weazel"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end

Citizen.CreateThread(function()
    local hash = GetHashKey("a_f_y_scdressy_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "a_f_y_scdressy_01", -616.6, -938.91, 21.13, 77.09, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)

