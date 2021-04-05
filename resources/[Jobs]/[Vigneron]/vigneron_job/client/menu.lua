


ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)

local playerPed = GetPlayerPed(-1)

-- récolte

local vigne_harvest = false
RMenu.Add('vigne_harvest', 'main', RageUI.CreateMenu("~b~Récolte", ""))
RMenu:Get('vigne_harvest', 'main'):SetSubtitle("~b~Voici ce que vous récoltez")

RMenu:Get('vigne_harvest', 'main').EnableMouse = false
RMenu:Get('vigne_harvest', 'main').Closed = function()
	vigne_harvest = false
	TriggerServerEvent('esx_vignejob:stopCraft')
	FreezeEntityPosition(playerPed, false)
end


function openCraft()
	if not vigne_harvest then
		vigne_harvest = true
		RageUI.Visible(RMenu:Get('vigne_harvest', 'main'), true)
	Citizen.CreateThread(function()
		while vigne_harvest do
			Citizen.Wait(1)
				RageUI.IsVisible(RMenu:Get('vigne_harvest', 'main'), true, true, true, function()
					FreezeEntityPosition(playerPed, true)
					RageUI.ButtonWithStyle("Raisin", "récolter du raisin", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('esx_vignejob:startHarvest')
							
						end 
					end)
					--[[RageUI.ButtonWithStyle("Outil de réparation", "Pour faire des kit de réparation", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('esx_vignejob:startHarvest2')
						end 
					end)
					RageUI.ButtonWithStyle("Outil de carosserie", "Pour faire des kit de carrosserie", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('esx_vignejob:startHarvest3')
						end 
					end)]]
				end)
			end
		end)
	end
end


RegisterNetEvent("vigne_harvest") 
AddEventHandler("vigne_harvest", function()
    openCraft()
end)
--traitement


local vigne_craft = false
RMenu.Add('vigne_craft', 'main', RageUI.CreateMenu("~b~Traitement", ""))
RMenu:Get('vigne_craft', 'main'):SetSubtitle("~b~ à vous de jouez")
RMenu:Get('vigne_craft', 'main').EnableMouse = false
RMenu:Get('vigne_craft', 'main').Closed = function()
	vigne_craft = false
	TriggerServerEvent('esx_vignejob:stopCraft')
	FreezeEntityPosition(playerPed, false)
end


function openTrait()
	if not vigne_craft then
		vigne_craft = true
		RageUI.Visible(RMenu:Get('vigne_craft', 'main'), true)
	Citizen.CreateThread(function()
		while vigne_craft do
			Citizen.Wait(1)
				RageUI.IsVisible(RMenu:Get('vigne_craft', 'main'), true, true, true, function()
					FreezeEntityPosition(playerPed, true)
					--[[RageUI.ButtonWithStyle("Faire des Grand crus", "Il vous faut du raisins et du vin", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('esx_vignejob:startCraft')
						end 
					end)
					RageUI.ButtonWithStyle("Vin", "Il vous faut du raisin pour fabriquer une bouteille.", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('esx_vignejob:startCraft2')
						end 
					end)]]
					RageUI.ButtonWithStyle("Jus de raisin", "Il vous faut du raisin pour fabriquer un jus", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('esx_vignejob:startCraft3')
						end 
					end)
				end)
			end
		end)
	end
end


RegisterNetEvent("craft") 
AddEventHandler("craft", function()
    openTrait()
end)

--vente

local vigne_sell = false
RMenu.Add('vigne_sell', 'main', RageUI.CreateMenu("~b~Vente", ""))
RMenu:Get('vigne_sell', 'main'):SetSubtitle("~p~Vente")
RMenu:Get('vigne_sell', 'main').EnableMouse = false
RMenu:Get('vigne_sell', 'main').Closed = function()
	vigne_sell = false
	TriggerServerEvent('esx_vigne:stopSell')
	FreezeEntityPosition(playerPed, false)
end


function openPh()
	if not vigne_sell then
		vigne_sell = true
		RageUI.Visible(RMenu:Get('vigne_sell', 'main'), true)
	Citizen.CreateThread(function()
		while vigne_sell do
			Citizen.Wait(1)
				RageUI.IsVisible(RMenu:Get('vigne_sell', 'main'), true, true, true, function()
					FreezeEntityPosition(playerPed, true)
					RageUI.ButtonWithStyle("Vente de Jus de Raisin", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('esx_vigne:startSell')
						end 
					end)
				end)
			end
		end)
	end
end


RegisterNetEvent("vigne_sell") 
AddEventHandler("vigne_sell", function()
    openPh()
end)



--- F6

RegisterNetEvent("vigne_menu")
AddEventHandler("vigne_menu", function()
    openVigne()
end)

local vigne_menu = false
    
