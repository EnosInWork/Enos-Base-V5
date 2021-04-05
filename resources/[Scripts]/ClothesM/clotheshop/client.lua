local Keys = {
	["ESC"] = 322, 		["F1"] = 288, 		["F2"] = 289, 		["F3"] = 170, 		["F5"] = 166, 
	["F6"] = 167, 		["F7"] = 168, 		["F8"] = 169, 		["F9"] = 56, 		["F10"] = 57,
	["~"] = 243, 		["1"] = 157, 		["2"] = 158, 		["3"] = 160, 		["4"] = 164, 
	["5"] = 165,		["6"] = 159, 		["7"] = 161, 		["8"] = 162, 		["9"] = 163, 
	["-"] = 84, 		["="] = 83, 		["TAB"] = 37,		["Q"] = 44, 		["W"] = 32, 
	["E"] = 38, 		["R"] = 45, 		["T"] = 245, 		["Y"] = 246, 		["U"] = 303, 
	["P"] = 199, 		["["] = 39, 		["]"] = 40, 		["ENTER"] = 18, 	["CAPS"] = 137, 
	["A"] = 34, 		["S"] = 8, 			["D"] = 9, 			["F"] = 23, 		["G"] = 47, 
	["H"] = 74, 		["K"] = 311, 		["L"] = 182, 		["LEFTSHIFT"] = 21, ["Z"] = 20, 
	["X"] = 73, 		["C"] = 26, 		["V"] = 0, 			["B"] = 29,			["N"] = 249, 
	["M"] = 244, 		[","] = 82, 		["."] = 81, 		["LEFTCTRL"] = 36, 	["LEFTALT"] = 19,
	["SPACE"] = 22,		["RIGHTCTRL"] = 70, ["HOME"] = 213, 	["PAGEUP"] = 10, 	["PAGEDOWN"] = 11,
	["DELETE"] = 178, 	["LEFT"] = 174,		["RIGHT"] = 175, 	["TOP"] = 27, 		["DOWN"] = 173, 
	["NENTER"] = 201, 	["N4"] = 108, 		["N5"] = 60, 		["N6"] = 107,		["BACKSPACE"] = 177,
	["N+"] = 96, 		["N-"] = 97, 		["N7"] = 117, 		["N8"] = 61, 		["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function disableControl()
    DisableControlAction(2, 1, true)
    DisableControlAction(2, 1, true) -- Disable pan
    DisableControlAction(2, 2, true) -- Disable tilt 
    DisableControlAction(0, 59, true)
    SetPedCanPlayGestureAnims(GetPlayerPed(-1), false)
    DisableControlAction(2, 24, true) -- Attack
    DisableControlAction(2, 257, true) -- Attack 2
    DisableControlAction(2, 25, true) -- Aim
    DisableControlAction(2, 263, true) -- Melee Attack 1
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(27, 23, true) -- Also 'enter'?
    DisableControlAction(0, 23, true) -- Also 'enter'?
    DisableControlAction(0, 288, true) -- Disable phone
    DisableControlAction(0,289, true) -- Inventory
    DisableControlAction(0, 289,  true) -- Inventory block
    DisableControlAction(0, 73,  true) -- Handups
    DisableControlAction(0, 105,  true) -- Handups
    DisableControlAction(0, 29,  true) -- Point
    DisableControlAction(0, Keys['Q'], true)
    DisableControlAction(0, Keys['Z'], true)
    DisableControlAction(0, Keys['S'], true)
    DisableControlAction(0, Keys['D'], true) 
    DisablePlayerFiring(GetPlayerPed(-1), true)
    DisableControlAction(0, 82,  true) -- Animations
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle
    DisableControlAction(0, 65, true) -- Disable f9
    DisableControlAction(0, 167, true) -- Disable f6
    DisableControlAction(2, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 47, true)  -- Disable weapon
    DisableControlAction(0, 47, true)  -- Disable weapon
    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
end

RegisterNetEvent('Mushy:SyncAccess')
AddEventHandler('Mushy:SyncAccess', function()
    ESX.TriggerServerCallback("Mushy:getMask", function(result)
        MaskTab = result
    end)
end)

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function CreateMain()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z)
    SetCamFov(cam, 50.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateShoes()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.0, coords.y, coords.z)
    SetCamFov(cam, 50.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-1.0)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateFutal()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateArms()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.15)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.15)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateTop()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateFace()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
    SetCamFov(cam, 30.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateBack()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x+1.75, coords.y, coords.z+0.60)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateMontre()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.50, coords.y-1.5, coords.z+0.60)
    SetCamFov(cam, 20.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function Tourner()
    local back = GetEntityHeading(GetPlayerPed(-1))
    SetEntityHeading(GetPlayerPed(-1), back+180)
end

function Left()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x, coords.y-1.00, coords.z)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end



