ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

local Menu = {
    action = {
        '~g~Argent Liquide~s~',
        '~b~Argent en Banque~s~',
        '~r~Argent Sale~s~',
    },
list = 1
}


--==--==--==--
-- Noclip
--==--==--==--


function DrawPlayerInfo(target)
	drawTarget = target
	drawInfo = true
end

function StopDrawPlayerInfo()
	drawInfo = false
	drawTarget = 0
end
Citizen.CreateThread( function()
	while true do
		Citizen.Wait(0)
		if drawInfo then
			local text = {}
			-- cheat checks
			local targetPed = GetPlayerPed(drawTarget)
			
			table.insert(text,"E pour stop spectate")
			
			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end
			
			if IsControlJustPressed(0,103) then
				local targetPed = PlayerPedId()
				local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
	
				RequestCollisionAtCoord(targetx,targety,targetz)
				NetworkSetInSpectatorMode(false, targetPed)
	
				StopDrawPlayerInfo()
				
			end
			
		end
	end
end)
function SpectatePlayer(targetPed,target,name)
    local playerPed = PlayerPedId() -- yourself
	enable = true
	if targetPed == playerPed then enable = false end

    if(enable)then

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
		DrawPlayerInfo(target)
        ESX.ShowNotification('~g~Mode spectateur en cours')
    else

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
		StopDrawPlayerInfo()
        ESX.ShowNotification('~b~Mode spectateur arrêtée')
    end
