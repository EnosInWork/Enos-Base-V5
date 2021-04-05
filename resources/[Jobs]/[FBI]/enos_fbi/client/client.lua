
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
    RefreshfbiMoney()
end)


local societyfbimoney = nil
local prisefbiservice = false


Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k,v in pairs(ConfFbi.pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'fbi' then 
            if (ConfFbi.Type ~= -1 and GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < ConfFbi.DrawDistance) then
                DrawMarker(ConfFbi.Type, v.position.x, v.position.y, v.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfFbi.Size.x, ConfFbi.Size.y, ConfFbi.Size.z, ConfFbi.Color.r, ConfFbi.Color.g, ConfFbi.Color.b, 100, false, true, 2, false, false, false, false)
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

-------Vestiaire

local vestifbi = false
RMenu.Add('vestiairefbi', 'main', RageUI.CreateMenu("Vestiaire", " "))
RMenu:Get('vestiairefbi', 'main').Closed = function()
    vestifbi = false
end

function vestiairefbi()
    if not vestifbi then
        vestifbi = true
        RageUI.Visible(RMenu:Get('vestiairefbi', 'main'), true)
    while vestifbi do
        RageUI.IsVisible(RMenu:Get('vestiairefbi', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Tenue civil", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
			prisefbiservice = false
			end)
            end
            end)
            
            RageUI.ButtonWithStyle("Tenue FBI", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
                SetPedComponentVariation(GetPlayerPed(-1) , 8, 105, 0) --tshirt 
                SetPedComponentVariation(GetPlayerPed(-1) , 11, 50, 0)  --torse
                SetPedComponentVariation(GetPlayerPed(-1) , 3, 8, 0)  -- bras
                SetPedComponentVariation(GetPlayerPed(-1) , 4, 25, 0)   --pants
                SetPedComponentVariation(GetPlayerPed(-1) , 6, 24, 0)   --shoes
            prisefbiservice = true
            end
            end)
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' and ESX.PlayerData.job.grade_name == 'officier' or ESX.PlayerData.job.grade_name == 'sergent' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then            
            RageUI.ButtonWithStyle("Tenue FBI Intervention", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
			SetPedComponentVariation(GetPlayerPed(-1) , 8, 105, 0) --tshirt 
			SetPedComponentVariation(GetPlayerPed(-1) , 11, 53, 0)  --torse
			SetPedComponentVariation(GetPlayerPed(-1) , 3, 8, 0)  -- bras
			SetPedComponentVariation(GetPlayerPed(-1) , 4, 25, 0)   --pants
			SetPedComponentVariation(GetPlayerPed(-1) , 6, 25, 0)   --shoes
            SetPedComponentVariation(GetPlayerPed(-1) , 9, 13, 0)   --bulletwear
            SetPedPropIndex(GetPlayerPed(-1) , 0, 8, 0)   --helmet
            prisefbiservice = true
            end
            end)

            RageUI.ButtonWithStyle("Gilet par balle", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            SetPedComponentVariation(GetPlayerPed(-1) , 9, 2, 0)   --bulletwear
            SetPedArmour(GetPlayerPed(-1), 100)
            prisefbiservice = true
            end
            end)

            RageUI.ButtonWithStyle("Gilet par balle négociateur", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                SetPedComponentVariation(GetPlayerPed(-1) , 9, 2, 1)   --bulletwear
                SetPedArmour(GetPlayerPed(-1), 100)
                prisefbiservice = true
                end
                end)
            
        end

            
        end, function()
        end)
            Citizen.Wait(0)
        end
    else
        vestifbi = false
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, ConfFbi.pos.vestiaire.position.x, ConfFbi.pos.vestiaire.position.y, ConfFbi.pos.vestiaire.position.z)
		    if dist <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au vestiaire")
                    if IsControlJustPressed(1,51) then
                        vestiairefbi()
                    end   
                
               end 
            end
        end
end)

--------Fin vestiaire