function Angle()
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

function gettxt2(txtt)
    AddTextEntry('FMMC_MPM_NA', "Texte")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", txtt, "", "", "", 100)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
		local result = GetOnscreenKeyboardResult()
		if tonumber(result) ~= nil then
			if tonumber(result) >= 1 then

				return tonumber(result)
			else
				
			end
		else
		return result
		end
    end

end


RMenu.Add('menu', 'main', RageUI.CreateMenu("Magasin", "~b~Actions disponibles"))
RMenu.Add('menu', 'access', RageUI.CreateMenu("Mes Accessoires", "~b~Actions disponibles"))
RMenu.Add('menu', 'torso', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Vestes", "~b~Actions disponibles"))
RMenu.Add('menu', 'pants', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Pantalon", "~b~Actions disponibles"))
RMenu.Add('menu', 'arms', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Bras", "~b~Actions disponibles"))
RMenu.Add('menu', 'shoes', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Chaussures", "~b~Actions disponibles"))
RMenu.Add('menu', 'glasses', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Lunettes", "~b~Actions disponibles"))
RMenu.Add('menu', 'hats', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Chapeaux", "~b~Actions disponibles"))
RMenu.Add('menu', 'bag', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Sac à dos", "~b~Actions disponibles"))
RMenu.Add('menu', 'oreille', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Boucles d'oreilles", "~b~Actions disponibles"))
RMenu.Add('menu', 'chain', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Chaînes", "~b~Actions disponibles"))
RMenu.Add('menu', 'clock', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Montres", "~b~Actions disponibles"))
RMenu.Add('menu', 'colortorso', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Variations du Torse", "~b~Actions disponibles"))
RMenu.Add('menu', 'colorpants', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Variations du Pantalon", "~b~Actions disponibles"))
RMenu.Add('menu', 'colorshoes', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Variations des Chaussures", "~b~Actions disponibles"))
RMenu.Add('menu', 'colortshirt', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Variations du T-shirt", "~b~Actions disponibles"))
RMenu.Add('menu', 'shirt', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "T-Shirt", "~b~Actions disponibles"))
RMenu.Add('menu', 'dressing', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Dressing", "~b~Actions disponibles"))
RMenu.Add('menu', 'watodo', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Que faire ?", "~b~Actions disponibles"))


local listClotheshop = {
	{x = 72.254,    y = -1399.102, z = 28.396},
	{x = -703.776,  y = -152.258,  z = 36.435},
	{x = -167.863,  y = -298.969,  z = 38.743},
	{x = 428.694,   y = -800.106,  z = 28.511},
	{x = -829.413,  y = -1073.710, z = 10.348},
	{x = -1447.797, y = -242.461,  z = 48.840},
	{x = 11.632,    y = 6514.224,  z = 30.897},
	{x = 123.646,   y = -219.440,  z = 53.577},
	{x = 1696.291,  y = 4829.312,  z = 41.083},
	{x = 618.093,   y = 2759.629,  z = 41.108},
	{x = 1190.550,  y = 2713.441,  z = 37.242},
	{x = -1193.429, y = -772.262,  z = 16.344},
	{x = -3172.496, y = 1048.133,  z = 19.883},
    {x = -1108.441, y = 2708.923,  z = 18.127}
}

local watodo = {
	indexwatodo = 1,
	listwatodo = {'Equiper', 'Renommer', 'Supprimer'},
}

local watodoo = {
	indexwatodoo = 1,
	listwatodoo = {'Equiper', 'Renommer', 'Donner', 'Jeter'},
}


local watoda = {
	indexwatoda = 1,
	listwatoda = {'Masque', 'Chapeau', 'Lunettes', 'Boucles d\'oreilles'},
}

MaskTab = {}
local TenueTable = {}
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      for k in pairs(listClotheshop) do

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, listClotheshop[k].x, listClotheshop[k].y, listClotheshop[k].z)

        if dist <= 1.5 then
            RageUI.Text({
                message = "Appuyez sur [E] pour changer de ~b~Style",
                time_display = 1
            })
                DisplayHelpTextThisFrame("HELP", false)
            attente = 1
            if IsControlJustPressed(1, 51) then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
                    --		curSex = skin.sex
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                CreateMain()
                DrawAnim()
                FreezeEntityPosition(GetPlayerPed(-1), true)
                RageUI.Visible(RMenu:Get('menu', 'main'), not RageUI.Visible(RMenu:Get('menu', 'main')))
                ESX.TriggerServerCallback('VmLife:GetTenues', function(skin)
                    TenueTable = skin
                end)
            end
        end
    end
        RageUI.IsVisible(RMenu:Get('menu', 'main'), true, true, true, function()
            Angle()
            disableControl()
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            if IsControlJustPressed(0, 191) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)     
            end
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                ClearPedTasks(GetPlayerPed(-1))
                FreezeEntityPosition(GetPlayerPed(-1), false)
            end
            RageUI.Button("Mon Dressing", "", { RightBadge = RageUI.BadgeStyle.Clothes },true, function()
            end, RMenu:Get('menu', 'dressing'))
            RageUI.Button("Vestes", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'torso'))
            RageUI.Button("Variations des Vestes", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'colortorso'))
            RageUI.Button("Bras", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'arms')) 
            RageUI.Button("T-Shirt", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'shirt'))
            RageUI.Button("Variations des T-Shirt", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'colortshirt'))
            RageUI.Button("Pantalon", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'pants'))
            RageUI.Button("Variations des Pantalons", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'colorpants'))
            RageUI.Button("Chaussures", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'shoes'))
            RageUI.Button("Variations des Chaussures", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'colorshoes'))
         --   RageUI.Button("Chapeaux", "", { RightLabel = "→" },true, function()
         --   end, RMenu:Get('menu', 'hats'))
         --   RageUI.Button("Lunettes", "", { RightLabel = "→" },true, function()
         --   end, RMenu:Get('menu', 'glasses'))
            RageUI.Button("Sac", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'bag'))
            RageUI.Button("Montres", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'clock'))
            RageUI.Button("Chaînes", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('menu', 'chain'))
         --   RageUI.Button("Boucles d'oreilles", "", { RightLabel = "→" },true, function()
         --   end, RMenu:Get('menu', 'oreille'))
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'dressing'), true, true, true, function()
            CreateMain()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            RageUI.Button("Sauvegarder une tenue", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    k = gettxt2("Comment veux-tu appeler ta tenue ?")
                    if k ~= nil then
                        if tostring(k) ~= nil and tostring(k) ~= "" then
        
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerServerEvent("VmLife:SaveTenueS",k,skin)
                            end)
                            Wait(550)
                            RageUI.CloseAll()
                        end
                    end
                end
            end)
            if #TenueTable == 0 then
                RageUI.Button("Vide", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    end
                end)
            end
            for i = 1, #TenueTable,1 do
                RageUI.List(TenueTable[i].label, watodo.listwatodo, watodo.indexwatodo, nil, { RightBadge = RageUI.BadgeStyle.Clothes }, true, function(Hovered, Active, Selected, Index)
                    if (Selected) then
                        clothes = TenueTable[i]

                        for k,Index in pairs(clothes) do
                            if k == "tenue" then
                            clothes = Index
                            break
                            end
                        end

                        if Index == 1 then
                            TriggerEvent('skinchanger:getSkin', function(skin)

                                TriggerEvent('skinchanger:loadClothes', skin, json.decode(clothes))
              
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                  TriggerServerEvent('esx_skin:save', skin)
                                end)
                            end)
                        elseif Index == 2 then
                            kx = gettxt2(TenueTable[i].label)
                            if tostring(kx) ~= nil then
                                TriggerServerEvent('VmLife:RenameTenue', TenueTable[i].id,kx)
                            end
                            RageUI.CloseAll()
                        elseif Index == 3 then
                            TriggerServerEvent('VmLife:DeleteTenue', TenueTable[i].id)
                            RageUI.CloseAll()
                        end
                    end
                    watodo.indexwatodo = Index
                end)
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'pants'), true, true, true, function()
            CreateFutal()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            for f = 1, 115 do
                RageUI.Button("Pantalon #" .. f, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        pants1 = f
                        pants2 = 0
                        SetPedComponentVariation(GetPlayerPed(-1), 4, pants1,pants2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {

                                ['pants_1'] =pants1, ['pants_2'] = pants2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
            tops = 115
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'colorshoes'), true, true, true, function()
            CreateShoes()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local am = {}
            for i = 0 , GetNumberOfPedTextureVariations(GetPlayerPed(-1),6, shoes1) , 1 do
                am[i] = i
                RageUI.Button("Variations #"..i, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        shoes2 = i
                        CreateShoes()
                        if IsControlJustPressed(0, 194) then
                            RenderScriptCams(0, 1, 1000, 1, 1)
                            DestroyAllCams(true)
                            CreateMain()
                        end
                        if IsControlJustPressed(0, 22) then
                            Tourner()       
                        end
                        SetPedComponentVariation(GetPlayerPed(-1), 6, shoes1, shoes2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {
    
                                ['shoes_1'] = shoes1, ['shoes_2'] = shoes2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
    
                
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'colortshirt'), true, true, true, function()
            CreateTop()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local am = {}
            for i = 0 , GetNumberOfPedTextureVariations(GetPlayerPed(-1),8, tshirt1) , 1 do
                am[i] = i
                RageUI.Button("Variations #"..i, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        tshirt2 = i
                        CreateTop()
                        if IsControlJustPressed(0, 194) then
                            RenderScriptCams(0, 1, 1000, 1, 1)
                            DestroyAllCams(true)
                            CreateMain()
                        end
                        if IsControlJustPressed(0, 22) then
                            Tourner()       
                        end
                        SetPedComponentVariation(GetPlayerPed(-1), 8, tshirt1, tshirt2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {
    
                                ['tshirt_1'] = tshirt1, ['tshirt_2'] = tshirt2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
    
                
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'colortorso'), true, true, true, function()
            CreateTop()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local am = {}
            for i = 0 , GetNumberOfPedTextureVariations(GetPlayerPed(-1),11, torso1) , 1 do
                am[i] = i
                RageUI.Button("Variations #"..i, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        torso2 = i
                        CreateTop()
                        if IsControlJustPressed(0, 194) then
                            RenderScriptCams(0, 1, 1000, 1, 1)
                            DestroyAllCams(true)
                            CreateMain()
                        end
                        if IsControlJustPressed(0, 22) then
                            Tourner()       
                        end
                        SetPedComponentVariation(GetPlayerPed(-1), 11, torso1, torso2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {
    
                                ['torso_1'] = torso1, ['torso_2'] = torso2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
    
                
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'colorpants'), true, true, true, function()
            CreateFutal()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local am = {}
            for i = 0 , GetNumberOfPedTextureVariations(GetPlayerPed(-1),4,pants1) , 1 do
                am[i] = i
                RageUI.Button("Variations #"..i, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        pants2 = i
                        CreateFutal()
                        if IsControlJustPressed(0, 194) then
                            RenderScriptCams(0, 1, 1000, 1, 1)
                            DestroyAllCams(true)
                            CreateMain()
                        end
                        if IsControlJustPressed(0, 22) then
                            Tourner()       
                        end
                        SetPedComponentVariation(GetPlayerPed(-1), 4, pants1, pants2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {
    
                                ['pants_1'] = pants1, ['pants_2'] = pants2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
    
                
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'torso'), true, true, true, function()
            CreateTop()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            for k = 1, 289 do
                RageUI.Button("Vestes #" .. k, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        torso1 = k
                        torso2 = 0
                        SetPedComponentVariation(GetPlayerPed(-1), 11, torso1,torso2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {

                                ['torso_1'] =torso1, ['torso_2'] = torso2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
            tops = 289
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'shoes'), true, true, true, function() 
            CreateShoes()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            for l = 1, 91 do
                RageUI.Button("Chaussures #" .. l, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        shoes1 = l
                        shoes2 = 0
                        SetPedComponentVariation(GetPlayerPed(-1), 6, shoes1,shoes2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {

                                ['shoes_1'] =shoes1, ['shoes_2'] = shoes2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
            tops = 91
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'glasses'), true, true, true, function()
            CreateFace()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            lunetteItem = {
                "Aucune",
                "Lunette sport",
                "Lunette de soleil",
                "Lunette old school",
                "Lunette moyen-age",
                "Lunette de soleil",
                "Aucune",
                "Lunette de soleil",
                "Lunette",
                "Lunette sport",
                "Lunette mafieux",
                "Aucune",
                "Lunette luxe",
                "Lunette de baron",
                "Aucune",
                "Lunette sport",
                "Lunette sport",
                "Lunette teinté",
                "Lunette",
                "Fausse lunette",
                "Lunette moderne",
                "Lunette america",
                "Lunette america",
                "Lunette sport",
                
                "Lunette aviateur",
                "Lunette aviateur"
            }
            for i = 0,25,1 do
                --
                local amount = {}
                local playerPed = GetPlayerPed(-1)
                local ind = i+1
                for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 1, i), 1 do
        
                    amount[c] = c 
                    
                end
                if lunetteItem[i] == nil then
                    lunetteItem[i] = "Lunette #"..i
                end
                RageUI.Button(lunetteItem[ind], "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        glasses1 = i
                        glasses2 = 0
                        SetPedPropIndex(playerPed, 1, glasses1-1, glasses2, 2)
                    end
                    if (Selected) then
                        TriggerServerEvent("dqp:SetNewMasque", glasses1, glasses2,"Lunette", lunetteItem[i])
                        TriggerServerEvent('shop:price', 25)
                    end
                end)
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'chain'), true, true, true, function()
            CreateTop()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local playerPed = GetPlayerPed(-1)
            for i = -1,GetNumberOfPedDrawableVariations(playerPed,7),1 do
                --
                local amount = {}
                local ind = i+2
                RageUI.Button("Chaine #"..ind, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        chain1 = i
                        chain2 = 0
                        SetPedComponentVariation(playerPed,7, chain1, chain2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
                            clothesSkin = {
            
                               ['chain_1'] = chain1,
                               ['chain_2'] = chain2,
                               
            
            
                           }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                           
                       
                       
                   end)
            
                   TriggerEvent('skinchanger:getSkin', function(skin)
            
                       
                       TriggerServerEvent('esx_skin:save', skin)
                       
                   
                   
                   end)
                    end
                end)
                
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'arms'), true, true, true, function()
            CreateArms()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            for a = 1, 144 do
                RageUI.Button("Bras #" .. a, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~0$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        arms1 = a
                        SetPedComponentVariation(GetPlayerPed(-1), 3, arms1)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {

                                ['arms'] = arms1
        
        
                            }
                            print(json.encode(skin))
                            print(json.encode(clothesSkin))
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
            tops = 144
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'oreille'), true, true, true, function()
            CreateFace()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            boucleItem = {
                "Oreillete",
                "Oreillete",
                "Oreillete",
                "Aucun",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
        
                "Boucle d'oreille",
        
        
        
            }
            local playerPed = GetPlayerPed(-1)
            for i = 0,36,1 do
                --
                local amount = {}
                local ind = i+1
                for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 2, i), 1 do
        
                    amount[c] = c 
                    
                end
                if boucleItem[i] == nil then
                    boucleItem[i] = "Boucle #"..i
                end
                RageUI.Button(boucleItem[ind], "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        boucl1 = i
                        boucl2 = 0
                        SetPedPropIndex(playerPed, 2, boucl1, boucl2, 2)
                    end
                    if (Selected) then
                        TriggerServerEvent("Mushy:SetNewMasque",boucl1,boucl2,"Boucle",boucleItem[i],2)
                        TriggerServerEvent('shop:price', 25)
                    end
                end)
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'clock'), true, true, true, function()
            CreateMontre()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            for i = -1,19,1 do
                --
                local amount = {}
                local playerPed = GetPlayerPed(-1)
                local ind = i+2
                for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 6, i+1), 1 do
        
                    amount[c] = c 
                    
                end

                RageUI.Button("Montre #"..ind, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        clock1 = i
                        clock2 = 0
                        SetPedPropIndex(playerPed, 6, clock1, clock2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
                            clothesSkin = {
            
                               ['watches_1'] = clock1,
                               ['watches_2'] = clock2,
                               
            
            
                           }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                           
                       
                       
                   end)
            
                   TriggerEvent('skinchanger:getSkin', function(skin)
            
                       
                       TriggerServerEvent('esx_skin:save', skin)
                       
                   
                   
                   end)
                    end
                end)
                
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'bag'), true, true, true, function()
            CreateBack()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            RageUI.Button("Aucun", "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                if (Active) then
                    SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 2)
                end
                if (Selected) then
                    TriggerEvent('skinchanger:getSkin', function(skin)
            
                        
            
                        clothesSkin = {
                           ['bags_1'] = 0, ['chain_1'] = 0,
        
        
                        }
                       TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                       TriggerServerEvent('shop:price', 25)
                       
                   
                   
               end)
        
               TriggerEvent('skinchanger:getSkin', function(skin)
        
                   
                   TriggerServerEvent('esx_skin:save', skin)
                   
               
               
               end)
                end
            end)
            RageUI.Button("Sac à dos", "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                if (Active) then
                    SetPedComponentVariation(GetPlayerPed(-1),7, 3, 0, 2)
                end
                if (Selected) then
                    TriggerEvent('skinchanger:getSkin', function(skin)
            
                        
            
                        clothesSkin = {
                           ['chain_1'] = 2, ['chain_2'] = 0,
        
        
                       }
        
                       TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                       TriggerServerEvent('shop:price', 25)
                       
                   
                   
               end)
        
               TriggerEvent('skinchanger:getSkin', function(skin)
        
                   
                   TriggerServerEvent('esx_skin:save', skin)
                   
               
               
               end)
                end
            end)
            RageUI.Button("Sac Tactique", "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                if (Active) then
                    SetPedComponentVariation(GetPlayerPed(-1), 5, 44, 0, 2)
                end
                if (Selected) then
                    TriggerEvent('skinchanger:getSkin', function(skin)
            
                        
            
                        clothesSkin = {
                           ['bags_1'] = 44, ['torso_2'] = 0,
        
        
                        }
                       TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                       TriggerServerEvent('shop:price', 25)
                       
                   
                   
               end)
        
               TriggerEvent('skinchanger:getSkin', function(skin)
        
                   
                   TriggerServerEvent('esx_skin:save', skin)
                   
               
               
               end)
                end
            end)
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'shirt'), true, true, true, function()
            CreateTop()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            for t = 1, 144 do
                RageUI.Button("T-Shirt #" .. t, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        tshirt1 = t
                        tshirt2 = 0
                        SetPedComponentVariation(GetPlayerPed(-1), 8, tshirt1,tshirt2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            clothesSkin = {

                                ['tshirt_1'] =tshirt1, ['tshirt_2'] = tshirt2,
        
        
                            }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           TriggerServerEvent('shop:price', 25)
                        end)
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
                            TriggerServerEvent('esx_skin:save', skin)
                        
                        end)
                    end
                end)
            end
            tops = 144
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'hats'), true, true, true, function()
            CreateFace()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local chapeauItem = {
                "Casque",
                "Bonnet d'âne",
                "Bonnet",
                "Bob",
                "Casquette LS",
                "Bonnet",
                "Casquette miliaire",
                "Beret",
                "",
                "Casquette à l'envers",
                "Casquette",
                "",
                "Chapeau",
                "Chapeau Cowboy",
                "Bandana",
                "Casque de musique",
                "Casque",
                "Casque",
                "Casque",
                "Casque de pilote",
                "Bob de pêcheur",
                "Chapeau chill",
                "Chapeau de noël",
                "Chapeau de lutin",
                "Corne de noël",
                "Chapeau",
                "Chapeau melon",
                "Chapeau haut",
                "Bonnet",
                "Chapeau",
                "Chapeau",
                "Chapeau USA",
                "Chapeau USA",
                "Chapeau USA",
                "Bonnet USA",
                "USA",
                "Entenne USA",
                "Casque à bière",
                "Casque aviation",
                "Casque d'intervention",
                "Chapeau noël",
                "Chapeau noël",
                "Chapeau noël",
                "Chapeau noël",
                "Casquette",
                "Casquette à l'envers",
                "Casquette LSPD",
                "Casque d'aviateur",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casquette",
                "Casquette",
                "Casquette",
                "Chapeau Alien",
                "Casquette",
                "Casque",
                "Casquette",
                "Chapeau",
                "Casque",
                "Chapeau",
                "Casquette"
                
            }
            for i = -1,GetNumberOfPedDrawableVariations(GetPlayerPed(-1), 0),1 do
                --
                local amount = {}
                local ind = i+2
                for c = 1, GetNumberOfPedPropTextureVariations(GetPlayerPed(-1), 0, i+1), 1 do
        
                    amount[c] = c 
                    
                end
                if chapeauItem[i] == nil then
                    chapeauItem[i] = i
                end
                RageUI.Button(chapeauItem[ind], "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        hats1 = i
                        hats2 = 0
                        SetPedPropIndex(GetPlayerPed(-1), 0, hats1-1, 0, 2)
                    end
                    if (Selected) then
                        TriggerServerEvent("Mushy:SetNewMasque", hats1-1,hats2,"Chapeau",chapeauItem[i],0)
                        TriggerServerEvent('shop:price', 25)
                    end
                end)
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('menu', 'access'), true, true, true, function()
            RageUI.List("Enlever", watoda.listwatoda, watoda.indexwatoda, nil, { RightBadge = RageUI.BadgeStyle.Clothes }, true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    if Index == 1 then
                        local dict = 'missfbi4'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)
                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(0)
                        end
                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'takeoff_mask'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Citizen.Wait(1000)
                        SetEntityCollision(GetPlayerPed(-1), true, true)
                        playerPed = GetPlayerPed(-1)
                        Citizen.Wait(200)
                        SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 2)
                        ClearPedTasks(playerPed)
                    elseif Index == 2 then
                        local dict = 'missheistdockssetup1hardhat@'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)

                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(0)
                        end

                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'put_on_hat'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Citizen.Wait(1000)
                        SetEntityCollision(GetPlayerPed(-1), true, true)
                        playerPed = GetPlayerPed(-1)
                        SetPedPropIndex(playerPed, 0, k.mask_1, k.mask_2, 2)
                        Citizen.Wait(200)
                        ClearPedProp(GetPlayerPed(-1), 0)
                        ClearPedTasks(playerPed)
                    elseif Index == 3 then
                        local dict = 'clothingspecs'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)

                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(0)
                        end

                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'try_glasses_positive_a'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Citizen.Wait(1000)
                        SetEntityCollision(GetPlayerPed(-1), true, true)
                        playerPed = GetPlayerPed(-1)
                        Citizen.Wait(200)
                        ClearPedProp(GetPlayerPed(-1), 1)
                        ClearPedTasks(playerPed)
                    elseif Index == 4 then
                        local dict = 'mp_masks@standard_car@rps@'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)

                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(0)
                        end

                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'put_on_mask'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Citizen.Wait(1000)
                        SetEntityCollision(GetPlayerPed(-1), true, true)
                        playerPed = GetPlayerPed(-1)
                        Citizen.Wait(200)
                        ClearPedProp(GetPlayerPed(-1), 2)
                        ClearPedTasks(playerPed)
                    end
                end
                watoda.indexwatoda = Index
            end)
            result = MaskTab
            if #result == 0 then
                RageUI.Button("Vide", nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    end
                end)
            end
            for i = 1, #result, 1 do
                RageUI.List(result[i].label, watodoo.listwatodoo, watodoo.indexwatodoo, nil, { RightBadge = RageUI.BadgeStyle.Clothes }, true, function(Hovered, Active, Selected, Index)
                    if (Selected) then
                        if Index == 1 then
                            k = json.decode(result[i].mask)
                            ped = GetPlayerPed(-1)
                            uno = k.mask_1
                            dos = k.mask_2
                            typos = result[i].type
                            --(typos)
                            if typos == "Masque" then
    
                                if ped then
                                    local dict = 'missfbi4'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Citizen.Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'takeoff_mask'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Citizen.Wait(1000)
                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                    playerPed = GetPlayerPed(-1)
                                    SetPedComponentVariation(playerPed, 1, k.mask_1, k.mask_2, 2)
                                    Citizen.Wait(200)
                                    ClearPedTasks(playerPed)
                                end
                            elseif typos == "Lunette" then
    
                                if ped then
                                    local dict = 'clothingspecs'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Citizen.Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'try_glasses_positive_a'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Citizen.Wait(1000)
                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                    playerPed = GetPlayerPed(-1)
                                    SetPedPropIndex(playerPed, 1, k.mask_1, k.mask_2, 2)
                                    Citizen.Wait(200)
                                    ClearPedTasks(playerPed)
                                end
    
                            elseif typos == "Chapeau" then
    
                                if ped then
                                    local dict = 'missheistdockssetup1hardhat@'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Citizen.Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'put_on_hat'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Citizen.Wait(1000)
                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                    playerPed = GetPlayerPed(-1)
                                    SetPedPropIndex(playerPed, 0, k.mask_1, k.mask_2, 2)
                                    Citizen.Wait(200)
                                    ClearPedTasks(playerPed)
                                end
                            elseif typos == "Boucle" then
    
                                if ped then
                                    local dict = 'mp_masks@standard_car@rps@'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Citizen.Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'put_on_mask'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Citizen.Wait(1000)
                                    SetEntityCollision(GetPlayerPed(-1), true, true)
                                    playerPed = GetPlayerPed(-1)
                                    SetPedPropIndex(playerPed, 2, k.mask_1, k.mask_2, 2)
                                    Citizen.Wait(200)
                                    ClearPedTasks(playerPed)
                                end
    
    
                            end
                        end
                        if Index == 2 then
                            typos = result[i].type
                            txt = gettxt2(result[i].label)
                            txt = tostring(txt)
                            if txt ~= nil then
                                TriggerServerEvent("Mushy:RenameMasque", result[i].id, txt, typos)
                              RageUI.CloseAll()
                              result[i].label = txt
    
                            end
                        end
                        if Index == 3 then
                            local myPed = PlayerPedId()
                            if result[i].index == 99 then
                                SetPedComponentVariation(playerPed, 1, 0, 0, 2)
                            else
                                ClearPedProp(myPed, result[i].index)
                            end
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local closestPed = GetPlayerPed(closestPlayer)
    
                            if IsPedSittingInAnyVehicle(closestPed) then
                                ESX.ShowNotification('~r~Impossible de donner un objet dans un véhicule')
                                return
                            end
    
                            if closestPlayer ~= -1 and closestDistance < 3.0 then
    
                                TriggerServerEvent('Mushy:GiveAccessories', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)
    
    
                                RageUI.CloseAll()
    
                                table.remove( MaskTab, i  )
    
                            else
                                ESX.ShowNotification("~r~Aucun joueurs proche")
    
                            end
                        end
                        if Index == 4 then
                            TriggerServerEvent('Mushy:Delclo', result[i].id, result[i].label,result[i])
                            TriggerEvent('Mushy:SyncAccess')

                            RageUI.CloseAll()
                        end
                    end
                    watodoo.indexwatodoo = Index
                end)
            end
        end, function()
        end, 1)
        end
    end)

