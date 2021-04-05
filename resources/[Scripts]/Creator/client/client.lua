ESX = nil
Character = {}
ClotheList = {}
local enable = true

local playerPed = PlayerPedId()
local incamera = false
local handle
local isinintroduction = false
local pressedenter = false
local introstep = 0
local timer = 0
local inputgroups = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}
local enanimcinematique = false
local guiEnabled = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	GenerateClotheList()
end)

--function spawncinematiqueplayer()
--    guiEnabled = true
--    local playerPed = PlayerPedId()
--    pressedenter = true
--    local introcam
--    TriggerEvent('chat:clear')
--    TriggerEvent('chat:toggleChat')
--    SetEntityVisible(playerPed, false, false)
--    --SetEntityCoordsNoOffset(playerPed, -103.8, -921.06, 287.29, false, false, false, true)
--    FreezeEntityPosition(GetPlayerPed(-1), true)
--    SetFocusEntity(playerPed)
--    PrepareMusicEvent("FM_INTRO_START")
--    Wait(1)
--    SetOverrideWeather("EXTRASUNNY")
--    NetworkOverrideClockTime(19, 0, 0)
--    BeginSrl()
--    introstep = 1
--    isinintroduction = true
--    Wait(1)
--    DoScreenFadeIn(500)
--    if introstep == 1 then
--        TriggerMusicEvent("FM_INTRO_START")
--        introcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
--        SetCamActive(introcam, true)
--        SetFocusArea(754.2219, 1226.831, 356.5081, 0.0, 0.0, 0.0)
--        SetCamParams(introcam, 754.2219, 1226.831, 356.5081, -14.367, 0.0, 157.3524, 42.2442, 0, 1, 1, 2)
--        SetCamParams(introcam, 740.7797, 1193.923, 351.1997, -9.6114, 0.0, 157.8659, 44.8314, 7200, 0, 0, 2)
--        ShakeCam(introcam, "HAND_SHAKE", 0.15)
--        RenderScriptCams(true, false, 3000, 1, 1)
--        return
--    end
--end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

--Citizen.CreateThread(function()
--    local PlayerIdP = GetPlayerServerId(PlayerId())
--	  while true do
--        Citizen.Wait(10000)
--        players = {}
--
--        for _,player in ipairs(GetActivePlayers()) do 
--            table.insert(players, player)
--        end
--
--        Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~b~V_Core~t~| ~w~Discord : sCx9Zum~t~ | ~b~ID: ' .. PlayerIdP .. " ~t~| ~w  ~Joueurs: " .. #players .. "/32 ~t~")
--
--        SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. #players .. "/32")
--        SetDiscordAppId(621064632223924244)
--
--        -- Game > Disconnect
--        AddTextEntry('PM_PANE_LEAVE', 'Retourner sur la liste des serveurs.');
--        -- Game > Quit
--        AddTextEntry('PM_PANE_QUIT', 'Quitter FiveM');
--
--        AddTextEntry('PM_SCR_MAP', '~w~Carte de Los Santos')
--        AddTextEntry('PM_SCR_GAM', '~b~Prendre l\'avion')
--        AddTextEntry('PM_SCR_INF', '~w~Logs')
--        AddTextEntry('PM_SCR_STA', '~b~Statistiques')
--        AddTextEntry('PM_SCR_SET', '~w~Paramètres')
--        AddTextEntry('PM_SCR_GAL', '~b~Galerie')
--        AddTextEntry('PM_SCR_RPL', '~w~Éditeur ∑')
--      end
--end)
--
--Citizen.CreateThread(function()
--    while true do 
--        Wait(0)
--
--        local playerPed = PlayerPedId()
--
--        if pressedenter then 
--            drawTxt(0.80, 0.55, 1.0, 1.0, 0.6, "Appuyez sur ~g~ENTRER~w~ pour valider votre entrée", 255, 255, 255, 255, false)
--            if IsControlJustPressed(1, 191) then 
--                ESX.ShowNotification("Vous avez été replacé à votre ~o~ancienne~s~ position.")
--                ESX.ShowNotification("Connexion au vocal ~g~réussie~s~.")
--                destorycam()
--                spawncinematiqueplayer(false)
--                DoScreenFadeOut(0)
--                enanimcinematique = false
--                pressedenter = false
--                guiEnabled = false
--                isinintroduction = false
--                PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
--                TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
--                TriggerEvent("playerSpawned")
--                SetEntityVisible(playerPed, true, false)
--                FreezeEntityPosition(GetPlayerPed(-1), false)
--                DestroyCam(createdCamera, 0)
--                DestroyCam(createdCamera, 0)
--                RenderScriptCams(0, 0, 1, 1, 1)
--                createdCamera = 0
--                ClearTimecycleModifier("scanline_cam_cheap")
--                SetFocusEntity(GetPlayerPed(PlayerId()))   
--                --ExecuteCommand('lastpos')
--                DoScreenFadeIn(1500)
--                ESX.UI.HUD.SetDisplay(1.0)
--                TriggerEvent('es:setMoneyDisplay', 1.0)
--                TriggerEvent('esx_status:setDisplay', 1.0)
--                DisplayRadar(true)
--                TriggerEvent('ui:toggle', true)
--            end
--        end
--    end
--end)

