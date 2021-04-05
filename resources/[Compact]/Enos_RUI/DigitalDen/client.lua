ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)



------------ Création du Menu / Sous Menu -----------

RMenu.Add('example', 'main', RageUI.CreateMenu("Magasin", "Magasin"))

Citizen.CreateThread(function()

    while true do

        RageUI.IsVisible(RMenu:Get('example', 'main'), true, true, true, function()



            RageUI.ButtonWithStyle("Carte-Sim", "Achetez une Carte Sim !", {RightLabel = "~g~150$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('Buysim')
                end
            end)

            RageUI.ButtonWithStyle("Téléphone", "Achetez un Téléphone !", {RightLabel = "~g~300$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('Buytel')
                end
            end)              

            end, function()
            end, 1)

            Citizen.Wait(0)
        end
    end)







    ---------------------------------------- Position du Menu --------------------------------------------



local position = {
    {x = 392.76 , y = -831.78, z = 29.29, }
}    

    

    

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            for k in pairs(position) do

                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

    

                if dist <= 1.0 then

                   RageUI.Text({
                        message = "Appuyez sur [~b~E~w~] pour acceder au ~b~Magasin",
                        time_display = 1
                    })

                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('example', 'main'), not RageUI.Visible(RMenu:Get('example', 'main')))
                    end
                end
            end
        end
    end)

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_solomon")
    
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end

    ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_solomon", 392.76, -831.78, 28.29, 222.26, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)


--blips

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(392.76, -831.78, 28.29)

    SetBlipSprite(blip, 521)
    SetBlipColour(blip, 5)
    SetBlipScale(blip, 0.80)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("DigitalDen")
    EndTextCommandSetBlipName(blip)
end)