local teb = {
	{title="Magasin de vêtements", colour=57, id=366, x = 72.254,    y = -1399.102, z = 28.396},
	{title="Magasin de vêtements", colour=57, id=366, x = -703.776,  y = -152.258,  z = 36.435},
	{title="Magasin de vêtements", colour=57, id=366, x = -167.863,  y = -298.969,  z = 38.743},
	{title="Magasin de vêtements", colour=57, id=366, x = 428.694,   y = -800.106,  z = 28.511},
	{title="Magasin de vêtements", colour=57, id=366, x = -1447.797, y = -242.461,  z = 48.840},
	{title="Magasin de vêtements", colour=57, id=366, x = 11.632,    y = 6514.224,  z = 30.897},
	{title="Magasin de vêtements", colour=57, id=366, x = 123.646,   y = -219.440,  z = 53.577},
	{title="Magasin de vêtements", colour=57, id=366, x = 1696.291,  y = 4829.312,  z = 41.083},
	{title="Magasin de vêtements", colour=57, id=366, x = 618.093,   y = 2759.629,  z = 41.108},
	{title="Magasin de vêtements", colour=57, id=366, x = 1190.550,  y = 2713.441,  z = 37.242},
	{title="Magasin de vêtements", colour=57, id=366, x = -1193.429, y = -772.262,  z = 16.344},
	{title="Magasin de vêtements", colour=57, id=366, x = -3172.496, y = 1048.133,  z = 19.883},
	{title="Magasin de vêtements", colour=57, id=366, x = -1108.441, y = 2708.923,  z = 18.127}
}

Citizen.CreateThread(function()
    for _, info in pairs(teb) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.75)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DrawAnim()
    local ped = GetPlayerPed(-1)
    local ad = "clothingshirt"
    loadAnimDict(ad)
    RequestAnimDict(dict)
    TaskPlayAnim(ped, ad, "check_out_a", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_c", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "intro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "outro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_base", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_a", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_c", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_d", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
end

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
      if IsControlJustPressed(0, 47) then
        ESX.TriggerServerCallback("Mushy:getMask", function(result)
            MaskTab = result
        end)
        Wait(25)
        RageUI.Visible(RMenu:Get('menu', 'access'), not RageUI.Visible(RMenu:Get('menu', 'access')))
	  end
	end
  end)



