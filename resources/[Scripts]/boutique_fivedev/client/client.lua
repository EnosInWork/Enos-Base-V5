ESX = nil

Citizen.CreateThread(function()
	TriggerServerEvent('boutique:getpoints')
	if pointjoueur == nil then pointjoueur = 0 end
	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end
end)

local menuColor = {9, 24, 118}
Citizen.CreateThread(function()
    Wait(1000)
    menuColor[1] = GetResourceKvpInt("menuR")
    menuColor[2] = GetResourceKvpInt("menuG")
    menuColor[3] = GetResourceKvpInt("menuB")
    ReloadColor()
end)

local AllMenuToChange = nil
function ReloadColor()
    Citizen.CreateThread(function()
        if AllMenuToChange == nil then
            AllMenuToChange = {}
            for Name, Menu in pairs(RMenu['boutique']) do
                if Menu.Menu.Sprite.Dictionary == "commonmenu" then
                    table.insert(AllMenuToChange, Name)
                end
            end
        end
        for k,v in pairs(AllMenuToChange) do
            RMenu:Get('boutique', v):SetRectangleBanner(9, 24, 118)
        end
    end)
end

RMenu.Add('boutique', 'main', RageUI.CreateMenu("Five-Boutique", "Menu boutique"))
RMenu.Add('boutique', 'vehiclemenu', RageUI.CreateSubMenu(RMenu:Get('boutique', 'main'), "Véhicules", "Menu Véhicule"))
RMenu.Add('boutique', 'armesmenu', RageUI.CreateSubMenu(RMenu:Get('boutique', 'main'), "Armes", "Menu d'armes"))
RMenu.Add('boutique', 'moneymenu', RageUI.CreateSubMenu(RMenu:Get('boutique', 'main'), "Argent", "Menu d'argent"))

