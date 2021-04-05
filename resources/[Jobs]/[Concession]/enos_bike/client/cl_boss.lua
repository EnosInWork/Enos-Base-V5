ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyconcessmmoney = nil

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


---------------- FONCTIONS ------------------

RMenu.Add('afoua', 'boss', RageUI.CreateMenu("Concess-Moto", "Actions Patron"))

Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('afoua', 'boss'), true, true, true, function()

            if societyconcessmmoney ~= nil then
                RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyconcessmmoney}, true, function()
                end)
            end

            RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. 'biker',
                    {
                        title = ('Montant')
                    }, function(data, menu)
                    local amount = tonumber(data.value)

                if amount == nil then
                    ESX.ShowNotification('Montant invalide')
                else
                    menu.close()
                    TriggerServerEvent('esx_society:withdrawMoney', 'biker', amount)
                        end
                    end)
                end
            end)

            RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. 'biker',
                    {
                        title = ('Montant')
                    }, function(data, menu)
        
                        local amount = tonumber(data.value)
        
                        if amount == nil then
                            ESX.ShowNotification('Montant invalide')
                        else
                            menu.close()
                            TriggerServerEvent('esx_society:depositMoney', 'biker', amount)
                        end
                    end)
                end
            end) 

           RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()
                end
            end)


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------

local position = {
    {x = 953.78, y = -114.91, z = 75.0}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'biker' and ESX.PlayerData.job.grade_name == 'boss' then 

                DrawMarker(20, 953.78, -114.91, 74.0+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Actions Patron")
                if IsControlJustPressed(1,51) then
                    RefreshconcessmMoney()
                    RageUI.Visible(RMenu:Get('afoua', 'boss'), not RageUI.Visible(RMenu:Get('afoua', 'boss')))
                end
            end
        end
    end
    end
end)

function RefreshconcessmMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyconcessmMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyconcessmMoney(money)
    societyconcessmmoney = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'concessm', function(data, menu)
        menu.close()
    end, {wash = false})
end



