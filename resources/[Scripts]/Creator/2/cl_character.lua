local sexeSelect = 0
local teteSelect = 0
local colorPeauSelect = 0
local cheveuxSelect = 0
local bebarSelect = -1
local poilsCouleurSelect = 0
local ImperfectionsPeau = 0
local face, acne, skin, eyecolor, skinproblem, freckle, wrinkle, hair, haircolor, eyebrow, beard, beardcolor
local camfin = false

--Nehco

PMenu = {}
PMenu.Data = {}

local playerPed = PlayerPedId()
local incamera = false
local board_scaleform
local handle
local board
local board_model = GetHashKey("prop_police_id_board")
local board_pos = vector3(0.0,0.0,0.0)
local overlay
local overlay_model = GetHashKey("prop_police_id_text")
local isinintroduction = false
local pressedenter = false
local introstep = 0
local timer = 0
local inputgroups = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}
local enanimcinematique = false
local guiEnabled = false

local sound = false




local function CallScaleformMethod (scaleform, method, ...)
	local t
	local args = { ... }

	BeginScaleformMovieMethod(scaleform, method)

	for k, v in ipairs(args) do
		t = type(v)
		if t == 'string' then
			PushScaleformMovieMethodParameterString(v)
		elseif t == 'number' then
			if string.match(tostring(v), "%.") then
				PushScaleformMovieFunctionParameterFloat(v)
			else
				PushScaleformMovieFunctionParameterInt(v)
			end
		elseif t == 'boolean' then
			PushScaleformMovieMethodParameterBool(v)
		end
	end
	EndScaleformMovieMethod()
end


local FirstSpawn     = true
local LastSkin       = nil
local PlayerLoaded   = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end
		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('Nehco:create')
				else
                    TriggerEvent('skinchanger:loadSkin', skin)
                    --spawncinematiqueplayer()
				end
			end)
			FirstSpawn = false
		end
	end)
end)

function createcamvisage(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.3, 0.0, 0.0, 88.455696105957, 15.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.3, 0.0, 0.0, 88.455696105957, 15.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamcinematique(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -265.7774, -357.2067, 49.9656, -35.0, 0.0, -30.6976, 40.0, false, 0) --  -490.69, -667.96, 47.43, Personnage marche
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -265.7774, -357.2067, 49.9656, -35.0, 0.0, -30.6976, 40.0, false, 0) --  -490.69, -667.96, 47.43, Fin de Marche
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end


