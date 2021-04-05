--[[

    boatdealer • v1.0

    This script was made by Pablo1610 
        
    Twitch: https://twitch.tv/pablo_1610)

    Discord: https://discord.gg/Ksyc97N

]]

ESX = nil

local menuIsOpen = false
local avaibleVehicles = nil
local colorVar = "~o~"
local hasLoadedAllModels = false
local currentPreviewVehicle = 1
local heading = 0.0
local currentPreviewVeh = nil
local currentPreviewModel = nil
local awaitingServerCallback = false
local cam = nil

local currentGarage = nil
local ownedVehicles = nil
local awaitingOwnedVehicles = true
local awaitingVehicleOut = false
local requestedOutVehicle = {}

RegisterNetEvent("esx_boatdealer:okOut")
AddEventHandler("esx_boatdealer:okOut", function()
	local vehID = requestedOutVehicle.id
	local props = requestedOutVehicle.props
	local model = GetHashKey(requestedOutVehicle.model)
	awaitingVehicleOut = false
	local selectedSpawn = entry_points[currentGarage].outPossibilites[math.random(1,#entry_points[currentGarage].outPossibilites)]
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(1) end
	local currentVeh = CreateVehicle(model, selectedSpawn.pos, selectedSpawn.heading, true, false)
	SetEntityAsMissionEntity(currentVeh, 1, 1)
	TaskWarpPedIntoVehicle(PlayerPedId(), currentVeh, -1)
	DecorSetInt(currentVeh, "owner", GetPlayerServerId(PlayerId()))
	DecorSetInt(currentVeh, "vehicleID", vehID)
	ESX.Game.SetVehicleProperties(currentVeh, json.decode(props))
end)

RegisterNetEvent("esx_boatdealer:callbackboats")
AddEventHandler("esx_boatdealer:callbackboats", function(vehs)
    ownedVehicles = vehs
end)

RegisterNetEvent("esx_boatdealer:serverCallback")
AddEventHandler("esx_boatdealer:serverCallback", function(success)
    if success then
        awaitingServerCallback = false
        PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
        ESX.ShowNotification(msg_boat_purchassed)
    else 
        ESX.ShowNotification(msg_no_enough_money)
    end
end)

RegisterNetEvent("esx_boatdealer:callbackVehicles")
AddEventHandler("esx_boatdealer:callbackVehicles", function(vehicles)
    avaibleVehicles = vehicles
end)


local function loadModels()
    Citizen.CreateThread(function()
        for k,v in pairs(avaibleVehicles) do
            local model = GetHashKey(v.model)
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(1) end
        end
        hasLoadedAllModels = true
        if menuIsOpen then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
            SetCamCoord(cam, -1419.63, -1573.52, 10.86)
            SetCamActive(cam, true)
            SetCamFov(cam, 80.0)
            PointCamAtCoord(cam, preview_position)
            RenderScriptCams(1, 2500, 2500, 0, 0)
        end
    end)
end

local titleByState = {[0] = "", [1] = "~r~"..msg_out_prefix.." ~s~"}

local function openGarageEntryMenu(entryGarage)
	currentGarage = entryGarage
    ownedVehicles = nil
    awaitingOwnedVehicles = true
	requestedOutVehicle = {}
	if awaitingVehicleOut then return end
    if menuIsOpen then return end
    menuIsOpen = true
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerServerEvent("esx_boatdealer:requestOwnedboats")
    RMenu.Add("boatdealer", "boatdealer_garage", RageUI.CreateMenu(menu_garage_title,menu_garage_subtitle))
    RMenu:Get("boatdealer", "boatdealer_garage").Closed = function() end
    RageUI.Visible(RMenu:Get("boatdealer",'boatdealer_garage'),true)

	Citizen.CreateThread(function()
        while menuIsOpen do
            Wait(800)
            if colorVar == "~o~" then colorVar = "~r~" else colorVar = "~o~" end
        end
    end)

    Citizen.CreateThread(function()
        while menuIsOpen do
            shouldStayOpened = false

			RageUI.IsVisible(RMenu:Get("boatdealer",'boatdealer_garage'),true,true,true,function()
				shouldStayOpened = true
				if ownedVehicles == nil then
					RageUI.Separator("") RageUI.Separator(colorVar..msg_loading_owned_boats) RageUI.Separator("")
				else
					if not awaitingVehicleOut then
						if #ownedVehicles <= 0 then
							RageUI.Separator("") RageUI.Separator(colorVar..msg_no_boats) RageUI.Separator("")
						else
							RageUI.Separator("↓ "..colorVar..menu_garage_separator_owned_vehicles.." ~s~↓")
							for k,v in pairs(ownedVehicles) do
								RageUI.ButtonWithStyle(titleByState[v.outside].."~y~"..v.model.." ~b~(#"..v.id..")", nil, {RightLabel = "~g~"..menu_garage_rightlabel_out.." ~s~→→"}, v.outside == 0, function(Hovered,Active,Selected)
									if Selected then 
										awaitingVehicleOut = true
										requestedOutVehicle = v
										TriggerServerEvent("esx_boatdealer:outFromGarage", v.id)
										shouldStayOpened = false
									end
								end)
							end
						end
					else
						RageUI.Separator("") RageUI.Separator(colorVar..msg_loading_server_synchronization) RageUI.Separator("")
					end
				end
			end, function()    
			end, 1)

			Wait(0)
            if not shouldStayOpened then menuIsOpen = false end
        end
        FreezeEntityPosition(PlayerPedId(), false)
        RMenu:Delete("boatdealer","boatdealer_garage")
        menuIsOpen = false
    end)
end

local function openMenu()
    cam = nil
    currentPreviewModel = nil
    currentPreviewVeh = nil
    previewHeading = 0.0
    hasLoadedAllModels = false
    avaibleVehicles = nil
    if awaitingServerCallback then 
        ESX.ShowNotification(msg_awaiting_server_response)
    return end
    if menuIsOpen then return end
    TriggerServerEvent("esx_boatdealer:requestVehicles")
    FreezeEntityPosition(PlayerPedId(), true)
    menuIsOpen = true
    RMenu.Add("boatdealer", "boatdealer_main", RageUI.CreateMenu(menu_boatdealer_title,menu_boatdealer_subtitle))
    RMenu.Add('boatdealer', 'boatdealer_fetch', RageUI.CreateSubMenu(RMenu:Get('boatdealer', 'boatdealer_main'), menu_boatdealer_title, menu_boatdealer_subtitle))
    RMenu:Get("boatdealer", "boatdealer_main").Closed = function() end
    RMenu:Get("boatdealer", "boatdealer_fetch").Closed = function() end
    RMenu:Get("boatdealer", "boatdealer_fetch").Closable = false
    RageUI.Visible(RMenu:Get("boatdealer",'boatdealer_main'),true)

    Citizen.CreateThread(function()
        while menuIsOpen do
            Wait(800)
            if colorVar == "~o~" then colorVar = "~r~" else colorVar = "~o~" end
        end
    end)

    Citizen.CreateThread(function()
        while menuIsOpen do
            if currentPreviewVeh then 
                heading = heading + 0.2
                SetEntityHeading(currentPreviewVeh, heading) 
            end
            Wait(1)
        end
    end)

    Citizen.CreateThread(function()
        while menuIsOpen do
            shouldStayOpened = false

            RageUI.IsVisible(RMenu:Get("boatdealer",'boatdealer_main'),true,true,true,function()
                shouldStayOpened = true
                if not avaibleVehicles then
                    RageUI.Separator("") RageUI.Separator(colorVar..msg_awaiting_server_infos) RageUI.Separator("")
                else
                    RageUI.ButtonWithStyle(menu_boatdealer_button_showVehicles, nil, {RightLabel = "~s~→→"}, true, function(Hovered,Active,Selected)
                        if Selected then 
                            loadModels()
                        end
                        
                    end, RMenu:Get("boatdealer","boatdealer_fetch"))
                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("boatdealer",'boatdealer_fetch'),true,true,true,function()
                shouldStayOpened = true
                if not hasLoadedAllModels then
                    RageUI.Separator("") RageUI.Separator(colorVar..msg_loading_boatdealer_vehicles) RageUI.Separator("")
                else
                    local requestModel = nil
                    RageUI.ButtonWithStyle("~r~Sortir", nil, {RightLabel = "~s~→→"}, true, function(Hovered,Active,Selected)
                        if Selected then 
                            shouldStayOpened = false
                        end
                    end)
                    RageUI.Separator("↓ "..colorVar.."Véhicules disponibles ~s~↓")
                    for k, v in pairs(avaibleVehicles) do 
                        RageUI.ButtonWithStyle("~y~"..v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(tonumber(v.price)).."$ ~s~→→"}, true, function(Hovered,Active,Selected)
                            if Active then
                                requestModel = v.model
                            end
                            if Selected then
                                TriggerServerEvent("esx_boatdealer:buyVehicle", k, ESX.Game.GetVehicleProperties(currentPreviewVeh))
                                awaitingServerCallback = true
                                shouldStayOpened = false
                            end
                        end)
                    end
                    if requestModel and requestModel ~= currentPreviewModel then
                        if currentPreviewVeh then DeleteEntity(currentPreviewVeh) end
                        currentPreviewModel = requestModel
                        currentPreviewVeh = CreateVehicle(GetHashKey(requestModel), preview_position, 0, false, false)
                        SetEntityAsMissionEntity(currentPreviewVeh, 1,1)
                        SetEntityAlpha(currentPreviewVeh, 155, false)
                    end
                end
            end, function()    
            end, 1)

            Wait(0)
            if not shouldStayOpened then menuIsOpen = false end
        end
        if currentPreviewVeh then DeleteEntity(currentPreviewVeh) end
        RenderScriptCams(0, 0, 0, 0, 0)
        FreezeEntityPosition(PlayerPedId(), false)
        RMenu:Delete("boatdealer","boatdealer_main")
        RMenu:Delete("boatdealer","boatdealer_fetch")
        menuIsOpen = false
    end)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) -- REMPLACEZ CETTE LIGNE EN FONCTION DE VOTRE SERVEUR !
		Citizen.Wait(0)
	end

    DecorRegister("owner", 3)
    DecorRegister("vehicleID", 3)

    local blip = AddBlipForCoord(buy_marker)
    SetBlipAsShortRange(blip, true)
    SetBlipSprite(blip, 427)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(blip_boatdealer)
    EndTextCommandSetBlipName(blip)
    SetBlipColour(blip, 38)
    SetBlipScale(blip, 0.80)

    for k, v in pairs(entry_points) do
        local entryPos = v.open
        local entry = AddBlipForCoord(entryPos)
        SetBlipAsShortRange(entry, true)
        SetBlipSprite(entry, 427)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(blip_garage_out)
        EndTextCommandSetBlipName(entry)
        SetBlipColour(entry, 2)
        SetBlipScale(entry, 0.80)
    end

    for k, v in pairs(returnb_points) do
        local entryPos = v
        local out = AddBlipForCoord(entryPos)
        SetBlipAsShortRange(out, true)
        SetBlipSprite(out, 427)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(blip_garage_back)
        EndTextCommandSetBlipName(out)
        SetBlipColour(out, 1)

        SetBlipScale(out, 0.80)
    end

    local interval = 0
    while true do
        interval = 150
        local position = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(buy_marker, position, true)
        if distance <= 100 then
            interval = 1
            DrawMarker(22, buy_marker, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255,0,0, 255, 55555, false, true, 2, false, false, false, false)
            if distance <= 1.5 then
                ESX.ShowHelpNotification(help_open_boatdealer)
                if IsControlJustPressed(0, 51) then
                    openMenu()
                end
            end 
        end

        for k, v in pairs(entry_points) do
            local entryPos = v.open
            local distanceEntry = GetDistanceBetweenCoords(entryPos, position, true)
            if distanceEntry <= 100 then
                interval = 1
                DrawMarker(22, entryPos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 0,255,0, 255, 55555, false, true, 2, false, false, false, false)
                if distanceEntry <= 1.5 then
                    ESX.ShowHelpNotification(help_open_garage)
                    if IsControlJustPressed(0, 51) then
                        openGarageEntryMenu(k)
                    end
                end 
            end
        end

        for k, v in pairs(returnb_points) do
            local outPos = v
            local distanceOut = GetDistanceBetweenCoords(outPos, position, true)
            if distanceOut <= 600 then
                interval = 1
                DrawMarker(22, outPos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 8.0, 8.0, 8.0, 255,0,0, 255, 55555, false, true, 2, false, false, false, false)
                if distanceOut <= 15.0 then
                    if IsPedInAnyPlane(PlayerPedId()) or IsPedInAnyHeli(PlayerPedId()) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
                        ESX.ShowHelpNotification(help_open_garage_back)
                        if IsControlJustPressed(0, 51) then
                            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                            if not DecorExistOn(veh, "owner") or not DecorExistOn(veh, "vehicleID") then
                                ESX.ShowNotification(msg_not_vehicle_owner)
                            else
                                if DecorGetInt(veh, "owner") == GetPlayerServerId(PlayerId()) then
                                    NetworkRequestControlOfEntity(veh)
                                    while not NetworkHasControlOfEntity(veh) do Wait(1) end
                                    TriggerServerEvent("esx_boatdealer:vehicleBackToGarage", DecorGetInt(veh, "vehicleID"), DecorGetInt(veh, "owner"))
                                    DeleteEntity(veh)
                                end
                            end
                        end
                    end
                end 
            end
        end

        Wait(interval)
    end
end)