-------armurerie
local armufbi = false
RMenu.Add('armureriefbi', 'main', RageUI.CreateMenu("Armurerie", "Pour prendre vos armes de fonction."))
RMenu.Add('armureriefbi', 'coffre', RageUI.CreateSubMenu(RMenu:Get('armureriefbi', 'main'), "Stockage", "Pour stocker vos objets ou autre."))
RMenu:Get('armureriefbi', 'main').Closed = function()
    armufbi = false
end

function ouvrirarmufbi()
    if not armufbi then
        armufbi = true
        RageUI.Visible(RMenu:Get('armureriefbi', 'main'), true)
    while armufbi do
        RageUI.IsVisible(RMenu:Get('armureriefbi', 'main'), true, true, true, function()
        	 if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' and ESX.PlayerData.job.grade_name == 'officier' or ESX.PlayerData.job.grade_name == 'sergent' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then
        	RageUI.ButtonWithStyle("Stockage", "Pour déposer/récupérer des armes ou objets.", {RightLabel = "→→→"},true, function()
            end, RMenu:Get('armureriefbi', 'coffre'))     
            end     
            RageUI.ButtonWithStyle("Equipement de base", "Pour prendre votre équipement de base. (Taser, matraque, lampe torche)", { },true, function(Hovered, Active, Selected)
            if (Selected) then   
            TriggerServerEvent('efbi_fbi:equipementbase')
            end
            end)

            for k,v in pairs(ConfFbi.armurerie) do
            RageUI.ButtonWithStyle(v.nom, "Pour obtenir un "..v.nom, { },true, function(Hovered, Active, Selected)
            if (Selected) then   
            TriggerServerEvent('efbi_fbi:armurerie', v.arme, v.prix)
            end
            end)
        end



        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('armureriefbi', 'coffre'), true, true, true, function()
        	RageUI.ButtonWithStyle("Prendre objet", "Pour prendre un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            armufbi = false
            OpenGetStocksfbiMenu()
            end
            end)
            RageUI.ButtonWithStyle("Déposer objet", "Pour déposer un objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            RageUI.CloseAll()
            armufbi = false
            OpenPutStocksfbiMenu()
            end
            end)
    		end, function()
			end)
            Citizen.Wait(0)
        end
    else
        armufbi = false
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, ConfFbi.pos.armurerie.position.x, ConfFbi.pos.armurerie.position.y, ConfFbi.pos.armurerie.position.z)
		    if dist2 <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à l'armurerie")
                    if IsControlJustPressed(1,51) then
                        ouvrirarmufbi()
                    end   
                end
               end 
        end
end)


