ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


ConfPnjSale              = {}
ConfPnjSale.DrawDistance = 25
ConfPnjSale.Size         = {x = 1.0, y = 1.0, z = 1.0}
ConfPnjSale.Color        = {r = 255, g = 20, b = 20}
ConfPnjSale.Type         = 20

ConfPnjSale.Item = {
    Braquage = {
        {Label = 'C4', Value = 'c4_bank', Price = 5500},
        {Label = 'Rasperry', Value = 'rasperry', Price = 1000},
        {Label = 'Chalumeau', Value = 'blowtorch', Price = 1000},
    },
    Items = {
        {Label = 'Munitions', Value = 'clip', Price = 50},
        {Label = 'Kevlar', Value = 'kevlar', Price = 200},
    }
}

local position = {
{x =   750.51,   y = -3198.8,  z = 5.9}        
}  

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (ConfPnjSale.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < ConfPnjSale.DrawDistance) then
                DrawMarker(ConfPnjSale.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfPnjSale.Size.x, ConfPnjSale.Size.y, ConfPnjSale.Size.z, ConfPnjSale.Color.r, ConfPnjSale.Color.g, ConfPnjSale.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

local index = {
    items = 1
}

local index2 = {
     items = 1
}

local percent = 100
local a = 255
local nombre = {}

local max = 20 -- number of items that can be selected
Numbers = {}

RMenu.Add('cshop', 'main', RageUI.CreateMenu("Shop", "~r~Armurerie"))
RMenu.Add('cshop', 'shop', RageUI.CreateSubMenu(RMenu:Get('cshop', 'main'), "Shop", "~r~Voici nos armes."))
RMenu.Add('cshop', 'Shop', RageUI.CreateSubMenu(RMenu:Get('cshop', 'main'), "Shop", "~r~Voici nos accessoires."))
RMenu.Add('cshop', 'Braquage', RageUI.CreateSubMenu(RMenu:Get('cshop', 'main'), "Shop", "~r~Voici nos objets de braquage."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('cshop', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Armes", "Pour accéder aux armes.", {RigtLabel = "→→"},true, function()
            end, RMenu:Get('cshop', 'shop')) 

            RageUI.ButtonWithStyle("Objet à braquage", "Pour accéder aux objets de braquage.", {RigtLabel = "→→"},true, function()
            end, RMenu:Get('cshop', 'Braquage')) 

            RageUI.ButtonWithStyle("Accessoires", "Pour accéder aux accessoires.", {RigtLabel = "→→"},true, function()
            end, RMenu:Get('cshop', 'Shop')) 

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('cshop', 'shop'), true, true, true, function()

        RageUI.ButtonWithStyle("Pistolet", nil, {RightLabel = "~r~8,000$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            	local item = "weapon_pistol"
            	local prix = 8000
                TriggerServerEvent('cshop:acheter', item, prix)
            end
            end)


        RageUI.ButtonWithStyle("Pistolet Calibre 50", nil, {RightLabel = "~r~9,500$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            	local item = "weapon_pistol50"
            	local prix = 9500
                TriggerServerEvent('cshop:acheter', item, prix)
            end
            end)

            RageUI.ButtonWithStyle("Pistolet de combat", nil, {RightLabel = "~r~10,000$"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    local item = "weapon_combatpistol"
                    local prix = 10000
                    TriggerServerEvent('cshop:acheter', item, prix)
                end
            end)

            RageUI.ButtonWithStyle("Revolver", nil, {RightLabel = "~r~15,000$"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        local item = "weapon_doubleaction"
                        local prix = 15000
                        TriggerServerEvent('cshop:acheter', item, prix)
                end
            end)

            RageUI.ButtonWithStyle("Micro-SMG", nil, {RightLabel = "~r~25,000$"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    local item = "weapon_microsmg"
                    local prix = 25000
                    TriggerServerEvent('cshop:acheter', item, prix)
                end
            end)

            RageUI.ButtonWithStyle("Mini-SMG", nil, {RightLabel = "~r~27,500$"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    local item = "weapon_machinepistol"
                    local prix = 27500
                    TriggerServerEvent('cshop:acheter', item, prix)
                end
            end)

            RageUI.ButtonWithStyle("Fusil Canon cié", nil, {RightLabel = "~r~30,000$"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    local item = "weapon_sawnoffshotgun"
                    local prix = 30000
                    TriggerServerEvent('cshop:acheter', item, prix)
                end
            end)

            RageUI.ButtonWithStyle("AK-Compact", nil, {RightLabel = "~r~35,000$"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    local item = "weapon_compactrifle"
                    local prix = 35000
                    TriggerServerEvent('cshop:acheter', item, prix)
                end
            end)
           

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('cshop', 'Braquage'), true, true, true, function()

			for k, v in pairs(ConfPnjSale.Item.Braquage) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1)  .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index


                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('cshop:acheteritem', v, count)
                    end
                end)
            end
    
            end, function()
            end)

        RageUI.IsVisible(RMenu:Get('cshop', 'Shop'), true, true, true, function()

            for k, v in pairs(ConfPnjSale.Item.Items) do
                RageUI.List(v.Label .. ' (Prix: ' .. v.Price * (nombre[v.Value] or 1)  .. '$)', Numbers, nombre[v.Value] or 1, nil, { }, true, function(hovered, active, selected, Index)
                    nombre[v.Value] = Index


                    if selected then
                        local item = v.Value
                        local count = Numbers[Index]
                        local price = v.Price * count

                        TriggerServerEvent('cshop:acheteritem', v, count)
                    end
                end)
            end

        end, function()
        end)

        Citizen.Wait(0)
    end
end)



Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au shop !")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('cshop', 'main'), not RageUI.Visible(RMenu:Get('cshop', 'main')))
                    end   
                end
            end
        end
    end)
