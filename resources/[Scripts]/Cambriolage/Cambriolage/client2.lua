         --------------------Déclaration ESX--------------------
         ESX = nil

         Citizen.CreateThread(function()
             while ESX == nil do
                 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                 Citizen.Wait(0)
             end
            end)

        --------------------Création menu--------------------

        RMenu.Add("cambriolage2", "script_main", RageUI.CreateMenu("Cambriolage","Cambriolage"))
        RMenu:Get("cambriolage2", 'script_main').Closed = function()end

        --------------------Création marker--------------------

    Citizen.CreateThread(function()
        while true do 
            local ped = GetPlayerPed(-1)
            local interval = 1
            local pos = GetEntityCoords(PlayerPedId())
            local dest = vector3(117.4625, 559.5997, 184.3048)
            local distance = GetDistanceBetweenCoords(pos, dest, true)

            if distance > 20 then 
                interval = 200
            else
                interval = 1
                DrawMarker(22, 117.4625, 559.5997, 184.3048, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
                if distance < 1 then
                    AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour sortir de la maison")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlPressed(1, 51) then
                        RageUI.Visible(RMenu:Get("cambriolage2","script_main"), true)

                    end
                end
            end

            Citizen.Wait(interval)
        end
    end)

    Citizen.CreateThread(function()
        local cooldown = false
        while true do 

        RageUI.IsVisible(RMenu:Get("cambriolage2","script_main"),true,true,true,function() 

            RageUI.ButtonWithStyle("Sortir de la maison", " ", {RightLabel = ""}, true,function(h,a,s)
                if s then
                    RageUI.CloseAll()
                    SetEntityCoords(GetPlayerPed(-1),1289.5472, -1710.999, 55.4746, false, false, false, true)
                    ESX.ShowAdvancedNotification("Cambriolage ", "~r~Cambriolage !","Cambriolage réussis, bonne chance pour la suite" , "CHAR_LESTER_DEATHWISH", 24,5)
                end
            end)

        end, function()end, 1)

            Citizen.Wait(0)
        end
    end)