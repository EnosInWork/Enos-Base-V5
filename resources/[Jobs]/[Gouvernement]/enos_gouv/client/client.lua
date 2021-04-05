
local dragStatus = {}
local IsHandcuffed = false
dragStatus.isDragged = false
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
    RefreshgouvMoney()
end)


local societygouvmoney = nil
local prisegouvservice = false


Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(Confgouv.pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'gouv' then 
            if (Confgouv.Type ~= -1 and GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < Confgouv.DrawDistance) then
                DrawMarker(Confgouv.Type, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Confgouv.Size.x, Confgouv.Size.y, Confgouv.Size.z, Confgouv.Color.r, Confgouv.Color.g, Confgouv.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
		RemoveAnimDict(dictname)
	end
end

Citizen.CreateThread(function()

        local gouvmap = AddBlipForCoord(Confgouv.blip.position.x, Confgouv.blip.position.y, Confgouv.blip.position.z)
        SetBlipSprite(gouvmap, 419)
        SetBlipScale(gouvmap, 0.90)
        SetBlipAsShortRange(gouvmap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Gouvernement")
        EndTextCommandSetBlipName(gouvmap)

end)

-------Vestiaire

local vestigouv = false
RMenu.Add('vestiairegouv', 'main', RageUI.CreateMenu("Vestiaire", " "))
RMenu:Get('vestiairegouv', 'main').Closed = function()
    vestigouv = false
end

function vestiairegouv()
    if not vestigouv then
        vestigouv = true
        RageUI.Visible(RMenu:Get('vestiairegouv', 'main'), true)
    while vestigouv do
        RageUI.IsVisible(RMenu:Get('vestiairegouv', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Tenue civil", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
			prisegouvservice = false
			end)
            end
            end)
            RageUI.ButtonWithStyle("Tenue Gouv", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
			SetPedComponentVariation(GetPlayerPed(-1) , 8, 4, 0) --tshirt 
			SetPedComponentVariation(GetPlayerPed(-1) , 11, 27, 0)  --torse
			SetPedComponentVariation(GetPlayerPed(-1) , 3, 1, 0)  -- bras
			SetPedComponentVariation(GetPlayerPed(-1) , 4, 13, 0)   --pants
			SetPedComponentVariation(GetPlayerPed(-1) , 6, 20, 0)   --shoes
            prisegouvservice = true
            end
            end)
            
        end, function()
        end)
            Citizen.Wait(0)
        end
    else
        vestigouv = false
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Confgouv.pos.vestiaire.position.x, Confgouv.pos.vestiaire.position.y, Confgouv.pos.vestiaire.position.z)
		    if dist <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        vestiairegouv()
                    end   
                
               end 
            end
        end
end)

--------Fin vestiaire

-------armurerie
local armugouv = false
RMenu.Add('armureriegouv', 'main', RageUI.CreateMenu("Armurerie", "Pour prendre vos armes de fonction."))
RMenu.Add('armureriegouv', 'coffre', RageUI.CreateSubMenu(RMenu:Get('armureriegouv', 'main'), "Stockage", "Pour stocker vos objets ou autre."))
RMenu:Get('armureriegouv', 'main').Closed = function()
    armugouv = false
end

function ouvrirarmugouv()
    if not armugouv then
        armugouv = true
        RageUI.Visible(RMenu:Get('armureriegouv', 'main'), true)
    while armugouv do
        RageUI.IsVisible(RMenu:Get('armureriegouv', 'main'), true, true, true, function()
        	 if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' and ESX.PlayerData.job.grade_name == 'officier' or ESX.PlayerData.job.grade_name == 'sergent' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then
        	RageUI.ButtonWithStyle("Stockage", "Pour déposer/récupérer des armes ou objets.", {RightLabel = "→→→"},true, function()
            end, RMenu:Get('armureriegouv', 'coffre'))     
            end     
            RageUI.ButtonWithStyle("Equipement de base", "Pour prendre votre équipement de base. (Taser, matraque, lampe torche)", {RightLabel = "~g~500$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            TriggerServerEvent('egouv_gouv:equipementbase')
            end
            end)

            for k,v in pairs(Confgouv.armurerie) do
            RageUI.ButtonWithStyle(v.nom, "Pour obtenir un "..v.nom, {RightLabel = "~g~"..v.prix.."~g~$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            TriggerServerEvent('egouv_gouv:armurerie', v.arme, v.prix)
            end
            end)
        end



        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('armureriegouv', 'coffre'), true, true, true, function()
        	RageUI.ButtonWithStyle("Prendre objet", "Pour prendre un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            armugouv = false
            OpenGetStocksgouvMenu()
            end
            end)
            RageUI.ButtonWithStyle("Déposer objet", "Pour déposer un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            armugouv = false
            OpenPutStocksgouvMenu()
            end
            end)
    		end, function()
			end)
            Citizen.Wait(0)
        end
    else
        armugouv = false
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, Confgouv.pos.armurerie.position.x, Confgouv.pos.armurerie.position.y, Confgouv.pos.armurerie.position.z)
		    if dist2 <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à l'armurerie")
                    if IsControlJustPressed(1,51) then
                        ouvrirarmugouv()
                    end   
                end
               end 
        end
end)


