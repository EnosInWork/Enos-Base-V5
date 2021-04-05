ESX  = nil
local open = false


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local mainMenu = RageUI.CreateMenu("Go Fast", "Illegal")
mainMenu.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = 255, G = 0, B = 0, A = 1 } } 

mainMenu.Closed = function()   
    RageUI.Visible(mainMenu, false)
    open = false
end 



function OpenMenu()
    if open then 
        open = false 
        RageUI.Visible(mainMenu,false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button('Trajet cours', "Trajet d'environ ~g~1,5 km~w~ livre le contenu de ta caisse à l'endroit indiquer et tout ira ~n~bien." , {RightLabel = "→"}, true , {
                        onSelected = function ()
                            RageUI.Visible(mainMenu, false)
                            Wait(100)
                            spawnCar("huntley")   
                            ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 1 minutes 30 maximum")                          
                            trajet.court()
                        end
                    })
                    RageUI.Button('Trajet moyen', "Plus long que le premier celui-ci est à ~g~3 km~w~ livre ce cargot le plus rapidement ~n~possible !" , {RightLabel = "→"}, true , {

                        onSelected = function ()
                            RageUI.Visible(mainMenu, false)
                            Wait(100)
                            spawnCar("tailgater")
                            ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 2 minutes 30 maximum") 
                            trajet.moyen()
                        end 
                    })
                    RageUI.Button('Trajet long', "Le trajet ultime pour les affranchis celui-ci est à ~g~11 km~w~ fait au plus vite !" , {RightLabel = "→"}, true , {
                        onSelected = function ()
                            RageUI.Visible(mainMenu, false)
                            Wait(100)
                            spawnCar("schafter2") 
                            ESX.ShowNotification("~r~GoFast~s~~n~Rendez vous au point de livraison tu as 8 minutes")
                            trajet.long()

                        end 
                    })


                end)

                Wait(0)
            end
        end)


    end
end 


local position = {
	{x = 755.02111816406, y = -1865.4534912109, z = 29.293727874756},
}

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		for k in pairs(position) do

			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

			
			if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec le vendeur")
				if IsControlJustPressed(1, 38) then
                    OpenMenu()
                    
                end
            else
                RageUI.Visible(mainMenu, false)
                Wait(350)
            end

		end
	end
end)