function createcamyeux(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.3, 0.0, 0.0, 88.455696105957, 10.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.3, 0.0, 0.0, 88.455696105957, 10.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamtorse(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.3, 0.0, 0.0, 88.455696105957, 10.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.3, 0.0, 0.0, 88.455696105957, 10.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end


function createcam(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.2, -998.60, -98.5, -18.0, 0.0, 89.60, 70.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.2, -998.60, -98.5, -18.0, 0.0, 89.60, 70.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamfin(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 414.64, -998.16, -98.68, 0.0, 0.0, 88.455696105957, 60.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 414.64, -998.16, -98.68, 0.0, 0.0, 88.455696105957, 60.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamjambe(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.2, -998.60, -98.9, -18.0, 0.0, 89.60, 50.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.2, -998.60, -98.9, -18.0, 0.0, 89.60, 50.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamchaussure(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.2, -998.60, -99.1, -21.0, 0.0, 89.60, 50.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.2, -998.60, -99.1, -21.0, 0.0, 89.60, 50.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamtorse(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.75, 0.0, 0.0, 88.455696105957, 27.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 410.72, -998.68, -98.75, 0.0, 0.0, 88.455696105957, 27.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function CreateCamEnter()
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 415.55, -998.50, -99.29, 0.00, 0.00, 89.75, 50.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 2000, true, true) 
end



function SpawnCharacter()
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 411.30, -998.62, -99.01, 0.00, 0.00, 89.75, 50.00, false, 0)
    PointCamAtCoord(cam2, 411.30, -998.62, -99.01)
    SetCamActiveWithInterp(cam2, cam, 5000, true, true)
end

function destorycam()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    TriggerServerEvent('barbershop:removeposition')
end


function openCinematique()
	hasCinematic = not hasCinematic
	if not hasCinematic then
        SendNUIMessage({openCinema = false})
        ESX.UI.HUD.SetDisplay(1.0)
        TriggerEvent('es:setMoneyDisplay', 1.0)
        TriggerEvent('esx_status:setDisplay', 1.0)
        DisplayRadar(true)
        TriggerEvent('ui:toggle', true)
	elseif hasCinematic then
		SendNUIMessage({openCinema = true})
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('es:setMoneyDisplay', 0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
		DisplayRadar(false)
		TriggerEvent('ui:toggle', false)
	end
end




function startAnims(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 8.0, -1, 14, 0, false, false, false)
	end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	
	blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
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

local isCameraActive = false


ESX								= nil
isRegistered = nil

local sexeSelect = 0
local teteSelect = 0
local colorPeauSelect = 0
local cheveuxSelect = 0
local bebarSelect = -1
local poilsCouleurSelect = 0
local ImperfectionsPeau = 0
local face, acne, skin, eyecolor, skinproblem, freckle, wrinkle, hair, haircolor, eyebrow, beard, beardcolor


function LoadingPrompt(loadingText, spinnerType)

    if IsLoadingPromptBeingDisplayed() then
        RemoveLoadingPrompt()
    end

    if (loadingText == nil) then
        BeginTextCommandBusyString(nil)
    else
        BeginTextCommandBusyString("STRING");
        AddTextComponentSubstringPlayerName(loadingText);
    end

    EndTextCommandBusyString(spinnerType)
end

ESX = nil
PMenu = {}
PMenu.Data = {}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function LoadingPrompt(loadingText, spinnerType)

    if IsLoadingPromptBeingDisplayed() then
        RemoveLoadingPrompt()
    end

    if (loadingText == nil) then
        BeginTextCommandBusyString(nil)
    else
        BeginTextCommandBusyString("STRING");
        AddTextComponentSubstringPlayerName(loadingText);
    end

    EndTextCommandBusyString(spinnerType)
end

function openCinematique()
    hasCinematic = not hasCinematic
    if not hasCinematic then -- show
        SendNUIMessage({openCinema = false})
        ESX.UI.HUD.SetDisplay(1.0)
        TriggerEvent('es:setMoneyDisplay', 1.0)
        TriggerEvent('esx_status:setDisplay', 1.0)
        DisplayRadar(true)
        TriggerEvent('ui:toggle', true)
    elseif hasCinematic then -- hide
        SendNUIMessage({openCinema = true})
        ESX.UI.HUD.SetDisplay(0.0)
        TriggerEvent('es:setMoneyDisplay', 0.0)
        TriggerEvent('esx_status:setDisplay', 0.0)
        DisplayRadar(false)
        TriggerEvent('ui:toggle', false)
    end
end

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end
		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('Nehco:create')
				else
                    TriggerEvent('skinchanger:loadSkin', skin)
                    --spawncinematiqueplayer()
				end
			end)
			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent('Nehco:SpawnCharacter')
AddEventHandler('Nehco:SpawnCharacter', function(spawn)
	openCinematique()
	CloseMenu('creationPerso')
	DisplayRadar(false)
    PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    TriggerServerEvent('SavellPlayer')
	RenderScriptCams(0, 0, 1, 1, 1)
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    DoScreenFadeOut(0)
	SetTimecycleModifier('rply_saturation')
	SetTimecycleModifier('rply_vignette')
    SetEntityCoords(PlayerPedId(), -491.0, -737.32, 23.92-0.98)
    SetEntityHeading(PlayerPedId(), 359.3586730957)
    ExecuteCommand('e sitchair4')
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(1500)
	Citizen.Wait(3500)
    ClearPedTasks(GetPlayerPed(-1))
    TaskPedSlideToCoord(PlayerPedId(), -491.68, -681.96, 33.2, 359.3586730957, 1.0)
	Citizen.Wait(33000)
	openCinematique()
    SetTimecycleModifier('')
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    TriggerEvent('instance:close')
    for i = 0, 357 do
        EnableAllControlActions(i)
	end
	DisplayRadar(true)
	DrawSub("~g~NCore | Nehco", 5000)
end)

local sexe = { 
	"Homme",
	"Femme"
}

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry("FMMC_KEY_TIP1", TextEntry)
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


function DrawSub(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, 1)
end


local Character = {}

local pedlist ={
	"zeez",
	"Test",
	"DZD"
}

function createcamvisage(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.3, 0.0, 0.0, 0.455696105957, 15.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.3, 0.0, 0.0, 0.455696105957, 15.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamcinematique(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -265.7774, -357.2067, 49.9656, -35.0, 0.0, -30.6976, 40.0, false, 0) --  -490.69, -667.96, 47.43, Personnage marche
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', -265.7774, -357.2067, 49.9656, -35.0, 0.0, -30.6976, 40.0, false, 0) --  -490.69, -667.96, 47.43, Fin de Marche
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end


function createcamyeux(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.3, 0.0, 0.0, 0.455696105957, 10.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.3, 0.0, 0.0, 0.455696105957, 10.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamtorse(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.3, 0.0, 0.0, 0.455696105957, 10.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.3, 0.0, 0.0, 0.455696105957, 10.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end


function createcam(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.60, -98.5, -18.0, 0.0, 0.60, 70.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.60, -98.5, -18.0, 0.0, 0.60, 70.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamfin(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 414.64, -998.16, -98.68, 0.0, 0.0, 0.455696105957, 60.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 414.64, -998.16, -98.68, 0.0, 0.0, 0.455696105957, 60.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamjambe(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.60, -98.9, -18.0, 0.0, 0.60, 50.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.60, -98.9, -18.0, 0.0, 0.60, 50.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamchaussure(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.60, -99.1, -21.0, 0.0, 0.60, 50.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.60, -99.1, -21.0, 0.0, 0.60, 50.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamtorse(default)
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.75, 0.0, 0.0, 0.455696105957, 27.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 402.8, -998.68, -98.75, 0.0, 0.0, 0.455696105957, 27.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function createcamnehco(default)
        DisplayRadar(false)
        TriggerEvent('esx_status:setDisplay', 0.0)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        if (not DoesCamExist(cam)) then
            if default then
                cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 98.2, -603.60, 276.5, -18.0, 0.0, 89.60, 70.0, false, 0)
            else
                cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 98.2, -603.60, 276.5, -18.0, 0.0, 89.60, 70.0, false, 0)
            end
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, false)
        end
    end

    function createcamdb(default)
        DisplayRadar(false)
        TriggerEvent('esx_status:setDisplay', 0.0)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        if (not DoesCamExist(cam)) then
            if default then
                cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 98.2, -603.60, 276.5, -18.0, 0.0, 89.60, 70.0, false, 0)
            else
                cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 98.2, -603.60, 276.5, -18.0, 0.0, 89.60, 70.0, false, 0)
            end
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, false)
        end
    end



function CreateCam()
  --  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 402.1680, -998.27, -99.00, 0.00, 300.00, 0.75, 30.00, false, 0)
  	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 403.03, -998.33, -98.20, -20.00, 0.00, 0.00, 70.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 2000, true, true) 
end
function CreateCame()
	SetCamActive(cam, false)
	RenderScriptCams(true, false, 2000, true, true) 
end

local creationPerso = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, Blocked = true , HeaderColor = {0, 255, 255}, Title = "Menu Création"},
	Data = { currentMenu = "Commencer à créer votre carte d'identité !" },
	Events = {onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
		local slide = btn.slidenum
		local btn = btn.name --bug
		local check = btn.unkCheckbox
		local myIdentity = {}
		local data = {}
		local currentMenu, ped = menuData.currentMenu, GetPlayerPed(-1)
		if btn.name == "Traits du visage" then 
			OpenMenu("Traits du visage")
		elseif btn.name == "Apparence" then
			OpenMenu("Apparence")
		elseif btn.name == "Barbe" then 
			OpenMenu("Barbe")
		elseif btn.name == "Pilosité" then 
			OpenMenu("Pilosité")
		elseif btn.name == "Maquillage" then 
			OpenMenu("Maquillage")
		elseif btn.name == "Tenues" then 
			OpenMenu("Tenues")
		elseif btn.name == "Bras" then 
            OpenMenu("Bras")
        elseif btn.name == "Peau" then 
            OpenMenu("Peau")
        elseif btn.name == "Type de bras" then 
            OpenMenu("Type de bras")
        elseif btn.name == "Couleur des bras" then 
            OpenMenu("Couleur des bras")
        elseif btn.name == "Couleur des yeux" then 
            OpenMenu("Couleur des yeux")
        elseif btn.name == "Imperfections du corp" then 
            OpenMenu("Imperfections du corp")
        elseif btn.name == "Opacité imperfections du corp" then 
            OpenMenu("Opacité imperfections du corp")
        elseif btn == "Chaussures" then
            OpenMenu('Chaussures')
        elseif btn == "Couleur des chaussures" then
            OpenMenu('Couleur des chaussures')
        elseif btn == "Bas" then
            OpenMenu('Bas')
        elseif btn == "Couleur du bas" then
            OpenMenu('Couleur du bas')
        elseif btn == "Veste" then
            OpenMenu('Veste')
        elseif btn == "Couleur veste" then
            OpenMenu('Couleur veste')
        elseif btn == "Couleur t-shirt" then
            OpenMenu('Couleur t-shirt')
        elseif btn == "T-shirt" then
            OpenMenu('T-shirt')
        elseif btn == "Type de maquillage" then
            OpenMenu('Type de maquillage')
        elseif btn == "Opacité du maquillage" then
            OpenMenu('Opacité du maquillage')
        elseif btn == "Couleur du maquillage" then
            OpenMenu('Couleur du maquillage')
        elseif btn == "Type de rouge à lèvres" then
            OpenMenu('Type de rouge à lèvres')
        elseif btn == "Opacité du rouge à lèvres" then
            OpenMenu('Opacité du rouge à lèvres')
        elseif btn == "Couleur du rouge à lèvres" then
            OpenMenu('Couleur du rouge à lèvres')
        elseif btn == "Acné" then
            OpenMenu('Acné')
        elseif btn == "Taille de la barbe" then
            OpenMenu('Taille de la barbe')
        elseif btn == "Type de la barbe" then
            OpenMenu('Type de la barbe')
        elseif btn == "Couleur de la barbe" then
            OpenMenu('Couleur de la barbe')
        elseif btn == "Dommages UV" then
            OpenMenu('Dommages UV')
        elseif btn == "Opacité du teint" then
            OpenMenu('Opacité du teint')
        elseif btn == "Teint" then
            OpenMenu('Teint')
        elseif btn == "Couleur des poils du torse" then
            OpenMenu('Couleur des poils du torse')
        elseif btn == "Taille des poils du torse" then
            OpenMenu('Taille des poils du torse')
        elseif btn == "Poils du torse" then
            OpenMenu('Poils du torse')
        elseif btn == "Opacité des dommages UV" then
            OpenMenu('Opacité des dommages UV')
        elseif btn == "Couleur des rougeurs" then
            OpenMenu('Couleur des rougeurs')
        elseif btn == "Opacité des rougeurs" then
            OpenMenu('Opacité des rougeurs')
        elseif btn == "Rougeurs" then
            OpenMenu('Rougeurs')
        elseif btn == "Type des sourcils" then
            OpenMenu('Type des sourcils')
        elseif btn == "Couleur des cheveux" then
            OpenMenu('Couleur des cheveux') 
        elseif btn == "Taille des sourcils" then
            OpenMenu('Taille des sourcils') 
        elseif btn == "Type de cheveux" then
            OpenMenu('Type de cheveux') 
        elseif btn == "Taches de rousseur" then
            OpenMenu('Taches de rousseur') 
        elseif btn == "Opacité des rides" then
            OpenMenu('Opacité des rides') 
        elseif btn == "Rides" then
            OpenMenu('Opacité des taches de rousseurs')
        elseif btn == "Rides" then
            OpenMenu('Opacité des taches de rousseurs')
        elseif btn == "Boutons" then
            OpenMenu('Boutons')
        elseif btn == "Opacité des boutons" then
            OpenMenu('Opacité des boutons')
		elseif btn == "Sexe" then
				local result = KeyboardInput("Sexe", "M ou F", 25)
                if result ~= nil then
                    ResultSexe = result
				end
				print("Sexe " ..result)
			elseif btn == "Prénom" then
				local result = KeyboardInput("Prénom", "Prénom", 25)
                if result ~= nil then
                    ResultPrenom = result
				end
				print("Prénom " ..result)
			elseif btn == "Nom" then	
				local result = KeyboardInput("Nom", "Nom", 25)
                if result ~= nil then
                    ResultNom = result
				end
				print("Nom " ..result)
			elseif btn == "Date de naissance" then
				local result = KeyboardInput("Date de naissance", "12/09/2000", 25)
                if result ~= nil then
                    ResultDateDeNaissance = result
				end
				print("Date de naissance" ..result)
			elseif btn == "Taille" then
				local result = KeyboardInput("Taille (cm)", "180", 25)
                if result ~= nil then
                	ResultTaille = result
				end
                print("Taille " ..result)
            elseif btn == "~g~Commencer à créer votre carte d'identité" then
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 800.0, "drake-toosie-slide-lyrics-bass-boost", 0.6)
                LoadingPrompt("Sauvegarde de votre identité en cours", 3)
				DisplayRadar(false)
				SetEntityHeading(GetPlayerPed(-1), 2.9283561706543)
				SetEntityCoords(GetPlayerPed(-1), 409.4, -1001.64, -99.0-0.98, 0.0, 0.0, 0.0, 10)
                SetEntityHeading(GetPlayerPed(-1), 268.72219848633)
                createcamnehco()
				RemoveLoadingPrompt()
				OpenMenu('Voulez-vous continuez ?')
				TriggerEvent('instance:create')
				DrawSub("~g~Invincible", 12000)
                Wait(250)
            elseif btn == "~g~Oui" then
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 800.0, "drake-toosie-slide-lyrics-bass-boost", 0.6)
                LoadingPrompt("Sauvegarde de votre identité en cours", 3)
				DisplayRadar(false)
				SetEntityHeading(GetPlayerPed(-1), 2.9283561706543)
				SetEntityCoords(GetPlayerPed(-1), 409.4, -1001.64, -99.0-0.98, 0.0, 0.0, 0.0, 10)
                SetEntityHeading(GetPlayerPed(-1), 268.72219848633)
                createcamnehco()
				RemoveLoadingPrompt()
				OpenMenu('Création de personnage')
				TriggerEvent('instance:create')
				DrawSub("~g~Invincible", 12000)
                Wait(1500)
            elseif btn == "~g~Continuer" then
				TriggerServerEvent('Nehco:saveOof', ResultSexe, ResultPrenom, ResultNom, ResultDateDeNaissance, ResultTaille)
                LoadingPrompt("Sauvegarde de votre identité en cours", 3)
				DisplayRadar(false)
				CreateCam()
				SetEntityHeading(GetPlayerPed(-1), 2.9283561706543)
				SetEntityCoords(GetPlayerPed(-1), 402.8, -996.64, -99.0-0.98, 0.0, 0.0, 0.0, 10)
				SetEntityHeading(GetPlayerPed(-1), 183.72219848633)
				RemoveLoadingPrompt()
				OpenMenu('Choisissez le sexe de votre personnage (H ou F)')
				TriggerEvent('instance:create')
				DrawSub("~g~Invincible", 12000)
                Wait(2500)
			elseif btn == "~g~Choisissez le sexe de votre personnage (H ou F)" then
				OpenMenu('Sexe de votre personnage')
			elseif btn == "Votre sexe" and slide == 1 then
				TriggerEvent('skinchanger:change', 'sex', 0)
			elseif btn == "Votre sexe" and slide == 2 then
				TriggerEvent('skinchanger:change', 'sex', 1)
			elseif btn == "~g~Validé votre sexe." then
                OpenMenu('Apparence')
            elseif btn == "~g~Validé votre apparence." then
                OpenMenu('Maquillage')
            elseif btn == "~g~Validé votre maquillage." then
                OpenMenu('Traits du visage')
            elseif btn == "~g~Validé votre Traits du visage." then
                OpenMenu('Pilosité')
            elseif btn == "~g~Validé votre Pilosité." then
                OpenMenu('Tenues')
            elseif btn == "Bras" then
                OpenMenu('Bras')
            elseif btn == "Couleur des bras" then
                OpenMenu('Couleur des bras')
            elseif btn == "Couleur des yeux" then
                OpenMenu('Couleur des yeux')
            elseif btn == "Imperfections du corp" then
                OpenMenu('Imperfections du corp') 
            elseif btn == "Opacité imperfections du corp" then
                OpenMenu('Opacité imperfections du corp')
            elseif btn == "Type de bras" then
                OpenMenu('Type de bras')
            elseif btn == "Peau" then
                OpenMenu('Peau')
            elseif btn == "Chaussures" then
				OpenMenu('Chaussures')
            elseif btn == "Couleur des chaussures" then
                OpenMenu('Couleur des chaussures')
            elseif btn == "Bas" then
                OpenMenu('Bas')
            elseif btn == "Couleur du bas" then
                OpenMenu('Couleur du bas')
            elseif btn == "Veste" then
                OpenMenu('Veste')
            elseif btn == "Couleur veste" then
                OpenMenu('Couleur veste')
            elseif btn == "Couleur t-shirt" then
                OpenMenu('Couleur t-shirt')
            elseif btn == "T-shirt" then
                OpenMenu('T-shirt')
            elseif btn == "Type de maquillage" then
                OpenMenu('Type de maquillage')
            elseif btn == "Opacité du maquillage" then
                OpenMenu('Opacité du maquillage')
            elseif btn == "Couleur du maquillage" then
                OpenMenu('Couleur du maquillage')
            elseif btn == "Type de rouge à lèvres" then
                OpenMenu('Type de rouge à lèvres')
            elseif btn == "Opacité du rouge à lèvres" then
                OpenMenu('Opacité du rouge à lèvres')
            elseif btn == "Couleur du rouge à lèvres" then
                OpenMenu('Couleur du rouge à lèvres')
            elseif btn == "Acné" then
                OpenMenu('Acné')
            elseif btn == "Taille de la barbe" then
                OpenMenu('Taille de la barbe')
            elseif btn == "Type de la barbe" then
                OpenMenu('Type de la barbe')
            elseif btn == "Couleur de la barbe" then
                OpenMenu('Couleur de la barbe')
            elseif btn == "Dommages UV" then
                OpenMenu('Dommages UV')
            elseif btn == "Opacité du teint" then
                OpenMenu('Opacité du teint')
            elseif btn == "Teint" then
                OpenMenu('Teint')
            elseif btn == "Couleur des poils du torse" then
                OpenMenu('Couleur des poils du torse')
            elseif btn == "Taille des poils du torse" then
                OpenMenu('Taille des poils du torse')
            elseif btn == "Poils du torse" then
                OpenMenu('Poils du torse')
            elseif btn == "Couleur des rougeurs" then
                OpenMenu('Couleur des rougeurs')
            elseif btn == "Opacité des rougeurs" then
                OpenMenu('Opacité des rougeurs')
            elseif btn == "Rougeurs" then
                OpenMenu('Rougeurs')
            elseif btn == "Type des sourcils" then
                OpenMenu('Type des sourcils')
            elseif btn == "Couleur des cheveux" then
                OpenMenu('Couleur des cheveux') 
            elseif btn == "Taille des sourcils" then
                OpenMenu('Taille des sourcils') 
            elseif btn == "Type de cheveux" then
				OpenMenu('Type de cheveux') 
            elseif btn == "Taches de rousseur" then
                OpenMenu('Taches de rousseur') 
            elseif btn == "Opacité des rides" then
				OpenMenu('Opacité des rides') 
            elseif btn == "Rides" then
                OpenMenu('Rides')
            elseif btn == "Opacité des taches de rousseurs" then
                OpenMenu('Opacité des taches de rousseurs') 
            elseif btn == "Boutons" then
                OpenMenu('Boutons')
            elseif btn == "Opacité des boutons" then
                OpenMenu('Opacité des boutons')  
            elseif btn == "Opacité des dommages UV" then
				OpenMenu('Opacité des dommages UV') 
			elseif btn == "~g~Validé votre personnalisation." then
                OpenMenu('Valider votre personnage')
            elseif btn == "~g~Commencer à créer votre carte d'identité" then
                OpenMenu('Voulez-vous continuez ?')
            elseif btn == "~r~Non" then
                OpenMenu('Commencer à créer votre carte d\'identité') 
            elseif btn == "~g~Oui" then
				OpenMenu('Création de personnage') 
			elseif btn == "~g~Valider votre personnage" then
				print("^1NCore enregistré")
				TriggerEvent('skinchanger:getSkin', function(skin)
                    LastSkin = skin
                end)
                TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
                end)
				print("Script créé par Nehco ! Save Personnage Ok !") 
				TriggerEvent('Nehco:SpawnCharacter')
				RemoveLoadingPrompt()
		end
	end,
        onSlide = function(menuData, currentButton, currentSlt, PMenu)
            local currentMenu, ped = menuData.currentMenu, GetPlayerPed(-1)
            if currentMenu == "Nouveau personnage" then
                createcam(true)
                if currentSlt ~= 1 then return end
                currentButton = currentButton.slidenum - 1
                sex = currentButton
                TriggerEvent('skinchanger:change', 'sex', sex)
            end
            if currentMenu == "Apparence" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                currentButton = currentButton.slidenum - 1
                face = currentButton
                TriggerEvent('skinchanger:change', 'face', face)
            end
            if currentMenu == "Peau" then
                createcam(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
                skin = currentButton
                TriggerEvent('skinchanger:change', 'skin', skin)
            end
            if currentMenu == "Type de la barbe" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
                beard = currentButton
                TriggerEvent('skinchanger:change', 'beard_1', beard)
            end
            if currentMenu == "Couleur de la barbe" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
                beard3 = currentButton
                TriggerEvent('skinchanger:change', 'beard_3', beard3)
            end
            if currentMenu == "Taille de la barbe" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
                beard2 = currentButton
                TriggerEvent('skinchanger:change', 'beard_2', beard2)
            end
            if currentMenu == "Couleur des yeux" then
                createcamyeux(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
                eyecolor = currentButton
                TriggerEvent('skinchanger:change', 'eye_color', eyecolor)
            end
            if currentMenu == "Type de cheveux" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
                hair = currentButton
                TriggerEvent('skinchanger:change', 'hair_1', hair)
            end
            if currentMenu == "Couleur des cheveux" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
                hair2 = currentButton
                TriggerEvent('skinchanger:change', 'hair_color_1', hair2)
            end
            if currentMenu == "Type des sourcils" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
        
                eyebrow = currentButton
                TriggerEvent('skinchanger:change', 'eyebrows_1', eyebrow)
            end
            if currentMenu == "Taille des sourcils" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local currentButton = currentButton.slidenum - 1
        
                eyebrow = currentButton
                TriggerEvent('skinchanger:change', 'eyebrows_2', eyebrow)
            end
            if currentMenu == "Vos imperfections" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local skinproblem = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'complexion_1', skinproblem)
            end
            if currentMenu == "Opacité des imperfections" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local skinproblem2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'complexion_2', skinproblem2)
            end
            if currentMenu == "Taches de rousseur" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local freckle = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'moles_1', freckle)
            end
            if currentMenu == "Opacité des taches de rousseurs" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local freckle2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'moles_2', freckle2)
            end
            if currentMenu == "Rides" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local wrinkle = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'age_1', wrinkle)
            end
            if currentMenu == "Opacité des rides" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local wrinkle2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'age_2', wrinkle2)
            end
            if currentMenu == "Votre acné" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local acne = currentButton.slidenum - 1
        
                SetPedHeadOverlay(GetPlayerPed(-1), 0, acne, 1.0)
            end
            if currentMenu == "Dommages UV" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local sun1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'sun_1', sun1)
            end
            if currentMenu == "Opacité des dommages UV" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local sun2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'sun_2', sun2)
            end
            if currentMenu == "Teint" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local complexion1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'complexion_1', complexion1)
            end
            if currentMenu == "Opacité du teint" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local complexion2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'complexion_2', complexion2)
            end
            if currentMenu == "Rougeurs" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local blush1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'blush_1', blush1)
            end
            if currentMenu == "Opacité des rougeurs" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local blush2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'blush_2', blush2)
            end
            if currentMenu == "Couleur des rougeurs" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local blush3 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'blush_3', blush3)
            end
            if currentMenu == "Boutons" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local blemishes1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'blemishes_1', blemishes1)
            end
            if currentMenu == "Opacité des boutons" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local blemishes2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'blemishes_2', blemishes2)
            end
            if currentMenu == "Imperfections du corp" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local bodyb1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'bodyb_1', bodyb1)
            end
            if currentMenu == "Opacité imperfections du corp" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local bodyb2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'bodyb_2', bodyb2)
            end
            if currentMenu == "Poils du torse" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local chest1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'chest_1', chest1)
            end
            if currentMenu == "Taille des poils du torse" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local chest2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'chest_2', chest2)
            end
            if currentMenu == "Couleur des poils du torse" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local chest3 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'chest_3', chest3)
            end
            if currentMenu == "Type de maquillage" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local makeup1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'makeup_1', makeup1)
            end
            if currentMenu == "Opacité du maquillage" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local makeup2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'makeup_2', makeup2)
            end
            if currentMenu == "Couleur du maquillage" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local makeup3 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'makeup_3', makeup3)
            end
            if currentMenu == "Type de rouge à lèvres" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local lipstick1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'lipstick_1', lipstick1)
            end
            if currentMenu == "Opacité du rouge à lèvres" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local lipstick2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'lipstick_2', lipstick2)
            end
            if currentMenu == "Couleur du rouge à lèvres" then
                createcamvisage(true)
                if currentSlt ~= 1 then return end
                local lipstick3 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'lipstick_3', lipstick3)
            end
            if currentMenu == "Type de bras" then
                createcam(true)
                if currentSlt ~= 1 then return end
                local arms = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'arms', arms)
            end
            if currentMenu == "Couleur des bras" then
                createcam(true)
                if currentSlt ~= 1 then return end
                local arms2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'arms_2', arms2)
            end
            if currentMenu == "T-shirt" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local tshirt1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'tshirt_1', tshirt1)
            end
            if currentMenu == "Couleur t-shirt" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local tshirt2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'tshirt_2', tshirt2)
            end
            if currentMenu == "Veste" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local torso1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'torso_1', torso1)
            end
            if currentMenu == "Couleur veste" then
                createcamtorse(true)
                if currentSlt ~= 1 then return end
                local torso2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'torso_2', torso2)
            end
            if currentMenu == "Bas" then
                createcamjambe(true)
                if currentSlt ~= 1 then return end
                local pants1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'pants_1', pants1)
            end
            if currentMenu == "Couleur du bas" then
                createcamjambe(true)
                if currentSlt ~= 1 then return end
                local pants2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'pants_2', pants2)
            end
            if currentMenu == "Chaussures" then
                createcamchaussure(true)
                if currentSlt ~= 1 then return end
                local shoes1 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'shoes_1', shoes1)
            end
            if currentMenu == "Couleur des chaussures" then
                createcamchaussure(true)
                if currentSlt ~= 1 then return end
                local shoes2 = currentButton.slidenum - 1
                TriggerEvent('skinchanger:change', 'shoes_2', shoes2)
            end
        end,
    },
	Menu = {
        ["Nouveau personnage"] = {
            useFilter = true,
			b = {
               -- {name = "Skin", slidemax = 1, Description = "~r~Attention ! ~s~Si vous avez un problème merci de faire un Ticket sur le Discord."},
                {name = "Apparence", ask = "→", askX = true, Description = "Choisissez votre apparence."},
                {name = "Maquillage", ask = "→", askX = true, Description = "Choisissez votre maquillage."},
                {name = "Traits du visage", ask = "→", askX = true, Description = "Choisissez vos traits du visage."},
                {name = "Tenues", ask = "→", askX = true, Description = "Choisissez votre tenue."},
               -- {name = "Identité", ask = "→", askX = true, Description = "Choisissez votre identité."},
			   {name = "~g~Validé votre personnalisation.", Description = "~r~Attention.~w~Cette action est irréversible.", ask = ">", askX = true}
			}
        },

		["Commencer à créer votre carte d'identité !"] = {
			b = {
                {name = "~g~Commencer à créer votre carte d'identité", Description = "Êtes-vous sûr de vos informations si-dessus ? Si oui, continuez la création de votre personnage", ask = ">", askX = true}
			}
        },
        
		["Voulez-vous continuez ?"] = {
			b = {
                {name = "~g~Oui", Description = "Êtes-vous sûr de vos informations si-dessus ? Si oui, continuez la création de votre personnage", ask = ">", askX = true},
                {name = "~r~Non", Description = "Êtes-vous sûr de vos informations si-dessus ? Si oui, continuez la création de votre personnage", ask = ">", askX = true}
			}
        },
           
           
		["Création de personnage"] = {
			b = {
				{name = "Prénom"},
				{name = "Nom"},
				{name = "Date de naissance"},
				--{name = "Lieu de naissance"},
				{name = "Taille"},
				{name = "Sexe", Description = "Homme = M / Femme = F"},
                {name = "~g~Continuer", Description = "Êtes-vous sûr de vos informations si-dessus ? Si oui, continuez la création de votre personnage", ask = ">", askX = true}
			}
		},
		
		["Choisissez le sexe de votre personnage (H ou F)"] = {
			b = {
				--{name = "~g~Choisir un ped", Description = "Personnage PNJ, customisation restreinte (Only)"}, -- En Dev
				{name = "~g~Choisissez le sexe de votre personnage (H ou F)", Description = "Customisation complète de A à Z (Tête, bouche, héritage...)"}
			}
		},

		["Choisi ton ped:"] = {
			b = {
				{name = "~g~Ped:", Description = "Listes des peds disponibles sur FiveM/GTA V", slidemax = pedlist},
				{name = "~g~Valider votre ped:", Description = "~r~Attention.~w~Action irréversible. Choissiez bien votre personnage"}
			}
		},
		
		["Sexe de votre personnage"] = {
			b = {
				{name = "Votre sexe", Description = "Sexe du personnage.", slidemax = sexe},
				{name = "~g~Validé votre sexe.", Description = "~r~Attention.~w~Êtes-vous sûre de valider votre sexe, si oui appuyez sur ENTRER", ask = ">", askX = true}

			}
		},
        ["Tenues"] = {   
            useFilter = true,        
			b = {
                {name = "T-shirt", ask = "→", askX = true, Description = "Choisissez votre t-shirt."},
                {name = "Couleur t-shirt", ask = "→", askX = true, Description = "Choisissez votre couleur de t-shirt."},
                {name = "Veste", ask = "→", askX = true, Description = "Choisissez votre veste."},
                {name = "Couleur veste", ask = "→", askX = true, Description = "Choisissez votre couleur de veste."},
                {name = "Bas", ask = "→", askX = true, Description = "Choisissez votre bas."},
                {name = "Couleur du bas", ask = "→", askX = true, Description = "Choisissez votre couleur de bas."},
                {name = "Chaussures", ask = "→", askX = true, Description = "Choisissez vos chaussures."},
                {name = "Couleur des chaussures", ask = "→", askX = true, Description = "Choisissez votre couleur de chaussure."},
                {name = "~g~Validé votre personnalisation.", Description = "~r~Attention.~w~Cette action est irréversible.", ask = ">", askX = true},
            }
        },
        ["Identité"] = { 
			b = {
                {name = "Prénom", ask = "Prénom" },    
                {name = "Nom", ask = "Nom" },
                {name = "Date de naissance", ask = "Jour/Mois/Année" }, 
                {name = "Lieu de naissance", ask = "Lieu de naissance" },
                {name = "Taille", ask = "Taille" },
                {name = "Sexe", ask = "m/f" }, 
                {name = "~g~Continuer & Sauvegarder"}, 
			}
        },
        ["Apparence"] = {   
            useFilter = true,        
			b = {
                {name = "Visage", slidemax = 45, Description = "Choisissez votre visage."},
                {name = "Peau", ask = "→", askX = true, Description = "Choisissez votre couleur de peau."},
                {name = "Bras", ask = "→", askX = true, Description = "Choisissez vos bras."},
               -- {name = "Pilosité", ask = "→", askX = true, Description = "Choisissez votre pilosité."},
                {name = "Couleur des yeux", ask = "→", askX = true, Description = "Choisissez votre couleur des yeux."},
                {name = "Imperfections du corp", ask = "→", askX = true, Description = "Choisissez vos imperfections du corp."},
                {name = "Opacité imperfections du corp", ask = "→", askX = true, Description = "Choisissez l'opacité de vos imperfections."},
                {name = "~g~Validé votre apparence.", Description = "~r~Attention.~w~Cette action est irréversible.", ask = ">", askX = true},
            }
        },
        ["Maquillage"] = { 
            useFilter = true,          
			b = {
                {name = "Type de maquillage", ask = "→", askX = true, Description = "Choisissez votre type de maquillage."},
                {name = "Opacité du maquillage", ask = "→", askX = true, Description = "Choisissez la taille de votre maquillage."},
                {name = "Couleur du maquillage", ask = "→", askX = true, Description = "Choisissez la couleur de votre maquillage."},
                {name = "Type de rouge à lèvres", ask = "→", askX = true, Description = "Choisissez votre type de rouge à lèvres."},
                {name = "Opacité du rouge à lèvres", ask = "→", askX = true, Description = "Choisissez la taille de votre rouge à lèvres."},
                {name = "Couleur du rouge à lèvres", ask = "→", askX = true, Description = "Choisissez la couleur de votre rouge à lèvres."},
                {name = "~g~Validé votre maquillage.", Description = "~r~Attention.~w~Cette action est irréversible.", ask = ">", askX = true},
            }
        },
        ["Traits du visage"] = {     
            useFilter = true,      
			b = {
                {name = "Rides", ask = "→", askX = true, Description = "Choisissez vos rides."},
                {name = "Opacité des rides", ask = "→", askX = true, Description = "Choisissez la taille de vos rides."},
                {name = "Dommages UV", ask = "→", askX = true, Description = "Choisissez vos dommages UV."},
                {name = "Opacité des dommages UV", ask = "→", askX = true, Description = "Choisissez l'opacité de vos dommages UV."},
                {name = "Boutons", ask = "→", askX = true, Description = "Choisissez vos boutons."},
                {name = "Opacité des boutons", ask = "→", askX = true, Description = "Choisissez l'opacité de vos boutons."},
                {name = "Teint", ask = "→", askX = true, Description = "Choisissez votre teint."},
                {name = "Opacité du teint", ask = "→", askX = true, Description = "Choisissez l'opacité de votre teint."},
                {name = "Taches de rousseur", ask = "→", askX = true, Description = "Choisissez vos taches de rousseur."},
                {name = "Opacité des taches de rousseurs", ask = "→", askX = true, Description = "Choisissez l'opacité de vos tahes de rousseur."},
                {name = "Rougeurs", ask = "→", askX = true, Description = "Choisissez vos rougeurs."},
                {name = "Opacité des rougeurs", ask = "→", askX = true, Description = "Choisissez l'opacité des rougeurs."},
                {name = "Couleur des rougeurs", ask = "→", askX = true, Description = "Choisissez la couleur de vos rougeurs."},
                {name = "~g~Validé votre Traits du visage.", Description = "~r~Attention.~w~Cette action est irréversible.", ask = ">", askX = true},
            }
        },
        ["Pilosité"] = {     
            useFilter = true,      
			b = {
                {name = "Type de cheveux", ask = "→", askX = true, Description = "Choisissez votre type de coiffure."},
                {name = "Couleur des cheveux", ask = "→", askX = true, Description = "Choisissez la couleur de votre coiffure."},
                {name = "Taille de la barbe", ask = "→", askX = true, Description = "Choisissez la taille de votre barbe."},
                {name = "Type de la barbe", ask = "→", askX = true, Description = "Choisissez votre type de barbe."},
                {name = "Couleur de la barbe", ask = "→", askX = true, Description = "Choisissez la couleur de votre barbe."},
                {name = "Type des sourcils", ask = "→", askX = true, Description = "Choisissez le type de sourcils."},
                {name = "Taille des sourcils", ask = "→", askX = true, Description = "Choisissez la taille de vos sourcils."},
                {name = "Poils du torse", ask = "→", askX = true, Description = "Choisissez le type de poils de torse."},
                {name = "Taille des poils du torse", ask = "→", askX = true, Description = "Choisissez la taille de vos poils de torse."},
                {name = "Couleur des poils du torse", ask = "→", askX = true, Description = "Choisissez la couleur de vos poils de torse."},
                {name = "~g~Validé votre Pilosité.", Description = "~r~Attention.~w~Cette action est irréversible.", ask = ">", askX = true},
			}
		},	
        ["Chaussures"] = {            
            b = {
                { name = "Chaussures", slidemax = 114, Description = "Choisissez vos chaussures."},
            }
        },
        ["Couleur des chaussures"] = {            
            b = {
                { name = "Couleur des chaussures", slidemax = 20, Description = "Choisissez votre couleur de chaussure."},
            }
        },
        ["Bas"] = {            
            b = {
                { name = "Bas", slidemax = 114, Description = "Choisissez votre bas."},
            }
        },
        ["Couleur du bas"] = {            
            b = {
                { name = "Couleur du bas", slidemax = 20, Description = "Choisissez votre couleur de bas."},
            }
        },
        ["Veste"] = {            
            b = {
                { name = "Veste", slidemax = 289, Description = "Choisissez votre veste."},
            }
        },
        ["Couleur veste"] = {            
            b = {
                { name = "Couleur Veste", slidemax = 20, Description = "Choisissez votre couleur de veste."},
            }
        },
        ["Couleur t-shirt"] = {            
            b = {
                { name = "Couleur t-shirt", slidemax = 20, Description = "Choisissez votre couleur de t-shirt."},
            }
        },
        ["T-shirt"] = {            
            b = {
                { name = "T-Shirt", slidemax = 143, Description = "Choisissez votre t-shirt."},
            }
        },
        ["Bras"] = {            
            b = {
                { name = "Type de bras", ask = "→", askX = true, Description = "Choisissez votre type de bras."},
                { name = "Couleur des bras", ask = "→", askX = true, Description = "Choisissez votre couleur de bras."},
            }
        },
        ["Type de bras"] = {            
            b = {
                { name = "Type de bras", slidemax = 163, Description = "Choisissez votre type de bras."},
            }
        },
        ["Couleur des bras"] = {            
            b = {
                { name = "Couleur des bras", slidemax = 10, Description = "Choisissez votre couleur de bras."},
            }
        },
        ["Type de maquillage"] = {            
            b = {
                { name = "Type de maquillage", slidemax = 71, Description = "Choisissez votre type de maquillage."},
            }
        },
        ["Opacité du maquillage"] = {
            b = {
                { name = "Opacité du maquillage", slidemax = 10, Description = "Choisissez la taille de votre maquillage."},
            }
        },
        ["Couleur du maquillage"] = {            
            b = {
                { name = "Couleur du maquillage", slidemax = 63, Description = "Choisissez la couleur de votre maquillage."},
            }
        },
        ["Type de rouge à lèvres"] = {
            b = {
                { name = "Type de rouge à lèvres", slidemax = 9, Description = "Choisissez votre type de rouge à lèvres."},
            }
        },
        ["Opacité du rouge à lèvres"] = {            
            b = {
                { name = "Opacité du rouge à lèvres", slidemax = 10, Description = "Choisissez la taille de votre rouge à lèvres."},
            }
        },
        ["Couleur du rouge à lèvres"] = {            
            b = {
                { name = "Couleur du rouge à lèvres", slidemax = 63, Description = "Choisissez la couleur de votre rouge à lèvres."},
            }
        },
        ["Imperfections du corp"] = {            
			b = {
                { name = "Imperfections du corp", slidemax = 11, Description = "Choisissez vos imperfections du corp."},
            }
        },
        ["Opacité imperfections du corp"] = {
            b = {
                { name = "Opacité imperfections du corp", slidemax = 10, Description = "Choisissez l'opacité de vos imperfections."},
            }
        },
        ["Boutons"] = {            
			b = {
                { name = "Boutons", slidemax = 23, Description = "Choisissez vos boutons."},
            }
        },
        ["Opacité des boutons"] = {
            b = {
                { name = "Opacité des boutons", slidemax = 10, Description = "Choisissez l'opacité de vos boutons."},
            }
        },
        ["Rougeurs"] = {            
			b = {
                { name = "Rougeurs", slidemax = 32, Description = "Choisissez vos rougeurs."},
            }
        },
        ["Opacité des rougeurs"] = {
            b = {
                { name = "Opacité des rougeurs", slidemax = 10, Description = "Choisissez l'opacité des rougeurs."},
            }
        },
        ["Couleur des rougeurs"] = {            
			b = {
                { name = "Couleur des rougeurs", slidemax = 63, Description = "Choisissez la couleur de vos rougeurs."},
            }
        },
        ["Poils du torse"] = {            
			b = {
                { name = "Poils du torse", slidemax = 16, Description = "Choisissez le type de poils de torse."},
            }
        },
        ["Taille des poils du torse"] = {
            b = {
                { name = "Taille des poils du torse", slidemax = 10, Description = "Choisissez la taille de vos poils de torse."},
            }
        },
        ["Couleur des poils du torse"] = {            
			b = {
                { name = "Couleur des poils du torse", slidemax = 63, Description = "Choisissez la couleur de vos poils de torse."},
            }
        },
        ["Teint"] = {            
			b = {
                { name = "Teint", slidemax = 11, Description = "Choisissez votre teint."},
            }
        },
        ["Opacité du teint"] = {
            b = {
                { name = "Opacité du teint", slidemax = 10, Description = "Choisissez l'opacité de votre teint."},
            }
        },
        ["Dommages UV"] = {            
			b = {
                { name = "Dommages UV", slidemax = 10, Description = "Choisissez vos dommages UV."},
            }
        },
        ["Opacité des dommages UV"] = {
            b = {
                { name = "Opacité des dommages UV", slidemax = 10, Description = "Choisissez l'opacité de vos dommages UV."},
            }
        },
        ["Couleur de la barbe"] = {            
			b = {
                { name = "Couleur de la barbe", slidemax = 63, Description = "Choisissez la couleur de votre barbe."},
            }
        },
        ["Type de la barbe"] = {            
			b = {
                { name = "Type de la barbe", slidemax = 28, Description = "Choisissez votre type de barbe."},
            }
        },
        ["Taille de la barbe"] = {            
			b = {
                { name = "Taille de la barbe", slidemax = 10, Description = "Choisissez la taille de votre barbe."},
            }
        },
        ["Votre acné"] = {            
			b = {
                { name = "Acné", slidemax = 15},
            }
        },
        ["Rides"] = {            
			b = {
                { name = "Rides", slidemax = 15, Description = "Choisissez vos rides."},
            }
        },
        ["Opacité des rides"] = {            
			b = {
                { name = "Opacité des rides", slidemax = 10, Description = "Choisissez la taille de vos rides."},
            }
        },
        ["Taches de rousseur"] = {            
			b = {
                { name = "Taches de rousseurs", slidemax = 17, Description = "Choisissez vos taches de rousseur."},
            }
        },
        ["Opacité des taches de rousseurs"] = {
            b = {
                { name = "Opacité des taches de rousseurs", slidemax = 10, Description = "Choisissez l'opacité de vos tahes de rousseur."},
            }
        },
        ["Votre tête"] = {
			b = {
                { name = "Visage", slidemax = 45 },
			}
        },
        ["Peau"] = {
			b = {
				{ name = "Peau", slidemax = 45, Description = "Choisissez votre couleur de peau."},
			}
        },
        ["Couleur des yeux"] = {
			b = {
				{ name = "Couleur des yeux", slidemax = 31, Description = "Choisissez votre couleur des yeux."},
			}
        },
        ["Type de cheveux"] = {
			b = {
				{ name = "Type de cheveux", slidemax = 73, Description = "Choisissez votre type de coiffure."}
			}
        },
        ["Couleur des cheveux"] = {
			b = {
				{ name = "Couleur des cheveux", slidemax = 63, Description = "Choisissez la couleur de votre coiffure."}
			}
		},
		["Valider votre personnage"] = {
			b = {
				{name = "~g~Valider votre personnage", Description = "~r~Attention.~w~Cette action est irréversible."}

			}
        },
        ["Commencer à créer votre carte d'identité !"] = {
			b = {
				{name = "~g~Commencer à créer votre carte d'identité", Description = "~r~Attention.~w~Cette action est irréversible."}

			}
        },
        ["Voulez-vous continuez ?"] = {
			b = {
                {name = "~g~Oui", Description = "~r~Attention.~w~Cette action est irréversible."},
                {name = "~r~Non", Description = "~r~Attention.~w~Cette action est irréversible."}

			}
		},
        ["Type des sourcils"] = {
			b = {
				{ name = "Type des sourcils", slidemax = 33, Description = "Choisissez le type de sourcils."},
			}
        },
        ["Taille des sourcils"] = {
			b = {
				{ name = "Taille des sourcils", slidemax = 10, Description = "Choisissez la taille de vos sourcils."},
			}
        },
	}
}