--coffre
function OpenGetStocksfbiMenu()
	ESX.TriggerServerCallback('efbi_fbi:prendreitem', function(items)
		local elements = {}

		for i=1, #items, 1 do
            table.insert(elements, {
                label = 'x' .. items[i].count .. ' ' .. items[i].label,
                value = items[i].name
            })
        end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
            css      = 'fbi',
			title    = 'fbi stockage',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
                css      = 'fbi',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('efbi_fbi:prendreitems', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksfbiMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksfbiMenu()
	ESX.TriggerServerCallback('efbi_fbi:inventairejoueur', function(inventory)
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
            css      = 'fbi',
			title    = 'inventaire',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
                css      = 'fbi',
				title = 'quantité'
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if not count then
					ESX.ShowNotification('quantité invalide')
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('efbi_fbi:stockitem', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksfbiMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end
--fin coffre

-------garage
local pdgarage = false
RMenu.Add('garagefbi', 'main', RageUI.CreateMenu("Garage", "Pour sortir des véhicules de fbi."))
RMenu:Get('garagefbi', 'main').Closed = function()
    pdgarage = false
end

function ouvrirgarpd()
    if not pdgarage then
        pdgarage = true
        RageUI.Visible(RMenu:Get('garagefbi', 'main'), true)
    while pdgarage do
        RageUI.IsVisible(RMenu:Get('garagefbi', 'main'), true, true, true, function() 
        	RageUI.ButtonWithStyle("Ranger voiture", "Pour ranger une voiture.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
			if dist4 < 4 then
				DeleteEntity(veh)
			end	
            end
            end)         
            for k,v in pairs(ConfFbi.garagevoiture) do
            RageUI.ButtonWithStyle(v.nom, "Pour sortir une "..v.nom, { },true, function(Hovered, Active, Selected)
            if (Selected) then  
            spawnCar(v.modele)
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
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, ConfFbi.pos.garagevoiture.position.x, ConfFbi.pos.garagevoiture.position.y, ConfFbi.pos.garagevoiture.position.z)
		    if dist3 <= 3.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then
                        ouvrirgarpd()
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
    local vehicle = CreateVehicle(car, ConfFbi.spawn.spawnvoiture.position.x, ConfFbi.spawn.spawnvoiture.position.y, ConfFbi.spawn.spawnvoiture.position.z, ConfFbi.spawn.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "fbiH"..math.random(1,9).."C"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end

--------Fin garage

-------helico garage
local garahelipd = false
RMenu.Add('garagehelicofbi', 'main', RageUI.CreateMenu("Garage", "Pour sortir des hélico de fbi."))
RMenu:Get('garagehelicofbi', 'main').Closed = function()
    garahelipd = false
end

function ouvrirgarhelipd()
    if not garahelipd then
        garahelipd = true
        RageUI.Visible(RMenu:Get('garagehelicofbi', 'main'), true)
    while garahelipd do
        RageUI.IsVisible(RMenu:Get('garagehelicofbi', 'main'), true, true, true, function() 
        	RageUI.ButtonWithStyle("Ranger hélico", "Pour ranger un hélico.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
			if dist4 < 9 then
				DeleteEntity(veh)
			end	
            end
            end)         
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' and ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then
            RageUI.ButtonWithStyle("Hélico du FBI", "Pour sortir un hélico.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Citizen.Wait(2000)   
            spawnHeli("fibfrogger")
            end
            end)
        	end
            

            
        end, function()
        end)
            Citizen.Wait(0)
        end
    else
        garahelipd = false
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, ConfFbi.pos.garagehelico.position.x, ConfFbi.pos.garagehelico.position.y, ConfFbi.pos.garagehelico.position.z)
		    if dist3 <= 3.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage hélico")
                    if IsControlJustPressed(1,51) then
                    	if prisefbiservice == true then
                        ouvrirgarhelipd()
                         else
                			ESX.ShowNotification("Vous n'avez pas pris votre service au vestiaire...")
                		end
                    end   
                end
               end 
        end
end)

function spawnHeli(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, ConfFbi.spawn.spawnhelico.position.x,ConfFbi.spawn.spawnhelico.position.y, ConfFbi.spawn.spawnhelico.position.z, ConfFbi.spawn.spawnhelico.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "fbiH"..math.random(1,9).."C"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end

-------menu f6


local f6fbi = false

RMenu.Add('fbif6', 'main', RageUI.CreateMenu("Menu FBI", "Pour effectuer différentes tâches"))
RMenu.Add('fbif6', 'amende', RageUI.CreateSubMenu(RMenu:Get('fbif6', 'main'), "Amendes", "Pour mettre une amende à un citoyen"))
RMenu.Add('fbif6', 'commandant', RageUI.CreateSubMenu(RMenu:Get('fbif6', 'main'), "Options Directeur", "Option disponible"))
RMenu.Add('fbif6', 'int_citoyen', RageUI.CreateSubMenu(RMenu:Get('fbif6', 'main'), "Interaction citoyen", "Pour agir avec les citoyens"))
RMenu:Get('fbif6', 'main').Closed = function()
    f6fbi = false
end

function ouvrirf6fbi()
    if not f6fbi then
        f6fbi = true
        RageUI.Visible(RMenu:Get('fbif6', 'main'), true)
    while f6fbi do
        

        RageUI.IsVisible(RMenu:Get('fbif6', 'main'), true, true, true, function() 
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' and ESX.PlayerData.job.grade_name == 'boss' then	
        RageUI.ButtonWithStyle("Option Directeur", "Option disponible pour le directeur", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('fbif6', 'commandant'))
        end
        RageUI.ButtonWithStyle("Interaction citoyen", "Pour agir avec les citoyens", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('fbif6', 'int_citoyen'))
        RageUI.ButtonWithStyle("Amendes", "Pour mettre une amende à un citoyen", {RightLabel = "→→→"},true, function()
        end, RMenu:Get('fbif6', 'amende'))
        RageUI.ButtonWithStyle("Voiture en fourrière", "Pour mettre une voiture en fourrière", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local playerPed = PlayerPedId()

            if IsPedSittingInAnyVehicle(playerPed) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)

                if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                    ESX.ShowNotification('la voiture a été mis en fourrière bg')
                    ESX.Game.DeleteVehicle(vehicle)
                   
                else
                    ESX.ShowNotification('met toi côté conducteur bg pour la mettre en fourrière ou sort de la voiture')
                end
            else
                local vehicle = ESX.Game.GetVehicleInDirection()

                if DoesEntityExist(vehicle) then
                    ESX.ShowNotification('la voiture a été mis en fourrière bg')
                    ESX.Game.DeleteVehicle(vehicle)

                else
                    ESX.ShowNotification('~r~Aucun véhicule')
                end
            end
            end
            end)

        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('fbif6', 'commandant'), true, true, true, function()

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
        RageUI.IsVisible(RMenu:Get('fbif6', 'int_citoyen'), true, true, true, function()

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
                TriggerServerEvent('esx_fbi:handcuff', GetPlayerServerId(closestPlayer))
            end
        end)

            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                TriggerServerEvent('esx_fbi:drag', GetPlayerServerId(closestPlayer))
            end
        end)

            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                TriggerServerEvent('esx_fbi:putInVehicle', GetPlayerServerId(closestPlayer))
                end
            end)

            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                TriggerServerEvent('esx_fbi:OutVehicle', GetPlayerServerId(closestPlayer))
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
        RageUI.IsVisible(RMenu:Get('fbif6', 'amende'), true, true, true, function()
        	 RageUI.ButtonWithStyle("Amende personnalisé", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                    	local prixamende = KeyboardInput('Veuillez mettre le montant à facturer', '', 12)
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_fbi', "fbi", prixamende)
                    end
            end
            end)
            for k, v in pairs(ConfFbi.amende) do
            RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "~r~$"..v.prix}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_fbi', v.nom, v.prix)
                    end
            end
            end)
            end
        end, function()
        end)

            Citizen.Wait(0)
        end
    else
        f6fbi = false
    end
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

RegisterNetEvent('esx_fbi:handcuff')
AddEventHandler('esx_fbi:handcuff', function()

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

RegisterNetEvent('esx_fbi:drag')
AddEventHandler('esx_fbi:drag', function(cop)
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

RegisterNetEvent('esx_fbi:putInVehicle')
AddEventHandler('esx_fbi:putInVehicle', function()

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

RegisterNetEvent('esx_fbi:OutVehicle')
AddEventHandler('esx_fbi:OutVehicle', function(t)
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
	ESX.TriggerServerCallback('esx_fbi:getOtherPlayerData', function(data)
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
				TriggerServerEvent('esx_fbi:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
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
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then
            	
                    if IsControlJustPressed(1,167) then
                        ouvrirf6fbi()
                        RefreshfbiMoney()
                    end
                
       	end
    end
end)

Citizen.CreateThread(function()
    local fbimap = AddBlipForCoord(110.91, -748.34, 45.75)
    SetBlipSprite(fbimap, 304)
    SetBlipColour(fbimap, 5)
    SetBlipScale(fbimap, 0.90)
    SetBlipAsShortRange(fbimap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Bureau FBI")
    EndTextCommandSetBlipName(fbimap)
end)

