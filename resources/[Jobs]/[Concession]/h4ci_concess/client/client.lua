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
end)

local societyconcessmoney = nil

concess             = {}
concess.DrawDistance = 100
concess.Size         = {x = 1.0, y = 1.0, z = 1.0}
concess.Color        = {r = 255, g = 255, b = 255}
concess.Type         = 20

h4ci_conc = {
	catevehi = {},
	listecatevehi = {},
}

local derniervoituresorti = {}
local sortirvoitureacheter = {}
--blips

Citizen.CreateThread(function()

        local concessmap = AddBlipForCoord(-57.0, -1099.44, 26.42)
        SetBlipSprite(concessmap, 326)
        SetBlipColour(concessmap, 18)
        SetBlipScale(concessmap, 0.90)
        SetBlipAsShortRange(concessmap, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Concessionnaire | Voiture")
        EndTextCommandSetBlipName(concessmap)

end)

--fin blips

--travail concess

local markerjob = {
        {x = -45.23, y = -1093.43, z = 26.39}, --point vente
}  

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(markerjob) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'concess' then 
            if (concess.Type ~= -1 and GetDistanceBetweenCoords(coords, markerjob[k].x, markerjob[k].y, markerjob[k].z, true) < concess.DrawDistance) then
                DrawMarker(concess.Type, markerjob[k].x, markerjob[k].y, markerjob[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, concess.Size.x, concess.Size.y, concess.Size.z, concess.Color.r, concess.Color.g, concess.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    
end
end)

--point vente
local concesspointvente = false
RMenu.Add('concessvente', 'main', RageUI.CreateMenu("Menu Concess", "Pour vendre des véhicules"))
RMenu.Add('concessvente', 'listevehicule', RageUI.CreateSubMenu(RMenu:Get('concessvente', 'main'), "Catalogue", "Pour acheter un véhicule"))
RMenu.Add('concessvente', 'categorievehicule', RageUI.CreateSubMenu(RMenu:Get('concessvente', 'listevehicule'), "Véhicules", "Pour acheter un véhicule"))
RMenu.Add('concessvente', 'achatvehicule', RageUI.CreateSubMenu(RMenu:Get('concessvente', 'categorievehicule'), "Véhicules", "Pour acheter un véhicule"))
RMenu.Add('concessvente', 'annonces', RageUI.CreateSubMenu(RMenu:Get('concessvente', 'main'), "Annonces", "Annonces de la ville"))
RMenu:Get('concessvente', 'main').Closed = function()
    concesspointvente = false
end
RMenu:Get('concessvente', 'categorievehicule').Closed = function()
    supprimervehiculeconcess()
end

function ouvrirpointventeconc()
    if not concesspointvente then
        concesspointvente = true
        RageUI.Visible(RMenu:Get('concessvente', 'main'), true)
    while concesspointvente do

        RageUI.IsVisible(RMenu:Get('concessvente', 'main'), true, true, true, function()
           
            RageUI.ButtonWithStyle("Catalogue véhicules", nil, {RightLabel = "→→→"},true, function()
           end, RMenu:Get('concessvente', 'listevehicule'))
           
           RageUI.ButtonWithStyle("Facture", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour')
                    else
                    	local amount = KeyboardInput('Veuillez saisir le montant de la facture', '', 4)
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_concess', 'concess', amount)
                    end
                end
            end)

            RageUI.ButtonWithStyle("Annonces", nil, {RightLabel = "→→→"},true, function()
            end, RMenu:Get('concessvente', 'annonces'))
    
            end, function()
            end)

        RageUI.IsVisible(RMenu:Get('concessvente', 'listevehicule'), true, true, true, function()
        	for i = 1, #h4ci_conc.catevehi, 1 do
            RageUI.ButtonWithStyle("Catégorie - "..h4ci_conc.catevehi[i].label, nil, {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            		nomcategorie = h4ci_conc.catevehi[i].label
                    categorievehi = h4ci_conc.catevehi[i].name
                    ESX.TriggerServerCallback('h4ci_concess:recupererlistevehicule', function(listevehi)
                            h4ci_conc.listecatevehi = listevehi
                    end, categorievehi)
                end
            end, RMenu:Get('concessvente', 'categorievehicule'))
        	end
            end, function()
            end)

        RageUI.IsVisible(RMenu:Get('concessvente', 'categorievehicule'), true, true, true, function()
        	RageUI.ButtonWithStyle("↓ Catégorie : "..nomcategorie.." ↓", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then   
            end
            end)

        	for i2 = 1, #h4ci_conc.listecatevehi, 1 do
            RageUI.ButtonWithStyle(h4ci_conc.listecatevehi[i2].name, "Pour acheter ce véhicule", {RightLabel = h4ci_conc.listecatevehi[i2].price.."$"},true, function(Hovered, Active, Selected)
            if (Selected) then
            		nomvoiture = h4ci_conc.listecatevehi[i2].name
            		prixvoiture = h4ci_conc.listecatevehi[i2].price
            		modelevoiture = h4ci_conc.listecatevehi[i2].model
            		supprimervehiculeconcess()
					chargementvoiture(modelevoiture)

					ESX.Game.SpawnLocalVehicle(modelevoiture, {x = -51.38, y = -1094.05, z = 26.42}, 251.959, function (vehicle)
					table.insert(derniervoituresorti, vehicle)
					FreezeEntityPosition(vehicle, true)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetModelAsNoLongerNeeded(modelevoiture)
					end)
                end
            end, RMenu:Get('concessvente', 'achatvehicule'))

        	end
            end, function()
            end)

        RageUI.IsVisible(RMenu:Get('concessvente', 'achatvehicule'), true, true, true, function()
        	RageUI.ButtonWithStyle("Nom du modèle : "..nomvoiture, nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then   
            end
            end)
            RageUI.ButtonWithStyle("Prix du véhicule : "..prixvoiture.."$", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then   
            end
            end)
            RageUI.ButtonWithStyle("Vendre au client", "Attribue le véhicule au client le plus proche (paiement avec argent entreprise)", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then   
            	ESX.TriggerServerCallback('h4ci_concess:verifsousconcess', function(suffisantsous)
                if suffisantsous then

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification('Personne autour')
				else
				supprimervehiculeconcess()
				chargementvoiture(modelevoiture)

				ESX.Game.SpawnVehicle(modelevoiture, {x = -51.38, y = -1094.05, z = 26.42}, 251.959, function (vehicle)
				table.insert(sortirvoitureacheter, vehicle)
				FreezeEntityPosition(vehicle, true)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				SetModelAsNoLongerNeeded(modelevoiture)
				local plaque     = GeneratePlate()
                local vehicleProps = ESX.Game.GetVehicleProperties(sortirvoitureacheter[#sortirvoitureacheter])
                vehicleProps.plate = plaque
                SetVehicleNumberPlateText(sortirvoitureacheter[#sortirvoitureacheter], plaque)
                FreezeEntityPosition(sortirvoitureacheter[#sortirvoitureacheter], false)

				TriggerServerEvent('h4ci_concess:vendrevoiturejoueur', GetPlayerServerId(closestPlayer), vehicleProps, prixvoiture)
				ESX.ShowNotification('Le véhicule '..nomvoiture..' avec la plaque '..vehicleProps.plate..' a été vendu à '..GetPlayerName(closestPlayer))
                TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
				end)
				end
                else
                    ESX.ShowNotification('La société n\'as pas assez d\'argent pour ce véhicule!')
                end

            end, prixvoiture)
                end
            end)

            RageUI.ButtonWithStyle("Acheter le véhicule", "Attribue le véhicule à vous même ( argent de societé )", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                    ESX.TriggerServerCallback('h4ci_concess:verifsousconcess', function(suffisantsous)
                    if suffisantsous then
                    supprimervehiculeconcess()
                    chargementvoiture(modelevoiture)
                    ESX.Game.SpawnVehicle(modelevoiture, {x = -51.38, y = -1094.05, z = 26.42}, 251.959, function (vehicle)
                    table.insert(sortirvoitureacheter, vehicle)
                    FreezeEntityPosition(vehicle, true)
                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    SetModelAsNoLongerNeeded(modelevoiture)
                    local plaque     = GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(sortirvoitureacheter[#sortirvoitureacheter])
                    vehicleProps.plate = plaque
                    SetVehicleNumberPlateText(sortirvoitureacheter[#sortirvoitureacheter], plaque)
                    FreezeEntityPosition(sortirvoitureacheter[#sortirvoitureacheter], false)

                    TriggerServerEvent('shop:vehicule', vehicleProps, prixvoiture)
                    ESX.ShowNotification('Le véhicule '..nomvoiture..' avec la plaque '..vehicleProps.plate..' a été vendu à '..GetPlayerName(closestPlayer))
                    TriggerServerEvent('esx_vehiclelock:registerkey', vehicleProps.plate, GetPlayerServerId(closestPlayer))
                    end)

                    else
                        ESX.ShowNotification('La société n\'as pas assez d\'argent pour ce véhicule!')
                    end
    
                end, prixvoiture)
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('concessvente', 'annonces'), true, true, true, function()
                
                RageUI.ButtonWithStyle("Ouvert", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('Open:Ads')
                    end
                end)

                RageUI.ButtonWithStyle("Fermer", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('Close:Ads')
                    end
                end)

                RageUI.ButtonWithStyle("Personnalisé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local msg = KeyboardInput("Message", "", 100)
                        ExecuteCommand("acon" ..msg)
                    end
                end)

                end, function()
                end)

            Citizen.Wait(0)
        end
    else
        concesspointvente = false
    end
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, -45.23, -1093.43, 26.39)
            if jobdist <= 1.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'concess' then  
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au menu concess")
                    if IsControlJustPressed(1,51) then
                    	ESX.TriggerServerCallback('h4ci_concess:recuperercategorievehicule', function(catevehi)
                            h4ci_conc.catevehi = catevehi
                        end)
                        concesspointvente = false
                        ouvrirpointventeconc()
                    end   
                end
               end 
        end
end)

function supprimervehiculeconcess()
	while #derniervoituresorti > 0 do
		local vehicle = derniervoituresorti[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(derniervoituresorti, 1)
	end
end

function chargementvoiture(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName('shop_awaiting_model')
		EndTextCommandBusyString(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
			DisableAllControlActions(0)
		end

		RemoveLoadingPrompt()
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

------------