local FirstSpawn     = true
local LastSkin       = nil
local PlayerLoaded   = false


TriggerEvent('instance:registerType', 'skin')
TriggerEvent('instance:registerType', 'property')

RegisterNetEvent('Nehco:create')
AddEventHandler('Nehco:create', function()
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    TriggerEvent('instance:create', 'skin')
    --TriggerEvent('skinchanger:change', 'sex', 0)
    TriggerEvent('skinchanger:change', 'tshirt_1', 15)
    TriggerEvent('skinchanger:change', 'torso_1', 15)
    TriggerEvent('skinchanger:change', 'arms', 15)
    TriggerEvent('skinchanger:change', 'pants_1', 14)
    TriggerEvent('skinchanger:change', 'shoes_1', 34)
    isCameraActive = true
    for i = 0, 357 do
        DisableAllControlActions(i)
    end
    CreateCamEnter()
    SpawnCharacter()
    SetEntityHeading(GetPlayerPed(-1), 2.9283561706543)
    SetEntityCoords(GetPlayerPed(-1), 408.8, -998.64, -99.0-0.98, 0.0, 0.0, 0.0, 10)
    SetEntityHeading(GetPlayerPed(-1), 268.72219848633)
    PrepareMusicEvent("FM_INTRO_DRIVE_START")
    TriggerMusicEvent("FM_INTRO_DRIVE_START")
    CreateMenu(creationPerso)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    incamera = true
    ClearPedTasks(GetPlayerPed(-1))
    DeleteObject(board)
    DeleteObject(overlay)
end)