RMenu.Add('vigne_menu', 'main', RageUI.CreateMenu("~b~Vigneron", ""))
RMenu:Get('vigne_menu', 'main'):SetSubtitle("~b~Menu Interactions")
RMenu.Add('vigne_menu', 'poing', RageUI.CreateSubMenu(RMenu:Get('vigne_menu', 'main'), "~b~Factures", "~b~Factures"))
RMenu.Add('vigne_menu', 'info', RageUI.CreateSubMenu(RMenu:Get('vigne_menu', 'main'), "~b~Informations", "~b~Informations"))
RMenu.Add('vigne_menu', 'repa', RageUI.CreateSubMenu(RMenu:Get('vigne_menu', 'main'), "~b~Factures", "~b~Liste"))


RMenu:Get('vigne_menu', 'main').EnableMouse = false
RMenu:Get('vigne_menu', 'main').Closed = function()
    vigne_menu = false
end



function openVigne()
        if not vigne_menu then
            vigne_menu = true
            RageUI.Visible(RMenu:Get('vigne_menu', 'main'), true)

            Citizen.CreateThread(function()
                while vigne_menu do
                    Citizen.Wait(1)
					RageUI.IsVisible(RMenu:Get('vigne_menu', 'main'), true, true, true, function()
						RageUI.Separator("~o~"..GetPlayerName(PlayerId()).. "~w~ - ~o~" ..ESX.PlayerData.job.grade_label.. "")

                        RageUI.ButtonWithStyle("Factures", "~r~Faire une facture.", {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
                            if (Selected) then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    TriggerEvent("esx:showAdvancedNotification", '~r~Facture', '~p~Vigne', '~r~Il n\'y a personne autour de vous.', 'CHAR_BLOCKED', 'spawn', 8)
                                else
                                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
                                    title = ('Rentrer le montant de la facture')
                                }, function(data, menu)
                    
                                    local amount = tonumber(data.value)
                                    if amount == nil then
                                        ESX.ShowNotification('Mauvais montant')
                                    else
                                        menu.close()
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestPlayer == -1 or closestDistance > 3.0 then
                                            TriggerEvent("esx:showAdvancedNotification", '~r~Facture', '~p~Vigne', '~r~Il n\'y a personne autour de vous.', 'CHAR_BLOCKED', 'spawn', 8)
                                        else
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_vigne', 'Vigne', amount)
                    
                                            ESX.ShowNotification('Facture envoyée')
                                        end
                    
                                    end
                            
                    
                                end, function(data, menu)
                                    menu.close()
                                end)
                            end
						end 
					end)
                        RageUI.ButtonWithStyle("Informations", "~b~Donner des informations à la ville.", {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
                            if (Selected) then
                            end 
                        end, RMenu:Get('vigne_menu', 'info'))
                    end, function()
                end)
                RageUI.IsVisible(RMenu:Get('vigne_menu', 'info'), true, true, true, function()
					RageUI.ButtonWithStyle("Disponible", "~b~", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
                            TriggerServerEvent('AnnoncebnOuvert')
						end 
					end)
					RageUI.ButtonWithStyle("Non disponible", "~b~", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
                            TriggerServerEvent('AnnoncebnFermer')
						end 
					end)
				end, function()
                end)   
                RageUI.IsVisible(RMenu:Get('vigne_menu', 'poing'), true, true, true, function()
                    RageUI.ButtonWithStyle("Analyse Moteur", "~b~Analyse du moteur pour voir si il faut faire une réparation ou pas.", {RightLabel = "~r~200~w~$"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                            TriggerServerEvent('esx_billing:sendBillBill', GetPlayerServerId(closestPlayer), 'society_vigne', '~b~LS\'Custom : Analyse Moteur', '200')
							ESX.ShowNotification('~b~Vous avez envoyé une facture.')
                        end 
                    end)
                    RageUI.ButtonWithStyle("Controle technique", "~b~Analyse du véhicule entier", {RightLabel = "~r~500~w~$"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                            TriggerServerEvent('esx_billing:sendBillBill', GetPlayerServerId(closestPlayer), 'society_vigne', '~b~LS\'Custom : Controle technique', '500')
							ESX.ShowNotification('~b~Vous avez envoyé une facture.')
                        end 
                    end)
                        RageUI.ButtonWithStyle("Spéciales", "~b~Plusieures factures.", {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
                            if (Selected) then 
                            end 
                        end, RMenu:Get('vigne_menu', 'repa'))
                   end, function()
                end)
                RageUI.IsVisible(RMenu:Get('vigne_menu', 'repa'), true, true, true, function()
					RageUI.ButtonWithStyle("Vitre", "~b~Facture pour une/des vitre(s) cassée(s)", {RightLabel = "~r~200~w~$"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
                            TriggerServerEvent('esx_billing:sendBillBill', GetPlayerServerId(closestPlayer), 'society_vigne', '~b~LS\'Custom : Vitre', '800')
							ESX.ShowNotification('~b~Vous avez envoyé une facture.')
						end 
					end)
					RageUI.ButtonWithStyle("Carosserie", "~b~Réparation de la carrosserie", {RightLabel = "~r~200~w~$"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
                            TriggerServerEvent('esx_billing:sendBillBill', GetPlayerServerId(closestPlayer), 'society_vigne', '~b~LS\'Custom : Carosserie', '800')
							ESX.ShowNotification('~b~Vous avez envoyé une facture.')
						end 
					end)
				end, function()
                end)   
            end
        end)
    end
end


-- Vestiaires 


function applySkinSpecific(infos)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = infos.variations.male
		else
			uniformObject = infos.variations..female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end

		infos.onEquip()
	end)
end


local vigne_cloakroom = false

RMenu.Add('vigne_cloakroom', 'main', RageUI.CreateMenu("~b~Vestiaires", "", 10,80))
RMenu:Get('vigne_cloakroom', 'main'):SetSubtitle("~b~Vestiaires")

RMenu:Get('vigne_cloakroom', 'main').EnableMouse = false
RMenu:Get('vigne_cloakroom', 'main').Closed = function()
	vigne_cloakroom = false
end


function OpenCloak()
	if not vigne_cloakroom then
		vigne_cloakroom = true
		RageUI.CloseAll()
		RageUI.Visible(RMenu:Get('vigne_cloakroom', 'main'), true)
	Citizen.CreateThread(function()
		while vigne_cloakroom do
			Citizen.Wait(1)
				local pCo = GetEntityCoords(PlayerPedId())
				RageUI.IsVisible(RMenu:Get('vigne_cloakroom', 'main'), true, true, true, function()

					RageUI.Separator("~o~"..GetPlayerName(PlayerId()).. "~w~ - ~o~" ..ESX.PlayerData.job.grade_label.. "")

						for index,infos in pairs(Vigne.clothes.specials) do
							RageUI.ButtonWithStyle(infos.label,"Vous permets d'équiper: "..infos.label, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
								if s then
									applySkinSpecific(infos)
								end
							end)
						end

						for index,infos in pairs(Vigne.clothes.grades) do
							RageUI.ButtonWithStyle(infos.label,"Vous permets d'équiper: "..infos.label, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
							if s then
								applySkinSpecific(infos)
							end
						end)
					end
				end)
			end
		end)
	end
end



RegisterNetEvent("Cloakroombn")
AddEventHandler("Cloakroombn", function()
    OpenCloak()
end)



-- Garage 

local vigne_garage = false

RMenu.Add('vigne_garage', 'main', RageUI.CreateMenu("~b~Garage", "", 10,222))
RMenu:Get('vigne_garage', 'main'):SetSubtitle("~b~Liste des voitures")

RMenu:Get('vigne_garage', 'main').EnableMouse = false
RMenu:Get('vigne_garage', 'main').Closed = function()
	vigne_garage = false
end


function openVeh()
	if not vigne_garage then
		vigne_garage = true
		RageUI.Visible(RMenu:Get('vigne_garage', 'main'), true)
	Citizen.CreateThread(function()
		while vigne_garage do
			Citizen.Wait(1)
					RageUI.IsVisible(RMenu:Get('vigne_garage', 'main'), true, true, true, function()
						local pCo = GetEntityCoords(PlayerPedId())
	
						for index,infos in pairs(Vigne.vehicles.car) do
							if infos.category ~= nil then 
								RageUI.Separator(infos.category)
							else 
								RageUI.ButtonWithStyle(infos.label,nil, {RightBadge = RageUI.BadgeStyle.Car}, ESX.PlayerData.job.grade >= infos.minimum_grade, function(_,_,s)
									if s then
										Citizen.CreateThread(function()
											local model = GetHashKey(infos.model)
											RequestModel(model)
											while not HasModelLoaded(model) do Citizen.Wait(1) end
											local vehicle = CreateVehicle(model, -1921.19, 2044.38, 140.74, 256.42 ,true, false)
											SetModelAsNoLongerNeeded(model)
											vigne_garage = false
											RageUI.CloseAll()
											-- Notification + Give de clées 
											TriggerEvent("esx:showAdvancedNotification", '~b~Vigneron', '~g~Votre véhicule de service a été sorti.', '~b~Voici la plaque : ~r~'..GetVehicleNumberPlateText(vehicle).. '\n~g~Vous avez aussi reçu les clés !', 'CHAR_SAEEDA', 'spawn', 8)
											TriggerEvent("rKey:GiveKey", GetVehicleNumberPlateText(vehicle))
										end)
	
									end
								end)
							end
						end
						RageUI.ButtonWithStyle("Ranger le véhicule", "Pour ranger votre véhicule.", {RightLabel = "→"},true, function(Hovered, Active, Selected)
							if (Selected) then   
							local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
							if dist4 < 4 then
								DeleteEntity(veh)
							end 
						end
					end) 
					end, function()    
					end, 1)
			end
		end)
	end
end



RegisterNetEvent("vigne_garage")
AddEventHandler("vigne_garage", function()
    openVeh()
end)