Citizen.CreateThread(function()
    while true do
		RageUI.IsVisible(RMenu:Get('boutique', 'main'), true, true, true, function()

                RageUI.Separator("~g~~h~Tu as ~r~"..pointjoueur.." "..moneypoints, nil, {}, true, function(_, _, _) end)

                RageUI.Separator("~h~ID~s~ : ~h~" ..GetPlayerServerId(PlayerId()))
                
--                RageUI.Separator("Code boutique : " .. code)

				RageUI.ButtonWithStyle("Véhicules", "Liste des véhicule de la boutique.", { RightLabel = "→" },true, function() 
				end, RMenu:Get('boutique', 'vehiclemenu'))

				RageUI.ButtonWithStyle("Armes", "Liste des armes de la boutique.", { RightLabel = "→" },true, function() 
				end, RMenu:Get('boutique', 'armesmenu'))

				RageUI.ButtonWithStyle("Argent", "Argent-IG.", { RightLabel = "→" },true, function() 
				end, RMenu:Get('boutique', 'moneymenu'))
				end)

-------------------------------------------------------------------------- Véhicules
		
        RageUI.IsVisible(RMenu:Get('boutique', 'vehiclemenu'), true, true, true, function()
            
            RageUI.Separator("~g~~h~Tu as ~r~"..pointjoueur.." "..moneypoints, nil, {}, true, function(_, _, _) end)

			RageUI.ButtonWithStyle("Bugatti Bolide", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
				if a then
					RenderSprite("RageUI", "bolide", 0, 565, 430, 200, 100)
				end
		
                if s then
                    ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                        if callback then
                            local veh = "rmodbugatti"
                            give_vehi(veh)
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                            else
                        ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                            end
            
                    end, "rmodbugatti")
                end
            end) 
		
		RageUI.ButtonWithStyle("La Voiture Noire", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
						RenderSprite("RageUI", "voiturenoire", 0, 565, 430, 200, 100)
					end
			
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodbolide"
                        give_vehi(veh)   
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                        end, "rmodbolide")
                    end
                end) 
		
		RageUI.ButtonWithStyle("Dodge Charger 69", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
						RenderSprite("RageUI", "charger", 0, 565, 430, 200, 100)
					end
				
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodcharger69"
                        give_vehi(veh)    
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                        end, "rmodcharger69")
                    end
                end) 
				
		RageUI.ButtonWithStyle("Ferrari F12 TDF", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "f12", 0, 565, 430, 200, 100)
					end
					
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodf12tdf"
                        give_vehi(veh)   
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                        end, "rmodf12tdf")
                    end
                end) 
				
		RageUI.ButtonWithStyle("Ferrari F40", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "f40", 0, 565, 430, 200, 100)
					end
						
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodf40"
                        give_vehi(veh)  
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                        end, "rmodf40")
                    end
                end) 
				
		RageUI.ButtonWithStyle("Brabus GT63S", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "b63s", 0, 565, 430, 200, 100)
					end
						
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodgt63"
                        give_vehi(veh) 
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                        end, "rmodgt63")
                    end
                end) 

		RageUI.ButtonWithStyle("Nissan GTR", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "gtr", 0, 565, 430, 200, 100)
					end
						
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodgtr50"
                        give_vehi(veh) 
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                        end, "rmodgtr50")
                    end
                end) 

				RageUI.ButtonWithStyle("Jeep Rmod", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "jeep", 0, 565, 430, 200, 100)
					end
						
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodjeep"
                        give_vehi(veh) 
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                            end, "rmodjeep")
                        end
                    end) 

				RageUI.ButtonWithStyle("Bmw M5 E34", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "m5", 0, 565, 430, 200, 100)
					end
						
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodm5e34"
                        give_vehi(veh) 
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                            end, "rmodm5e34")
                        end
                    end) 

				RageUI.ButtonWithStyle("Volkswagen MK7", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "golf", 0, 565, 430, 200, 100)
					end			
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodmk7"
                        give_vehi(veh)
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                            end, "rmodmk7")
                        end
                    end) 

				RageUI.ButtonWithStyle("Nissan Skyline R34", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "skyline", 0, 565, 430, 200, 100)
					end			
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                            if callback then
                        local veh = "rmodskyline34"
                        give_vehi(veh) 
                        ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                    else
                ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                            end, "rmodskyline34")
                        end
                    end) 

				RageUI.ButtonWithStyle("Chevrolet Camaro ZL1", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
					if a then
							RenderSprite("RageUI", "zl1", 0, 565, 430, 200, 100)
					end	
                    if s then
                        ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                        if callback then
                    local veh = "rmodzl1"
                    give_vehi(veh)   
					ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                            else
                        ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                            end
            
                            end, "rmodzl1")
                        end
                    end) 

end)