RegisterCommand('ncore', function()    
    TriggerEvent('instance:create', 'skin')
    TriggerEvent('skinchanger:change', 'tshirt_1', 15)
    TriggerEvent('skinchanger:change', 'torso_1', 15)
    TriggerEvent('skinchanger:change', 'arms', 15)
    TriggerEvent('skinchanger:change', 'pants_1', 14)
    TriggerEvent('skinchanger:change', 'shoes_1', 34)
    isCameraActive = true
    for i = 0, 357 do
        DisableAllControlActions(i)
    end
    CreateCamEnter()
    SpawnCharacter()
    SetEntityHeading(GetPlayerPed(-1), 2.9283561706543)
    SetEntityCoords(GetPlayerPed(-1), 408.8, -998.64, -99.0-0.98, 0.0, 0.0, 0.0, 10)
    SetEntityHeading(GetPlayerPed(-1), 268.72219848633)
    PrepareMusicEvent("FM_INTRO_DRIVE_START")
    TriggerMusicEvent("FM_INTRO_DRIVE_START")
    CreateMenu(creationPerso)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    incamera = true
    ClearPedTasks(GetPlayerPed(-1))
    DeleteObject(board)
    DeleteObject(overlay)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'skin' then
		TriggerEvent('instance:enter', instance)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isCameraActive then
            if IsControlJustPressed(1, 107) then 
                SetEntityHeading(PlayerPedId(), 0.50)
            elseif IsControlJustPressed(1, 108) then 
                SetEntityHeading(PlayerPedId(), 193.26)
            elseif IsControlJustPressed(1, 112) then 
                SetEntityHeading(PlayerPedId(), 268.72219848633)
            elseif IsControlJustPressed(1, 111) then 
                SetEntityHeading(PlayerPedId(), 91.04)
            end
        end
    end
end)

-- Pour les bugs de collions

function Collision()
    for i=1,256 do
        if NetworkIsPlayerActive(i) then
            SetEntityVisible(GetPlayerPed(i), false, false)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
        end
    end
end

function Visible()
    while enable == true do
        Citizen.Wait(0)
        DisableAllControlActions(0)
        Collision()
    end
end