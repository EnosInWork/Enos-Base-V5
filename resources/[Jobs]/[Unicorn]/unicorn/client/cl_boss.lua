ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyunicornmoney = nil

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

RMenu.Add('test', 'boss', RageUI.CreateMenu("Unicorn", "Actions Patron"))
Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('test', 'boss'), true, true, true, function()

            if societyunicornmoney ~= nil then
                RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyunicornmoney}, true, function()
                end)
            end

            RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. 'unicorn',
                    {
                        title = ('Montant')
                    }, function(data, menu)
                    local amount = tonumber(data.value)

                if amount == nil then
                    ESX.ShowNotification('Montant invalide')
                else
                    menu.close()
                    TriggerServerEvent('esx_society:withdrawMoney', 'unicorn', amount)
                        end
                    end)
                end
            end)

            RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. 'unicorn',
                    {
                        title = ('Montant')
                    }, function(data, menu)
        
                        local amount = tonumber(data.value)
        
                        if amount == nil then
                            ESX.ShowNotification('Montant invalide')
                        else
                            menu.close()
                            TriggerServerEvent('esx_society:depositMoney', 'unicorn', amount)
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
    {x = 94.98, y = -1292.96, z = 29.27}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' and ESX.PlayerData.job.grade_name == 'boss' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
			DrawMarker(20, 94.98, -1292.96, 28.27+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au Actions Patron")
                if IsControlJustPressed(1,51) then
                    RefreshunicornMoney()
                    RageUI.Visible(RMenu:Get('test', 'boss'), not RageUI.Visible(RMenu:Get('test', 'boss')))
                end
            end
        end
    end
    end
end)

function RefreshunicornMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyunicornMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyunicornMoney(money)
    societyunicornmoney = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)
        menu.close()
    end, {wash = false})
end