end

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    Button(GetControlInstructionalButton(2, config.controls.openKey, true))
    ButtonMessage("Disable Noclip")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, config.controls.goUp, true))
    ButtonMessage("Go Up")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, config.controls.goDown, true))
    ButtonMessage("Go Down")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, config.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, config.controls.turnLeft, true))
    ButtonMessage("Turn Left/Right")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, config.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, config.controls.goForward, true))
    ButtonMessage("Go Forwards/Backwards")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, config.controls.changeSpeed, true))
    ButtonMessage("Change Speed ("..config.speeds[index].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(config.bgR)
    PushScaleformMovieFunctionParameterInt(config.bgG)
    PushScaleformMovieFunctionParameterInt(config.bgB)
    PushScaleformMovieFunctionParameterInt(config.bgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

config = {
    controls = {
        -- [[Controls, list can be found here : https://docs.fivem.net/game-references/controls/]]
        openKey = 288, -- [[F2]]
        goUp = 85, -- [[Q]]
        goDown = 48, -- [[Z]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { label = "Very Slow", speed = 0},
        { label = "Slow", speed = 0.5},
        { label = "Normal", speed = 2},
        { label = "Fast", speed = 4},
        { label = "Very Fast", speed = 6},
        { label = "Extremely Fast", speed = 10},
        { label = "Extremely Fast v2.0", speed = 20},
        { label = "Max Speed", speed = 25}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 3, -- [[How much you rotate. ]]
    },

    -- [[Background colour of the buttons. (It may be the standard black on first opening, just re-opening.)]]
    bgR = 0, -- [[Red]]
    bgG = 0, -- [[Green]]
    bgB = 0, -- [[Blue]]
    bgA = 80, -- [[Alpha]]
}


noclipActive = false -- [[Wouldn't touch this.]]

index = 1 -- [[Used to determine the index of the speeds table.]]

Citizen.CreateThread(function()

    buttons = setupScaleform("instructional_buttons")

    currentSpeed = config.speeds[index].speed

    while true do
        Citizen.Wait(1)

        if noclipActive then
            DrawScaleformMovieFullscreen(buttons)

            local yoff = 0.0
            local zoff = 0.0

            if IsControlJustPressed(1, config.controls.changeSpeed) then
                if index ~= 8 then
                    index = index+1
                    currentSpeed = config.speeds[index].speed
                else
                    currentSpeed = config.speeds[1].speed
                    index = 1
                end
                setupScaleform("instructional_buttons")
            end

			if IsControlPressed(0, config.controls.goForward) then
                yoff = config.offsets.y
			end
			
            if IsControlPressed(0, config.controls.goBackward) then
                yoff = -config.offsets.y
			end
			
            if IsControlPressed(0, config.controls.turnLeft) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+config.offsets.h)
			end
			
            if IsControlPressed(0, config.controls.turnRight) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-config.offsets.h)
			end
			
            if IsControlPressed(0, config.controls.goUp) then
                zoff = config.offsets.z
			end
			
            if IsControlPressed(0, config.controls.goDown) then
                zoff = -config.offsets.z
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
            local heading = GetEntityHeading(noclipEntity)
            SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(noclipEntity, heading)
            SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
        end
    end
end)

--==--==--==--
-- Noclip fin
--==--==--==--
  
 function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    return x,y,z
  end
  
  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
    local pitch = GetGameplayCamRelativePitch()
  
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
  
    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end
  
    return x,y,z
  end
  


  function KeyBoardText(TextEntry, ExampleText, MaxStringLength)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
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


function admin_tp_marker()
    
    local playerPed = GetPlayerPed(-1)
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
        SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
  ESX.ShowAdvancedNotification("Administration", "", "TP Sur Marqueur : ~g~Réussi !", "CHAR_DREYFUSS", 1)                 
    else
  ESX.ShowAdvancedNotification("Administration", "", "~r~Aucun Marqueur !", "CHAR_DREYFUSS", 1)                  
    end
end

  function GiveCash()
    local amount = KeyBoardText("Somme", "", 8)

    if amount ~= nil then
        amount = tonumber(amount)
        
        if type(amount) == 'number' then
            TriggerServerEvent('Administration:GiveCash', amount)
        end
    end
end


function GiveBanque()
    local amount = KeyBoardText("Somme", "", 8)

    if amount ~= nil then
        amount = tonumber(amount)
        
        if type(amount) == 'number' then
            TriggerServerEvent('Administration:GiveBanque', amount)
        end
    end
end

function FullVehicleBoost()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 14, 0, true)
		SetVehicleNumberPlateTextIndex(vehicle, 5)
		ToggleVehicleMod(vehicle, 18, true)
		SetVehicleColours(vehicle, 0, 0)
		SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
		SetVehicleModColor_2(vehicle, 5, 0)
		SetVehicleExtraColours(vehicle, 111, 111)
		SetVehicleWindowTint(vehicle, 2)
		ToggleVehicleMod(vehicle, 22, true)
		SetVehicleMod(vehicle, 23, 11, false)
		SetVehicleMod(vehicle, 24, 11, false)
		SetVehicleWheelType(vehicle, 12) 
		SetVehicleWindowTint(vehicle, 3)
		ToggleVehicleMod(vehicle, 20, true)
		SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
		LowerConvertibleRoof(vehicle, true)
		SetVehicleIsStolen(vehicle, false)
		SetVehicleIsWanted(vehicle, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetCanResprayVehicle(vehicle, true)
		SetPlayersLastVehicle(vehicle)
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleTyresCanBurst(vehicle, false)
		SetVehicleWheelsCanBreak(vehicle, false)
		SetVehicleCanBeTargetted(vehicle, false)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
		SetVehicleHasStrongAxles(vehicle, true)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleCanBeVisiblyDamaged(vehicle, false)
		IsVehicleDriveable(vehicle, true)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleStrong(vehicle, true)
		RollDownWindow(vehicle, 0)
		RollDownWindow(vehicle, 1)
		SetVehicleNeonLightEnabled(vehicle, 0, true)
		SetVehicleNeonLightEnabled(vehicle, 1, true)
		SetVehicleNeonLightEnabled(vehicle, 2, true)
		SetVehicleNeonLightEnabled(vehicle, 3, true)
		SetVehicleNeonLightsColour(vehicle, 0, 0, 255)
		SetPedCanBeDraggedOut(PlayerPedId(), false)
		SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
		SetPedRagdollOnCollision(PlayerPedId(), false)
		ResetPedVisibleDamage(PlayerPedId())
		ClearPedDecorations(PlayerPedId())
		SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
		for i = 0,14 do
			SetVehicleExtra(veh, i, 0)
		end
		SetVehicleModKit(veh, 0)
		for i = 0,49 do
			local custom = GetNumVehicleMods(veh, i)
			for j = 1,custom do
				SetVehicleMod(veh, i, math.random(1,j), 1)
			end
		end
	end
end

function DrawTxt(text,r,z)
    SetTextColour(MainColor.r, MainColor.g, MainColor.b, 255)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(r,z)
 end

Citizen.CreateThread(function()
    while true do
    	if Admin.showcoords then
            x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
            roundx=tonumber(string.format("%.2f",x))
            roundy=tonumber(string.format("%.2f",y))
            roundz=tonumber(string.format("%.2f",z))
            DrawTxt("~r~X:~s~ "..roundx,0.05,0.00)
            DrawTxt("     ~r~Y:~s~ "..roundy,0.11,0.00)
            DrawTxt("        ~r~Z:~s~ "..roundz,0.17,0.00)
            DrawTxt("             ~r~Angle:~s~ "..GetEntityHeading(PlayerPedId()),0.21,0.00)
        end
    	Citizen.Wait(0)
    end
end)

Admin = {
	showcoords = false,
}
MainColor = {
	r = 225, 
	g = 55, 
	b = 55,
	a = 255
}

function GiveND()
    local amount = KeyBoardText("Somme", "", 8)

    if amount ~= nil then
        amount = tonumber(amount)
        
        if type(amount) == 'number' then
            TriggerServerEvent('Administration:GiveND', amount)
        end
    end
end


function changer_skin()
    TriggerEvent('esx_skin:openSaveableMenu', source)
end

local ServersIdSession = {}

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)

function admin_mode_fantome()
    invisible = not invisible
    local ped = GetPlayerPed(-1)
    
    if invisible then 
          SetEntityVisible(ped, false, false)
          ESX.ShowAdvancedNotification("Administration", "", "Invisibilité : ~g~activé", "CHAR_DREYFUSS", 1) 
      else
          SetEntityVisible(ped, true, false)
          ESX.ShowAdvancedNotification("Administration", "", "Invisibilité : ~r~désactivé", "CHAR_DREYFUSS", 1) 
    end
  end


  function admin_vehicle_flip()

    local player = GetPlayerPed(-1)
    posdepmenu = GetEntityCoords(player)
    carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
    if carTargetDep ~= nil then
            platecarTargetDep = GetVehicleNumberPlateText(carTargetDep)
    end
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    playerCoords = playerCoords + vector3(0, 2, 0)
    
    SetEntityCoords(carTargetDep, playerCoords)
    
    ESX.ShowAdvancedNotification("Administration", "", "~g~Véhicule retourné", "CHAR_DREYFUSS", 1) 

end


function admin_godmode()
    godmode = not godmode
    local ped = GetPlayerPed(-1)
    
    if godmode then -- activé
          SetEntityInvincible(ped, true)
    ESX.ShowAdvancedNotification("Administration", "", "Invincibilité : ~g~activé", "CHAR_DREYFUSS", 1) 
      else
          SetEntityInvincible(ped, false)
    ESX.ShowAdvancedNotification("Administration", "", "Invincibilité : ~r~désactivé", "CHAR_DREYFUSS", 1) 
    end
  end
  local invincible = false

  function admin_tp_toplayer()
	local plyId = KeyBoardText("ID", "", "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			local targetPlyCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(plyId)))
			SetEntityCoords(plyPed, targetPlyCoords)
		end
	end
end

RegisterNetEvent("hAdmin:envoyer")
AddEventHandler("hAdmin:envoyer", function(msg)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local head = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	ESX.ShowAdvancedNotification('Message du Staff', '~r~Informations', '~r~Raison ~w~: ' ..msg, headshot, 3)
end)

function admin_tp_playertome()
	local plyId = KeyBoardText("ID :", "", "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)
		
		if type(plyId) == 'number' then
			local plyPedCoords = GetEntityCoords(plyPed)
			print(plyId)
			TriggerServerEvent('KorioZ-PersonalMenu:Admin_BringS', plyId, plyPedCoords)
		end
	end
end


function DrawPlayerInfo(target)
    drawTarget = target
    drawInfo = true
end

function StopDrawPlayerInfo()
    drawInfo = false
    drawTarget = 0
end

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if drawInfo then
            local text = {}
            -- cheat checks
            local targetPed = GetPlayerPed(drawTarget)
            
            table.insert(text,"E pour stop spectate")
            
            for i,theText in pairs(text) do
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.30)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(theText)
                EndTextCommandDisplayText(0.3, 0.7+(i/30))
            end
            
            if IsControlJustPressed(0,103) then
                local targetPed = PlayerPedId()
                local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
    
                RequestCollisionAtCoord(targetx,targety,targetz)
                NetworkSetInSpectatorMode(false, targetPed)
    
                StopDrawPlayerInfo()
                
            end
            
        end
    end
end)

function SpectatePlayer(targetPed,target,name)
    local playerPed = PlayerPedId() -- yourself
    enable = true
    if targetPed == playerPed then enable = false end

    if(enable)then

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        DrawPlayerInfo(target)
        ESX.ShowNotification('~g~Mode spectateur en cours')
    else

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        StopDrawPlayerInfo()
        ESX.ShowNotification('~b~Mode spectateur arrêtée')
    end
end

RegisterCommand("spect", function(source, args, rawCommand) 
    ESX.TriggerServerCallback('RubyMenu:getUsergroup', function(group)
    playergroup = group
    if playergroup == 'superadmin' or playergroup == 'owner' then
    idnum = tonumber(args[1])
    local playerId = GetPlayerFromServerId(idnum)
    SpectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
    else
      ESX.ShowNotification("Vous n'avez pas accès à cette commande")
    end
  end)
  end)


RMenu.Add('AdminMenu', 'main', RageUI.CreateMenu("Menu Admin", "Intéractions"))
RMenu.Add('AdminMenu', 'perso', RageUI.CreateSubMenu(RMenu:Get('AdminMenu', 'main'), "Actions Perso", "Intéractions"))
RMenu.Add('AdminMenu', 'veh', RageUI.CreateSubMenu(RMenu:Get('AdminMenu', 'main'), "Actions Véhicules", "Intéractions"))
RMenu.Add('AdminMenu', 'joueurs', RageUI.CreateSubMenu(RMenu:Get('AdminMenu', 'main'), "Liste des joueurs", "Intéractions"))
RMenu.Add('AdminMenu', 'options', RageUI.CreateSubMenu(RMenu:Get('AdminMenu', 'joueurs'), "Actions sur joueur", "Intéractions"))


Citizen.CreateThread(function()
    while true do

                   RageUI.IsVisible(RMenu:Get('AdminMenu', 'main'), true, true, true, function()
                    RageUI.Checkbox("Mode Administration",nil, service,{},function(Hovered,Ative,Selected,Checked)
                        if (Selected) then
        
                            service = Checked
        
        
                            if Checked then
                                onservice = true
                                local head = RegisterPedheadshot(PlayerPedId())
                                while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
                                    Wait(1)
                                end
                                headshot = GetPedheadshotTxdString(head)
                                SetPedPropIndex(GetPlayerPed(-1) , 0, 91, 9)   --helmet
                                SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0) --tshirt 
                                SetPedComponentVariation(GetPlayerPed(-1) , 11, 178, 9)  --torse
                                SetPedComponentVariation(GetPlayerPed(-1) , 4, 77, 9)   --pants
                                SetPedComponentVariation(GetPlayerPed(-1) , 6, 55, 9)   --shoes
                                RageUI.Text({
                                message = "~g~Mode Administration actif",
                                    time_display = 4555555555555
                                })        
                                
                            else
                                onservice = false
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                SetPedPropIndex(GetPlayerPed(-1) , 0, 11, 0)
                                end)
                                RageUI.Text({
                                message = "~r~Mode Administration Désactivé",
                                    time_display = 2500
                                })          
                            end
                        end
                    end)
        
                    if onservice then

                        RageUI.ButtonWithStyle("Actions Perso", nil, {RightLabel = "→"},true, function()
                        end, RMenu:Get('AdminMenu', 'perso'))

                        RageUI.ButtonWithStyle("Actions Véhicules", nil, {RightLabel = "→"},true, function()
                        end, RMenu:Get('AdminMenu', 'veh'))

                        RageUI.ButtonWithStyle("Liste des joueurs", nil, { RightLabel = "→" },true, function()
						end, RMenu:Get('AdminMenu', 'joueurs'))

                        RageUI.ButtonWithStyle("Menu Wipe", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                RageUI.CloseAll()
                                ExecuteCommand("wipe")
                            end
                        end)
                                                          
                    end


                    end, function()
                    end)

                        RageUI.IsVisible(RMenu:Get('AdminMenu', 'perso'), true, true, true, function()


                            RageUI.ButtonWithStyle("TP-Marqueur", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    admin_tp_marker()
                                end
                            end)

                            RageUI.ButtonWithStyle("Afficher/Cacher coordonnées",description, {}, true, function(Hovered, Active, Selected)
                                if (Selected) then   
                                    Admin.showcoords = not Admin.showcoords    
                                    end   
                                end)

        
                            RageUI.ButtonWithStyle("NoClip", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                                if Selected then
                                        noclipActive = not noclipActive

                                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                                            noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
                                        else
                                            noclipEntity = PlayerPedId()
                                        end
                            
                                        SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
                                        FreezeEntityPosition(noclipEntity, noclipActive)
                                        SetEntityInvincible(noclipEntity, noclipActive)
                                        SetVehicleRadioEnabled(noclipEntity, not noclipActive) -- [[Stop radio from appearing when going upwards.]]
                                end
                            end)
        
                            RageUI.Checkbox("GodMod",nil, checkbox2,{},function(Hovered,Active,Selected,Checked)
                                if Selected then
                                    checkbox2 = Checked
                                    if Checked then
                                        Checked = true
                                        admin_godmode()
                                    else
                                        admin_godmode()
                                    end
                                end
                            end)
        
                            RageUI.Checkbox("Invisible",nil, checkbox3,{},function(Hovered,Active,Selected,Checked)
                                if Selected then
                                    checkbox3 = Checked
                                    if Checked then
                                        Checked = true
                                        admin_mode_fantome()
                                    else
                                        admin_mode_fantome()
                                    end
                                end
                            end)
    
    
                            RageUI.List('Give', Menu.action, Menu.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)
                                if (Selected) then 
                                    if Index == 1 then
                                        GiveCash()
                                elseif Index == 2 then
                                    GiveBanque()
                                elseif Index == 3 then
                                    GiveND()
                                end
                            end
                               Menu.list = Index;              
                            end)
        
                                        RageUI.ButtonWithStyle("Changer D'apparence", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                                            if (Selected) then
                                                changer_skin()
                                                RageUI.CloseAll()
                                            end
                                        end)

                                    end, function()
                                    end)
                                        RageUI.IsVisible(RMenu:Get('AdminMenu', 'veh'), true, true, true, function()

                                            RageUI.ButtonWithStyle("Spawn un véhicule", nil, {RightLabel = ""}, true, function(_, _, Selected)
                                                if Selected then                                                                
                                                   local ped = GetPlayerPed(tgt)
                                                   local ModelName = KeyBoardText("Véhicule", "", 100)
                                                 if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                                                   RequestModel(ModelName)
                                                   while not HasModelLoaded(ModelName) do
                                                   Citizen.Wait(0)
                                                end
                                                local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), true, true)
                                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                                    Wait(50)
                                                else
                                                ESX.ShowNotification("~r~Vehicule invalide !")
                                                end
                                            end
                                        end)
        
                                            RageUI.ButtonWithStyle("Réparer le véhicule", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)                                                                                                                   
                                                if Selected then
                                                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                                            vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                                                            if DoesEntityExist(vehicle) then
                                                            SetVehicleFixed(vehicle)
                                                            SetVehicleDeformationFixed(vehicle)
                                                         end
                                                      end
                                                   end
                                               end)

                                               RageUI.ButtonWithStyle("Retourner le véhicule", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                    admin_vehicle_flip()
                                                end
                                            end)

                                            RageUI.ButtonWithStyle("Custom maximum", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                                                if (Selected) then   
                                                FullVehicleBoost()
                                                end   
                                            end) 

                                            RageUI.ButtonWithStyle("Changer la plaque", nil, {}, true, function(_, Active, Selected)
                                                if Selected then
                                                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                                                        local plaqueVehicule = KeyBoardText("Plaque", "", 8)
                                                        SetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false) , plaqueVehicule)
                                                        ESX.ShowNotification("La plaque du véhicule est désormais : ~g~"..plaqueVehicule)
                                                    else
                                                        ESX.ShowNotification("~r~Erreur\n~s~Vous n'êtes pas dans un véhicule !")
                                                    end
                                                end
                                                end)
                                   
                                        end, function()
                                        end)


                                        RageUI.IsVisible(RMenu:Get('AdminMenu', 'joueurs'), true, true, true, function()

                                            for k,v in ipairs(ServersIdSession) do
                                                if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) end
                                                RageUI.ButtonWithStyle("ID : "..v.." → " ..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        IdSelected = v
                                                    end
                                                end, RMenu:Get('AdminMenu', 'options'))
                                            end
                                   
                                        end, function()
                                        end)
                                        

                                        RageUI.IsVisible(RMenu:Get('AdminMenu', 'options'), true, true, true, function()

                                            RageUI.Separator("Joueur : "..GetPlayerName(GetPlayerFromServerId(IdSelected)))

                                            RageUI.ButtonWithStyle("Envoyer un message", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                    local msg = KeyBoardText("Raison", "", 100)
                        
                                                    if msg ~= nil then
                                                        msg = tostring(msg)
                                                
                                                        if type(msg) == 'string' then
                                                            TriggerServerEvent("hAdmin:Message", IdSelected, msg)
                                                        end
                                                    end
                                                    ESX.ShowNotification("Vous venez d'envoyer le message à ~b~" .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
                                                end
                                            end)
                        
                                            RageUI.ButtonWithStyle("Téléporter sur joueur", nil, {}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                    SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(IdSelected))))
                                                    ESX.ShowNotification('~b~Vous venez de vous Téléporter à~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..'')
                                                end
                                            end)
                        
                                            RageUI.ButtonWithStyle("Téléporter à vous", nil, {}, true, function(Hovered, Active, Selected, target)
                                                if (Selected) then
                                                    ExecuteCommand("bring "..IdSelected)
                                                    ESX.ShowNotification('~b~Vous venez de Téléporter ~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' ~b~à vous~s~ !')
                                                end
                                            end)
                        
                                            RageUI.ButtonWithStyle("Spectate", nil, {}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                local playerId = GetPlayerFromServerId(IdSelected)
                                                    SpectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
                                                end
                                            end)
                        
                                            RageUI.Checkbox("Freeze / Defreeze", description, Frigo,{},function(Hovered,Ative,Selected,Checked)
                                                if Selected then
                                                    Frigo = Checked
                                                    if Checked then
                                                        ESX.ShowNotification("~r~Joueur Freeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
                                                        ExecuteCommand("freeze "..IdSelected)
                                                    else
                                                        ESX.ShowNotification("~g~Joueur Defreeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
                                                        ExecuteCommand("freeze "..IdSelected)
                                                    end
                                                end
                                            end)
                        
                                            if superadmin then
                                                RageUI.ButtonWithStyle("Wipe l'inventaire", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("clearinventory "..IdSelected)
                                                        ESX.ShowNotification("Vous venez d'enlever tout les items de ~b~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~s~ !")
                                                    end
                                                end)
                                            end
                        
                                            if superadmin then
                                                RageUI.ButtonWithStyle("Wipe les armes", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("clearloadout "..IdSelected)
                                                        ESX.ShowNotification("Vous venez de enlever toutes les armes de ~b~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~s~ !")
                                                    end
                                                end)
                                            end
                        
                                            RageUI.ButtonWithStyle("Give un item", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                    local item = KeyBoardText("Item", "", 10)
                                                    local amount = KeyBoardText("Nombre", "", 10)
                                                    if item and amount then
                                                        ExecuteCommand("giveitem "..IdSelected.. " " ..item.. " " ..amount)
                                                        ESX.ShowNotification("Vous venez de donner ~g~"..amount.. " " .. item .. " ~w~à " .. GetPlayerName(GetPlayerFromServerId(IdSelected)))	
                                                    else
                                                        RageUI.CloseAll()	
                                                    end			
                                                end
                                            end)
                        
                                            if superadmin then
                                                RageUI.ButtonWithStyle("Give une arme", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        local weapon = KeyBoardText("WEAPON_...", "", 100)
                                                        local ammo = KeyBoardText("Munitions", "", 100)
                                                        if weapon and ammo then
                                                            ExecuteCommand("giveweapon "..IdSelected.. " " ..weapon.. " " ..ammo)
                                                            ESX.ShowNotification("Vous venez de donner ~g~"..weapon.. " avec " .. ammo .. " munitions ~w~à " .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
                                                        else
                                                            RageUI.CloseAll()	
                                                        end
                                                    end
                                                end)

                                                RageUI.ButtonWithStyle("~o~Kick", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        local raison = KeyBoardText("Raison du kick", "", 100)
                                                        ExecuteCommand('kick '..IdSelected.. " " ..raison)
                                                    end
                                                end)
                        
                                                RageUI.ButtonWithStyle("~r~Ban", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        local quelid = KeyBoardText("ID", "", 100)
                                                        local day = KeyBoardText("Jours", "", 100)
                                                        local raison = KeyBoardText("Raison du kick", "", 100)
                                                        if quelid and day and raison then
                                                            ExecuteCommand("sqlban "..quelid.. " " ..day.. " " ..raison)
                                                            ESX.ShowNotification("Vous venez de ban l\'ID :"..quelid.. " " ..day.. " pour la raison suivante : " ..raison)
                                                        else
                                                            RageUI.CloseAll()	
                                                        end
                                                    end
                                                end)
                        
                                            end
                                   
                                        end, function()
                                        end)


                        Citizen.Wait(0)
                    end
                end)

----------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
    if IsControlJustPressed(0, 82) then
        ESX.TriggerServerCallback('RubyMenu:getUsergroup', function(group)
            playergroup = group
            if playergroup == 'superadmin' then
                superadmin = true
            RageUI.Visible(RMenu:Get('AdminMenu', 'main'), not RageUI.Visible(RMenu:Get('AdminMenu', 'main')))
            else
                superadmin = false
            end
        end)
    end 
end
end)