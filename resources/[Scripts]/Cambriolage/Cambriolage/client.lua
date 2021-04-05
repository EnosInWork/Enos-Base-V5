         --------------------Déclaration ESX--------------------
         ESX = nil

         Citizen.CreateThread(function()
             while ESX == nil do
                 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                 Citizen.Wait(100)
             end
         end)

        --------------------Création menu--------------------

        RMenu.Add("cambriolage", "script_main", RageUI.CreateMenu("Cambriolage","Cambriolage"))
        RMenu:Get("cambriolage", 'script_main').Closed = function()end

        --------------------Création marker--------------------

    Citizen.CreateThread(function()
        while true do 
            local playerPed = PlayerPedId() 
            local interval = 1
            local pos = GetEntityCoords(PlayerPedId())
            local dest = vector3(1289.5472, -1710.999, 55.4746)
            local distance = GetDistanceBetweenCoords(pos, dest, true)

            if distance > 20 then 
                interval = 200
            else
                interval = 1
                DrawMarker(22, 1289.5472, -1710.999, 55.4746, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
                if distance < 1 then
                    AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ pour cambrioler la maison")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlPressed(1, 51) then
                        RageUI.Visible(RMenu:Get("cambriolage","script_main"), true)

                    end
                end
            end

            Citizen.Wait(interval)
        end
    end)

    Citizen.CreateThread(function()
        local cooldown = false
        while true do 

        RageUI.IsVisible(RMenu:Get("cambriolage","script_main"),true,true,true,function() 

                RageUI.ButtonWithStyle("Entrer dans la maison", "Forcer la serrure", {RightLabel = ""}, not cooldown ,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        cooldown = true
                        Citizen.SetTimeout(1800000,function()
                        end)
                        SetEntityCoords(GetPlayerPed(-1),117.4625, 559.5997, 184.3048, false, false, false, true)
                        ESX.ShowAdvancedNotification("Cambriolage ", "~r~Cambriolage !","Bonne chance et n'oublie pas que tout ce paye !" , "CHAR_LESTER_DEATHWISH", 24,5)
                    end
                end)


        end, function()end, 1)

            Citizen.Wait(0)
        end
    end)

        ------------------Local position RageUI.Text------------------------

    local position = {
        {x = 117.4528 , y = 559.6033, z = 184.29, },
        {x = 118.3787, y = 554.5212, z = 184.299},
        {x = 125.3459, y = 541.3634, z = 183.9246},
        {x = 114.5241, y = 568.4594, z = 176.697},
        {x = 119.1355, y = 544.5460, z = 183.89}
    }

    Citizen.CreateThread(function()
           local blip = AddBlipForCoord(1289.4, -1711.66, 55.26)
           SetBlipSprite(blip, 473)
           SetBlipColour(blip, 35)
           SetBlipScale(blip, 0.50)
           SetBlipAsShortRange(blip, true)
   
           BeginTextCommandSetBlipName('STRING')
           AddTextComponentString("Maison")
           EndTextCommandSetBlipName(blip)
   end)
        
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
     
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 5.5 then

                   RageUI.Text({
                        message = "Faite vite et attention aux empreintes",
                        time_display = 1
                    })
                end
            end
        end
    end)