local FirstSpawn     = true

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
					AnimCam()
				else
                    TriggerEvent('skinchanger:loadSkin', skin)
                    --spawncinematiqueplayer()
				end
			end)
			FirstSpawn = false
		end
	end)
end)

function destorycam()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end

-- Apparence modification
local pedModel = 'mp_m_freemode_01'
function changeGender(sex)
	if sex == 1 then
		Character['sex'] = 0
		pedModel = 'mp_m_freemode_01'
		changeModel(pedModel)
	else
		Character['sex'] = 1
		pedModel = 'mp_f_freemode_01'
		changeModel(pedModel)
	end
end

function changeModel(skin)
	local model = GetHashKey(skin)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedDefaultComponentVariation(PlayerPedId())

        if skin == 'mp_m_freemode_01' then
            SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2) -- arms
            SetPedComponentVariation(GetPlayerPed(-1), 11, 15, 0, 2) -- torso
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) -- tshirt
            SetPedComponentVariation(GetPlayerPed(-1), 4, 61, 4, 2) -- pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 34, 0, 2) -- shoes

            Character['arms'] = 15
            Character['torso_1'] = 15
            Character['tshirt_1'] = 15
            Character['pants_1'] = 61
            Character['pants_2'] = 4
            Character['shoes_1'] = 34
            Character['glasses_1'] = 0


        elseif skin == 'mp_f_freemode_01' then
            SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2) -- arms
            SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 0, 2) -- torso
            SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2) -- tshirt
            SetPedComponentVariation(GetPlayerPed(-1), 4, 57, 0, 2) -- pants
            SetPedComponentVariation(GetPlayerPed(-1), 6, 35, 0, 2) -- shoes

            Character['arms'] = 15
            Character['torso_1'] = 5
            Character['tshirt_1'] = 15
            Character['pants_1'] = 57
            Character['pants_2'] = 0
            Character['shoes_1'] = 35
            Character['glasses_1'] = -1
        end


        SetModelAsNoLongerNeeded(model)
    end
end

Apperance = {
	{
		item = 'eyebrows',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 2,
		PercentagePanel = true,
		ColourPanel = true,
	},
	{
		item = 'beard',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 1,
		PercentagePanel = true,
		ColourPanel = true,
	},
	{
		item = 'bodyb',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
		index = 1,
		indextwo = 1,
		cam = 'body',
		itemType = 'headoverlay',
		itemID = 11,
		PercentagePanel = true,
	},
	{
		item = 'age',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 3,
		PercentagePanel = true,
	},
	{
		item = 'blemishes',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16, 17, 18, 19, 20, 21, 22, 23},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 0,
		PercentagePanel = true,
	},
	{
		item = 'moles',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16, 17},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 9,
		PercentagePanel = true,
	},
	{
		item = 'sun',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 7,
		PercentagePanel = true,
	},
	{
		item = 'eyes_color',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'eye'
	},
	{
		item = 'makeup',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 4,
		PercentagePanel = true,
		ColourPanel = true,
	},
	{
		item = 'lipstick',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 8,
		PercentagePanel = true,
		ColourPanel = true,
	},
	{
		item = 'chest',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16},
		index = 1,
		indextwo = 1,
		cam = 'body',
		itemType = 'headoverlay',
		itemID = 10,
		PercentagePanel = true,
		ColourPanel = true,
	},
	{
		item = 'blush',
		List = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ,16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32},
		index = 1,
		indextwo = 1,
		cam = 'face',
		itemType = 'headoverlay',
		itemID = 5,
		PercentagePanel = true,
		ColourPanel = true,
	},
}

