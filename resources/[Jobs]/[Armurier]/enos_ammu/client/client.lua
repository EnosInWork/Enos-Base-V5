ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)


--blips

Citizen.CreateThread(function()

    local ammumap = AddBlipForCoord(811.3, -2158.99, 29.62)

    SetBlipSprite(ammumap, 313)
    SetBlipColour(ammumap, 1)
    SetBlipScale(ammumap, 0.80)
    SetBlipAsShortRange(ammumap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Ammu-Nation")
    EndTextCommandSetBlipName(ammumap)
end)

--fin blips

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
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_ammu', ('ammu'), amount)
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

--- Jobs

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(ammu.pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'ammu' then 
            if (ammu.Type ~= -1 and GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < ammu.DrawDistance) then
                DrawMarker(ammu.Type, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ammu.Size.x, ammu.Size.y, ammu.Size.z, ammu.Color.r, ammu.Color.g, ammu.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

-------garage

RMenu.Add('garageammu', 'main', RageUI.CreateMenu("Garage", "Garage ammu"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garageammu', 'main'), true, true, true, function() 
            RageUI.ButtonWithStyle("Ranger le véhicule", "Pour ranger le véhicule", {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 5 then
                DeleteEntity(veh)
            end 
        end
    end) 

            RageUI.ButtonWithStyle("Camion blindé", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Citizen.Wait(1)  
            spawnuniCar("stockade")
            end
        end)     

        RageUI.ButtonWithStyle("Sultan", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Citizen.Wait(1)  
            spawnuniCar("sultan")
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
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, ammu.pos.garage.position.x, ammu.pos.garage.position.y, ammu.pos.garage.position.z)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'ammu' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garageammu', 'main'), not RageUI.Visible(RMenu:Get('garageammu', 'main')))
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
    local vehicle = CreateVehicle(car, ammu.spawn.spawnvoiture.position.x, ammu.spawn.spawnvoiture.position.y, ammu.spawn.spawnvoiture.position.z, ammu.spawn.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "ammu"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
    SetVehicleMaxMods(vehicle)
end

function SetVehicleMaxMods(vehicle)

    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
  
    ESX.Game.SetVehicleProperties(vehicle, props)
  
  end


--coffre

RMenu.Add('coffreammu', 'main', RageUI.CreateMenu("Armurerie", " "))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('coffreammu', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Prendre objet", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenGetStocksammuMenu()
            end
            end)
            RageUI.ButtonWithStyle("Déposer objet", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            OpenPutStocksammuMenu()
            end
            end)

            for k,v in pairs(ammu.armurerie) do
                RageUI.ButtonWithStyle(v.nom, "Pour obtenir un "..v.nom, {RightLabel = "~g~"..v.prix.."~g~$"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                TriggerServerEvent('prendre:armurerie', v.arme, v.prix)
                end
                end)
            end

            end, function()
            end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, ammu.pos.coffre.position.x, ammu.pos.coffre.position.y, ammu.pos.coffre.position.z)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'ammu' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à l'armurerie")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('coffreammu', 'main'), not RageUI.Visible(RMenu:Get('coffreammu', 'main')))
                    end   
                end
               end 
        end
end)

function OpenGetStocksammuMenu()
    ESX.TriggerServerCallback('prendreitem', function(items)
        local elements = {}

        for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'ammu',
            title    = 'ammu stockage',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'ammu',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('prendreitems', itemName, count)

                    Citizen.Wait(300)
                    OpenGetStocksammuMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenPutStocksammuMenu()
    ESX.TriggerServerCallback('inventairejoueur', function(inventory)
        local elements = {}

        for i=1, #inventory.items, 1 do
            local item = inventory.items[i]

            if item.count > 0 then
                table.insert(elements, {
                    label = item.label .. ' x' .. item.count,
                    type = 'item_standard',
                    value = item.name
                })
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'ammu',
            title    = 'inventaire',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            local itemName = data.current.value

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'ammu',
                title = 'quantité'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    ESX.ShowNotification('quantité invalide')
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('stockitem', itemName, count)

                    Citizen.Wait(300)
                    OpenPutStocksammuMenu()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end



--menu

local societyammumoney = nil


RMenu.Add('ammuf6', 'main', RageUI.CreateMenu("Armurerier", "Intéraction"))
RMenu.Add('ammuf6', 'annonce', RageUI.CreateSubMenu(RMenu:Get('ammuf6', 'main'), "Armurerier", "Intéraction"))

Citizen.CreateThread(function()
    while true do
    	

        RageUI.IsVisible(RMenu:Get('ammuf6', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Donner une Facture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    RageUI.CloseAll()        
                    OpenBillingMenu() 
                end
            end)

            RageUI.ButtonWithStyle("Annonces",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('ammuf6', 'annonce'))

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('ammuf6', 'annonce'), true, true, true, function()

            RageUI.ButtonWithStyle("Disponible",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
              if Selected then
                TriggerServerEvent('ammuouvert')
              end
            end)
        
            RageUI.ButtonWithStyle("Indisponible",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
              if Selected then
                TriggerServerEvent('ammuferme')
              end
            end)
        
            RageUI.ButtonWithStyle("Recrutement",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
              if Selected then
                TriggerServerEvent('ammurecrute')
              end
            end)
      
          end, function()
          end)
      

            Citizen.Wait(0)
        end
    end)

--- Job 1

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ammu' then  

                    if IsControlJustPressed(0, 167) then
                        RageUI.Visible(RMenu:Get('ammuf6', 'main'), not RageUI.Visible(RMenu:Get('ammuf6', 'main')))
                end   
        end 
    end
end)


function RefreshammuMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyammuMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyammuMoney(money)
    societyammumoney = ESX.Math.GroupDigits(money)
end