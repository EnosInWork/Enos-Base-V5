ESX = nil
loaded = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
    loaded = true
    ESX.PlayerData = ESX.GetPlayerData()
end)

local hunger = 1.00
local thirst = 1.00

local showhud = true

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    ESX.PlayerData = playerData
end)

function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function GetMinimapAnchor()
    -- Safezone goes from 1.0 (no gap) to 0.9 (5% gap (1/20))
    -- 0.05 * ((safezone - 0.9) * 10)
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(false)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    if aspect_ratio > 2 then
        Minimap.width = xscale * (res_x / (4 * aspect_ratio))
        Minimap.height = yscale * (res_y / 5.674)
        Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
        Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
        Minimap.right_x = Minimap.left_x + Minimap.width + Minimap.width + 51 * xscale
        Minimap.top_y = Minimap.bottom_y - Minimap.height
        Minimap.x = Minimap.left_x + Minimap.width + 51 * xscale 
        Minimap.y = Minimap.top_y
        Minimap.xunit = xscale
        Minimap.yunit = yscale
        return Minimap
    else
        Minimap.width = xscale * (res_x / (4 * aspect_ratio))
        Minimap.height = yscale * (res_y / 5.674)
        Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
        Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
        Minimap.right_x = Minimap.left_x + Minimap.width
        Minimap.top_y = Minimap.bottom_y - Minimap.height
        Minimap.x = Minimap.left_x
        Minimap.y = Minimap.top_y
        Minimap.xunit = xscale
        Minimap.yunit = yscale
        return Minimap
    end
end

Citizen.CreateThread(function()
    while not loaded do
        Citizen.Wait(500)
    end
    while true do
        if showhud then
            local ui = GetMinimapAnchor()
            local yoffset = 1.2
            local pos = 0
            drawRct(ui.x, ui.y + ui.height - yoffset * ui.yunit, ui.width, 15 * ui.yunit, 0, 0, 0, 200)
            drawRct(ui.x, ui.y + ui.height - yoffset * ui.yunit + 3 * ui.yunit, (ui.width/2 - ui.xunit) * hunger, 8 * ui.yunit, 255, 155, 48, 125 )
            drawRct(ui.x, ui.y + ui.height - yoffset * ui.yunit + 3 * ui.yunit, ui.width/2 - ui.xunit, 8 * ui.yunit, 145, 89, 29, 125 )
            local thirst_width = (ui.width/2 - 2 * ui.xunit) * thirst - ((ui.width/2 - 2 * ui.xunit) * thirst) * 2  
            drawRct(ui.right_x, ui.y + ui.height - yoffset * ui.yunit + 3 * ui.yunit, thirst_width, 8 * ui.yunit, 99, 190, 255, 125 )
            drawRct(ui.right_x, ui.y + ui.height - yoffset * ui.yunit + 3 * ui.yunit, (ui.width/2 - 2 * ui.xunit) - ((ui.width/2 - 2 * ui.xunit) * 2) , 8 * ui.yunit, 71, 135, 181, 125 )
        end
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while not loaded do
        Citizen.Wait(500)
    end
    while true do
        TriggerEvent('esx_status:getStatus', 'hunger', function(h)
            TriggerEvent('esx_status:getStatus', 'thirst', function(t)
                hunger = h.getPercent() / 100
                thirst = t.getPercent() / 100
            end)
        end)
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      HideHudComponentThisFrame(1)  -- Wanted Stars
      HideHudComponentThisFrame(2)  -- Weapon Icon
      HideHudComponentThisFrame(3)  -- Cash
      HideHudComponentThisFrame(4)  -- MP Cash
      HideHudComponentThisFrame(6)  -- Vehicle Name
      HideHudComponentThisFrame(7)  -- Area Name
      HideHudComponentThisFrame(8)  -- Vehicle Class
      HideHudComponentThisFrame(9)  -- Street Name
      HideHudComponentThisFrame(13) -- Cash Change
      HideHudComponentThisFrame(17) -- Save Game
      HideHudComponentThisFrame(20) -- Weapon Stats
    end
end)