function updateApperance(id, color)
	local app = Apperance[id]
	local playerPed = PlayerPedId()
	if not color then
		if app.itemType == 'component' then
			SetPedComponentVariation(playerPed, app.itemID, app.index, 0, 2)
			Character[app.item..'_1'] = app.index
	    elseif app.itemType == 'headoverlay' then
			SetPedHeadOverlay(playerPed, app.itemID, app.index, math.floor(app.indextwo)/10+0.0)
			Character[app.item..'_1'] = app.index
			Character[app.item..'_2'] = math.floor(app.indextwo)
	    elseif app.itemType == 'eye' then
			SetPedEyeColor(playerPed, app.index, 0, 1)
			Character['eye_color'] = app.index
	    end
	end

    if color then
        if app.itemType == 'headoverlay' then
            SetPedHeadOverlayColor(playerPed, app.itemID, 1, app.indextwo, 0)
            Character[app.item..'_3'] = app.indextwo
        end
    end	
end

-- Clothe modification
function GenerateClotheList()
	for i=1, #Config.Outfit, 1 do
		table.insert(ClotheList, Config.Outfit[i].label)
	end
end

local ComponentClothe = {tshirt = 8, torso = 11, decals = 10, arms = 3, pants = 4, shoes = 6, chain = 7}
local PropIndexClothe = {helmet = 0, glasses = 1}

function updateClothe(index)
    local clothe = Config.Outfit[index]
    local gender
    if Character['sex'] == 0 then
        gender = 'male'
    else
        gender = 'female'
    end

    local playerPed = PlayerPedId()

    for k,v in pairs(clothe.id[gender]) do
        if k == 'helmet' or k == 'glasses' then
            SetPedPropIndex(playerPed, PropIndexClothe[k], v[1], v[2])
        else
            if k == 'arms' then
            	Character[k] = v[1]
            else
            	Character[k..'_1'] = v[1]
            end
           	Character[k..'_2'] = v[2]
            SetPedComponentVariation(playerPed, ComponentClothe[k], v[1], v[2])
        end
    end
end

-- CAM + Spawn
local Camera = {
	face = {x = 402.92, y = -1000.72, z = -98.45, fov = 10.00},
	body = {x = 402.92, y = -1000.72, z = -99.01, fov = 30.00},
}

cam, cam2, cam3, camSkin, isCameraActive = nil, nil, nil, nil, nil
lastCam = 'body'

function CharCreatorAnimation()
	enable = true
	-- Hide HUD
	ESX.UI.HUD.SetDisplay(0.0)
	DisplayRadar(false)
	AnimCam()
	Visible()
end


function CamCreatorInit()
    local _Cam = {
        f_466 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false),
        f_465 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false),
    }
    _Cam.f_466 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    _Cam.f_465 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    return _Cam
end


function CreatorZoomOut(_Cam)
    PlaySoundFrontend(-1, "Zoom_Out", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1);
    func_1678(_Cam)
    RenderScriptCams(true, false, 3000, 1, 0, 0)
end

function func_1675(uParam0, iParam1, Stats)
    local vVar0 = GetGameplayCamCoords()
    local vVar1 = GetCamRot(uParam0.f_465, 2)
    local fVar2 = Citizen.InvokeNative(0x80ec114669daeff4)
    SetCamCoord(uParam0.f_465, vVar0);
    SetCamRot(uParam0.f_465, vVar1, 2);
    SetCamFov(uParam0.f_465, fVar2);
    func_1673(uParam0.f_465, 3.0, 1.0, 1.2, 1.0);
    SetCamActive(uParam0.f_465, true);
    StopCamShaking(uParam0.f_465, 1)
    if (iParam1 == 1) then
        --- Custom
        if not (Stats) then
            SetCamCoord(uParam0.f_466, 402.7553, -1000.55, -98.48412);
            SetCamRot(uParam0.f_466, 2.254577, 0, 0.893029, 2);
            SetCamFov(uParam0.f_466, 9.999582);
            func_1673(uParam0.f_466, 3.8, 1.0, 1.2, 1.0);
        else
            SetCamCoord(uParam0.f_466, 402.7553, -1000.622, -98.48412);
            SetCamRot(uParam0.f_466, 1.260873, 0, 0.834392, 2);
            SetCamFov(uParam0.f_466, 10.01836);
            func_1673(uParam0.f_466, 3.8, 1.0, 1.2, 1.0);
        end
    else
        --- Take picture and exit
        if not (Stats) then
            SetCamCoord(uParam0.f_466, 402.6852, -1000.129, -98.46554);
            SetCamRot(uParam0.f_466, 2.366912, 0, -2.14811, 2);
            SetCamFov(uParam0.f_466, 9.958394);
            func_1673(uParam0.f_466, 4.0, 1.0, 1.2, 1.0);
        else
            SetCamCoord(uParam0.f_466, 402.6852, -1000.129, -98.46554);
            SetCamRot(uParam0.f_466, 0.861356, 0, -2.348183, 2);
            SetCamFov(uParam0.f_466, 10.00255);
            func_1673(uParam0.f_466, 4.0, 1.0, 1.2, 1.0);
        end
    end
    StopCamShaking(uParam0.f_466, 1)
    SetCamActiveWithInterp(uParam0.f_466, uParam0.f_465, 300, 1, 1);