-------------------------------------------------------------------------- Armes


    RageUI.IsVisible(RMenu:Get('boutique', 'armesmenu'), true, true, true, function()
        
        RageUI.Separator("~g~~h~Tu as ~r~"..pointjoueur.." "..moneypoints, nil, {}, true, function(_, _, _) end)


		RageUI.ButtonWithStyle("Couteau", nil, { RightLabel = "~r~250 "..moneypoints }, true,function(h,a,s)
			if a then
				RenderSprite("RageUI", "Screenshot_127", 0, 565, 430, 200, 100)
			end
			if s then
				ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
					if callback == true then
						local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
						ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
					else
						ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
					end
				end, "couteau")
			end
		end)

    RageUI.ButtonWithStyle("Bat de baseball", nil, { RightLabel = "~r~250 " ..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "baseball-bat", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "bat")            
        end
	end)
	
	RageUI.ButtonWithStyle("Hachette", nil, { RightLabel = "~r~250 " ..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "hachet", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "hachet")            
        end
	end)
	
	RageUI.ButtonWithStyle("Hachette en pierre", nil, { RightLabel = "~r~250 " ..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "hachettepierre", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "hachpierre")            
        end
    end)

	
	RageUI.ButtonWithStyle("Pétoire", nil, { RightLabel = "~r~500 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "cal50", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "snspistol")
        end
    end)

    RageUI.ButtonWithStyle("Pistolet", nil, { RightLabel = "~r~600 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "pistol", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "pistol")
        end
	end)

   RageUI.ButtonWithStyle("Pistolet Vintage", nil, { RightLabel = "~r~1000 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "vintagepistol", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "vintage")
        end
	end) 
	
	RageUI.ButtonWithStyle("Revolver MK2", nil, { RightLabel = "~r~1500 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "revolvermk2", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "revomk2")
        end
	end)
	
	RageUI.ButtonWithStyle("Mini-SMG", nil, { RightLabel = "~r~2000 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "minismg", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "msmg")
        end
    end) 
	
	RageUI.ButtonWithStyle("Mini-SMG MK2", nil, { RightLabel = "~r~2000 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "smgmk2", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "msmgmk2")
        end
	end) 
	
	RageUI.ButtonWithStyle("Pistolet Mitrailleur", nil, { RightLabel = "~r~2000 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "pistolet-mitrailleur", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "pm")
        end
	end) 
	
	RageUI.ButtonWithStyle("AK-47", nil, { RightLabel = "~r~2500 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "assault-rifle-mk2", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "ak47")
        end
	end) 
	
	RageUI.ButtonWithStyle("Sniper", nil, { RightLabel = "~r~3000 "..moneypoints }, true,function(h,a,s)
        if a then
            RenderSprite("RageUI", "sniper", 0, 565, 430, 200, 100)
        end
        if s then
            ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                if callback == true then
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.ShowNotification("~h~⭐ ~g~Merci pour votre achat dans la boutique !")
                else
                    ESX.ShowNotification("~r~Vous n'avez pas assez de fond pour acheter ceci !")
                end
            end, "sniper")
        end
    end) 

end) --- Fin Armes

-------------------------------------------------------------------------- Argent

        RageUI.IsVisible(RMenu:Get('boutique', 'moneymenu'), true, true, true, function()
            
            RageUI.Separator("~g~~h~Tu as ~r~"..pointjoueur.." "..moneypoints, nil, {}, true, function(_, _, _) end)

			for k, itemmoy in pairs(itemmoney) do
                RageUI.ButtonWithStyle(itemmoy.name, itemmoy.desc, {RightLabel = "~r~"..tostring(itemmoy.point).." ~b~"..moneypoints}, true, function(Hovered, Active, Selected)
					if (Selected) then

						curentvehicle_name = itemmoy.name
						curentvehicle_model = itemmoy.model
						curentvehicle_point = itemmoy.point
						curentvehicle_finalpoint = itemmoy.point

						if pointjoueur >= curentvehicle_finalpoint then
							buying(curentvehicle_finalpoint)
							gmoney(curentvehicle_model, curentvehicle_name)
						else 
							TriggerEvent('esx:showNotification', '~r~Vous n\'avez pas assez de fond pour acheter ceci !')
						end
					end
				end)
			end
		end)
		
        Citizen.Wait(0)
    end
end)

--------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustPressed(0, touche_open_menu) then
			TriggerServerEvent('boutique:getpoints')
			RageUI.Visible(RMenu:Get('boutique', 'main'), not RageUI.Visible(RMenu:Get('boutique', 'main')))
		end -- Touche F1
	end
end)


function buying(point)
	if pointjoueur >= point then
		TriggerServerEvent('boutique:deltniop', point)
		Citizen.Wait(300)
		TriggerServerEvent('boutique:getpoints')
	else
		TriggerEvent('esx:showNotification', '~r~Tu ne peut pas acheter cet article.')
	end
end

RegisterNetEvent('boutique:retupoints')
AddEventHandler('boutique:retupoints', function(point)
	pointjoueur = point
end)

local voituregive = {}

function give_vehi(veh)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    
    Citizen.Wait(10)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            local plate = exports.h4ci_concess:GeneratePlate()
            table.insert(voituregive, vehicle)		
            print(plate)
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
			TriggerServerEvent('shop:vehiculeboutique', vehicleProps, plate)
	end)
end

function gmoney(w,n)
    TriggerEvent('esx:showNotification', '~h~⭐ ~g~Merci pour votre achat dans la boutique !')
	TriggerServerEvent('give:money', w)
end

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