--coffre
function OpenGetStocksgouvMenu()
	ESX.TriggerServerCallback('egouv_gouv:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'gouv',
			title    = 'gouv stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'gouv',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('egouv_gouv:prendreitems', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksgouvMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksgouvMenu()
	ESX.TriggerServerCallback('egouv_gouv:inventairejoueur', function(inventory)
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
            css      = 'gouv',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'gouv',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('egouv_gouv:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksgouvMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

-------garage
local pdgarage = false
RMenu.Add('garagegouv', 'main', RageUI.CreateMenu("Garage", "Pour sortir des véhicules de gouv."))
RMenu:Get('garagegouv', 'main').Closed = function()
    pdgarage = false
end

function ouvrirgarpd()
    if not pdgarage then
        pdgarage = true
        RageUI.Visible(RMenu:Get('garagegouv', 'main'), true)
    while pdgarage do
        RageUI.IsVisible(RMenu:Get('garagegouv', 'main'), true, true, true, function() 
        	RageUI.ButtonWithStyle("Ranger voiture", "Pour ranger une voiture.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
			if dist4 < 4 then
				DeleteEntity(veh)
			end	
            end
            end)         
            for k,v in pairs(Confgouv.garagevoiture) do
            RageUI.ButtonWithStyle(v.nom, "Pour sortir une "..v.nom, {RightLabel = "Dispo ["..v.stock.."]"},true, function(Hovered, Active, Selected)
            if (Selected) then
            if v.stock > 0 then
            Citizen.Wait(2000)   
            spawnCar(v.modele)
            v.stock = v.stock - 1
        	else
        	ESX.ShowNotification("Plus de voiture en stock!")
        	end
            end
            end)
            end
            
        end, function()
        end)
            Citizen.Wait(0)
        end
    else
        pdgarage = false
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Confgouv.pos.garagevoiture.position.x, Confgouv.pos.garagevoiture.position.y, Confgouv.pos.garagevoiture.position.z)
		    if dist3 <= 3.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then
                    	if prisegouvservice == true then            
                        ouvrirgarpd()
                        else
                			ESX.ShowNotification("Vous n'avez pas pris votre service au vestiaire...")
                		end
                    end   
                end
               end 
        end
end)

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Confgouv.spawn.spawnvoiture.position.x, Confgouv.spawn.spawnvoiture.position.y, Confgouv.spawn.spawnvoiture.position.z, Confgouv.spawn.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "gouvH"..math.random(1,9).."C"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end

local f6gouv = false

RMenu.Add('gouvf6', 'main', RageUI.CreateMenu("Menu Gouv", "Pour effectuer différentes tâches"))
RMenu.Add('gouvf6', 'amende', RageUI.CreateSubMenu(RMenu:Get('gouvf6', 'main'), "Amendes", "Pour mettre une amende à un citoyen"))
RMenu.Add('gouvf6', 'commandant', RageUI.CreateSubMenu(RMenu:Get('gouvf6', 'main'), "Options Gouverneur", "Option disponible"))
RMenu.Add('gouvf6', 'int_citoyen', RageUI.CreateSubMenu(RMenu:Get('gouvf6', 'main'), "Interaction citoyen", "Pour agir avec les citoyens"))
RMenu:Get('gouvf6', 'main').Closed = function()
    f6gouv = false
end

function ouvrirf6gouv()
    if not f6gouv then
        f6gouv = true
        RageUI.Visible(RMenu:Get('gouvf6', 'main'), true)
    while f6gouv do
        

        RageUI.IsVisible(RMenu:Get('gouvf6', 'main'), true, true, true, function() 
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' and ESX.PlayerData.job.grade_name == 'boss' then	
        RageUI.ButtonWithStyle("Option Gouverneur", "Option disponible pour le Gouverneur", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('gouvf6', 'commandant'))
        end
        RageUI.ButtonWithStyle("Interaction citoyen", "Pour agir avec les citoyens", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('gouvf6', 'int_citoyen'))
        RageUI.ButtonWithStyle("Amendes", "Pour mettre une amende à un citoyen", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('gouvf6', 'amende'))

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('gouvf6', 'commandant'), true, true, true, function()
            if societygouvmoney ~= nil then
            RageUI.ButtonWithStyle("Montant disponible dans la société :", nil, {RightLabel = "$" .. societygouvmoney}, true, function()
            end)
        end

            RageUI.ButtonWithStyle("Donner le PPA", "Pour donner le permis port d'arme à quelqu'un", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'weapon')
                 else
                    ESX.ShowNotification('Aucun joueurs à proximité')
                end 
            end
            end)
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('gouvf6', 'int_citoyen'), true, true, true, function()

        	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            RageUI.ButtonWithStyle("Fouiller", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then  
                    RageUI.CloseAll()
                    OpenBodySearchMenu(closestPlayer)
                    ExecuteCommand("me La personne fouille")
                end
            end)    

        RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                TriggerServerEvent('esx_gouv:handcuff', GetPlayerServerId(closestPlayer))
            end
        end)

            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                TriggerServerEvent('esx_gouv:drag', GetPlayerServerId(closestPlayer))
            end
        end)

            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                TriggerServerEvent('esx_gouv:putInVehicle', GetPlayerServerId(closestPlayer))
                end
            end)

            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                TriggerServerEvent('esx_gouv:OutVehicle', GetPlayerServerId(closestPlayer))
            end
        end)

            RageUI.ButtonWithStyle("Carte d'identité", "Pour voir la carte d'identité de la personne proche", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                RageUI.CloseAll()
                f6gouv = false
                OpenIdentityCardMenu(closestPlayer)
            end
            end)

        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('gouvf6', 'amende'), true, true, true, function()
        	 RageUI.ButtonWithStyle("Amende personnalisé", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                    	local prixamende = KeyboardInput('Veuillez mettre le montant à facturer', '', 12)
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_gouv', "gouv", prixamende)
                    end
            end
            end)
            for k, v in pairs(Confgouv.amende) do
            RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "~r~$"..v.prix}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_gouv', v.nom, v.prix)
                    end
            end
            end)
            end
        end, function()
        end)

            Citizen.Wait(0)
        end
    else
        f6gouv = false
    end