end

function CreatorZoomIn(_Cam)
    PlaySoundFrontend(-1, "Zoom_In", "MUGSHOT_CHARACTER_CREATION_SOUNDS", 0, 0, 1);
    if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey('mp_m_freemode_01')) then
        func_1675(_Cam, 1, 1)
    else
        func_1675(_Cam, 1, 0)
    end
    RenderScriptCams(true, false, 3000, 1, 0, 0)
end

function AnimCam()
	local playerPed = PlayerPedId()
    DoScreenFadeOut(1000)
    Citizen.Wait(4000) 
    DestroyAllCams(true)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Camera['body'].x, Camera['body'].y, Camera['body'].z, 0.00, 0.00, 0.00, Camera['body'].fov, false, 0)
    SetCamActive(cam2, true)
    RenderScriptCams(true, false, 2000, true, true) 
    Citizen.Wait(500)
    DoScreenFadeIn(2000)
    SetEntityCoords(GetPlayerPed(-1), 405.59, -997.18, -99.00, 0.0, 0.0, 0.0, true)
    SetEntityHeading(GetPlayerPed(-1), 90.00)
    -- TriggerEvent('skinchanger:loadSkin', {sex = 0})
    changeGender(1)
    Citizen.Wait(500)
    cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 402.99, -998.02, -99.00, 0.00, 0.00, 0.00, 50.00, false, 0)
    PointCamAtCoord(cam3, 402.99, -998.02, -99.00)
    SetCamActiveWithInterp(cam2, cam3, 5000, true, true)
    LoadAnim("mp_character_creation@customise@male_a")
    TaskPlayAnim(GetPlayerPed(-1), "mp_character_creation@customise@male_a", "intro", 1.0, 1.0, 4000, 0, 1, 0, 0, 0)
    Citizen.Wait(5000)

    local coords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(coords, 402.89, -996.87, -99.0, true) > 0.5 then
    	SetEntityCoords(GetPlayerPed(-1), 402.89, -996.87, -99.0, 0.0, 0.0, 0.0, true)
    	SetEntityHeading(GetPlayerPed(-1), 173.97)
    end

    Citizen.Wait(100)
    RageUI.Visible(mainMenu, true)
    Citizen.Wait(1000)
    FreezeEntityPosition(GetPlayerPed(-1), true)
end

function EndCharCreator()
	local playerPed = GetPlayerPed(-1)
	DoScreenFadeOut(1000)
	Wait(1000)
	SetCamActive(camSkin,  false)
	RenderScriptCams(false,  false,  0,  true,  true)
	enable = false
	EnableAllControlActions(0)
    FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityCoords(playerPed, Config.PlayerSpawn.x, Config.PlayerSpawn.y, Config.PlayerSpawn.z)
	SetEntityHeading(playerPed, Config.PlayerSpawn.h)
	Wait(1000)
	ESX.UI.HUD.SetDisplay(1.0)
	DisplayRadar(true)
	DoScreenFadeIn(1000)
	Wait(1000)
	HideHudAndRadarThisFrame(true)
	TriggerServerEvent('esx_skin:save', Character)
	TriggerEvent('skinchanger:loadSkin', Character)
end

function LoadAnim(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end

function CreateSkinCam(camera)
	if camSkin then
		local newCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Camera[camera].x, Camera[camera].y, Camera[camera].z, 0.00, 0.00, 0.00, Camera[camera].fov, false, 0)
		PointCamAtCoord(newCam, Camera[camera].x, Camera[camera].y, Camera[camera].z)
   		SetCamActiveWithInterp(newCam, camSkin, 2000, true, true)
   		camSkin = newCam
	else
		camSkin = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Camera[camera].x, Camera[camera].y, Camera[camera].z, 0.00, 0.00, 0.00, Camera[camera].fov, false, 0)
	    SetCamActive(cam2, true)
	    RenderScriptCams(true, false, 2000, true, true) 
	end
end

-- Hide Player

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

-- Open Menu
RegisterNetEvent('Val:CharCreator')
AddEventHandler('Val:CharCreator', function()
	CharCreatorAnimation()
end)