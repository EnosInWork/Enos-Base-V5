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

local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local PlayerData              = {}

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
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_ambulance', ('ambulance'), amount)
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

RMenu.Add('enos', 'main', RageUI.CreateMenu("Ambulance", "Intéraction"))
RMenu.Add('enos', 'ambulance', RageUI.CreateMenu("Ambulance", "Ambulance Garage"))
RMenu.Add('enos', 'annonce', RageUI.CreateSubMenu(RMenu:Get('enos', 'main'), "Annonces", "Intéraction"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('enos', 'main'), true, true, true, function()

          RageUI.ButtonWithStyle("Annonces",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
          end, RMenu:Get('enos', 'annonce'))

            RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.CloseAll()        
                    OpenBillingMenu() 
                end
            end)


            RageUI.ButtonWithStyle("Réanmier le patient",nil, {RightBadge = RageUI.BadgeStyle.Heart }, true, function(Hovered, Active, Selected)
                if Selected then
                    revivePlayer(closestPlayer)    
                end
            end)

            RageUI.ButtonWithStyle("Soigner le patient", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    heal()    
                end
            end)



     --   end
            
    end, function()
    end)

    RageUI.IsVisible(RMenu:Get('enos', 'annonce'), true, true, true, function()

      RageUI.ButtonWithStyle("Disponible",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
        if Selected then
          TriggerServerEvent('ambulanceOuvert')
        end
      end)
  
      RageUI.ButtonWithStyle("Indisponible",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
        if Selected then
          TriggerServerEvent('ambulanceFerme')
        end
      end)
  
      RageUI.ButtonWithStyle("Recrutement",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
        if Selected then
          TriggerServerEvent('RecrutementAmbulance')
        end
      end)

    end, function()
    end)

    RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end


function revivePlayer(closestPlayer)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 3.0 then
      ESX.ShowNotification(_U('no_players'))
    else
                      ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
                          if qtty > 0 then
              local closestPlayerPed = GetPlayerPed(closestPlayer)
              local health = GetEntityHealth(closestPlayerPed)
              if health == 0 then
                  local playerPed = GetPlayerPed(-1)
                  Citizen.CreateThread(function()
                    ESX.ShowNotification(_U('revive_inprogress'))
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Wait(10000)
                    ClearPedTasks(playerPed)
                    if GetEntityHealth(closestPlayerPed) == 0 then
                        TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                      TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                     -- ESX.ShowNotification(_U('revive_complete'))
                    else
                      ESX.ShowNotification(_U('isdead'))
                    end
                  end)
              else
                ESX.ShowNotification(_U('unconscious'))
              end
                          else
                              ESX.ShowNotification(_U('not_enough_medikit'))
                          end
                      end, 'medikit')
    end
  end


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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then 
        --    RegisterNetEvent('esx_policejob:onDuty')
            if IsControlJustReleased(0 ,167) then
                RageUI.Visible(RMenu:Get('enos', 'main'), not RageUI.Visible(RMenu:Get('enos', 'main')))
            end
        end
        end
    end)

    function revivePlayer(closestPlayer)
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
          ESX.ShowNotification(_U('no_players'))
        else
                          ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
                              if qtty > 0 then
                  local closestPlayerPed = GetPlayerPed(closestPlayer)
                  local health = GetEntityHealth(closestPlayerPed)
                  if health == 0 then
                      local playerPed = GetPlayerPed(-1)
                      Citizen.CreateThread(function()
                        ESX.ShowNotification(_U('revive_inprogress'))
                        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                        Wait(10000)
                        ClearPedTasks(playerPed)
                        if GetEntityHealth(closestPlayerPed) == 0 then
                            TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                          TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                         -- ESX.ShowNotification(_U('revive_complete'))
                        else
                          ESX.ShowNotification(_U('isdead'))
                        end
                      end)
                  else
                    ESX.ShowNotification(_U('unconscious'))
                  end
                              else
                                  ESX.ShowNotification(_U('not_enough_medikit'))
                              end
                          end, 'medikit')
        end
      end

    function heal()

        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestDistance > 1.0 then
            ESX.ShowNotification(_U('no_players'))
        else

        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)
                local health = GetEntityHealth(closestPlayerPed)

                if health > 0 then
                    local playerPed = PlayerPedId()

                    isBusy = true
                    ESX.ShowNotification(_U('heal_inprogress'))
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasks(playerPed)

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
                    TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
                    ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
                    isBusy = false
                else
                    ESX.ShowNotification(_U('player_not_conscious'))
                end
            else
                ESX.ShowNotification(_U('not_enough_bandage'))
            end
        end, 'bandage')
    end
    end

    AddEventHandler('esx:onPlayerDeath', function()
        OnPlayerDeath()
    end)
    
    RegisterNetEvent('esx_ambulancejob:revive')
    AddEventHandler('esx_ambulancejob:revive', function()
    end)

    RegisterNetEvent('esx_ambulancejob:heal')
    AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
        local playerPed = PlayerPedId()
        local maxHealth = GetEntityMaxHealth(playerPed)
            SetEntityHealth(playerPed, maxHealth)
    
        if not quiet then
            ESX.ShowNotification(_U('healed'))
        end
    end)

    function SendDistressSignal()
      local playerPed = PlayerPedId()
      PedPosition		= GetEntityCoords(playerPed)
      
      local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    
      ESX.ShowNotification(_U('distress_sent'))
    
        TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', _U('distress_message'), PlayerCoords, {
    
        PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
      })
    end

    
    RegisterNetEvent('openf6')
    AddEventHandler('openf6', function()
        RageUI.Visible(RMenu:Get('enos', 'main'), not RageUI.Visible(RMenu:Get('enos', 'main')))
    end)

    local blips = {
        -- Example {title="", colour=, id=, x=, y=, z=},
      
         {title="~g~Hôpital ~s~| L.S.M.S", colour=1, id=489, x = 293.241, y = -599.816, z = 43.30},
      
      }
          
      
      
      Citizen.CreateThread(function()    
        Citizen.Wait(0)    
      local bool = true     
      if bool then    
             for _, info in pairs(blips) do      
                 info.blip = AddBlipForCoord(info.x, info.y, info.z)
                             SetBlipSprite(info.blip, info.id)
                             SetBlipDisplay(info.blip, 4)
                             SetBlipScale(info.blip, 1.1)
                             SetBlipColour(info.blip, info.colour)
                             SetBlipAsShortRange(info.blip, true)
                             BeginTextCommandSetBlipName("STRING")
                             AddTextComponentString(info.title)
                             EndTextCommandSetBlipName(info.blip)
             end        
         bool = false     
       end
      end)
    