end

function RefreshgouvMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietygouvMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietygouvMoney(money)
    societygouvmoney = ESX.Math.GroupDigits(money)
end

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

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
		local elements = {
			{label = 'name', data.name}
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = 'sex', data.sex})
			table.insert(elements, {label = 'dob', data.dob})
			table.insert(elements, {label = 'height', data.height})
		end

		if data.drunk then
			table.insert(elements, {label = 'bac', data.drunk})
		end

		if data.licenses then
			table.insert(elements, {label = 'license_label'})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = 'citizen_interaction',
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-------------------------- Intéraction 

RegisterNetEvent('esx_gouv:handcuff')
AddEventHandler('esx_gouv:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Citizen.Wait(100)
        end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      DisableControlAction(2, 37, true)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      DisableControlAction(0, 37, true) -- Select Weapon
      DisableControlAction(0, 47, true)  -- Disable weapon
      DisplayRadar(false)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

RegisterNetEvent('esx_gouv:drag')
AddEventHandler('esx_gouv:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_gouv:putInVehicle')
AddEventHandler('esx_gouv:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_gouv:OutVehicle')
AddEventHandler('esx_gouv:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

----------------------------------------------- Fouiller

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_gouv:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = 'argent sale ', ESX.Math.Round(data.accounts[i].money),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = 'Armes'})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = ESX.GetWeaponLabel(data.weapons[i].name)..' avec '..data.weapons[i].ammo.. ' Munitions',
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = 'Items'})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = data.inventory[i].count..' x'..data.inventory[i].label,
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = 'fouille',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_gouv:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouv' then
            	
                    if IsControlJustPressed(1,167) then
                        ouvrirf6gouv()
                        RefreshgouvMoney()
                    end
                
       		 end
       		end
    end)

