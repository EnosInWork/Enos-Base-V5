local inMenu = false
local SelectedPlayer = nil

function OpenWipeMenu()

    RMenu.Add("wipe", "wipe_playerlist", RageUI.CreateMenu("Wipe","Wipe menu created by Slyy#0001"))
    RMenu:Get('wipe', 'wipe_playerlist').Closed = function()
        inMenu = false
    end

    RMenu.Add('wipe', 'wipe_confirm', RageUI.CreateSubMenu(RMenu:Get('wipe', 'wipe_playerlist'), "Confirmation", "Are you sure you want to wipe this player ?"))
    RMenu:Get('wipe', 'wipe_confirm').Closed = function()
        SelectedPlayer = nil
    end

    if not inMenu then 
        inMenu = true
        RageUI.Visible(RMenu:Get('wipe', 'wipe_playerlist'), not RageUI.Visible(RMenu:Get('wipe', 'wipe_playerlist')))

        Citizen.CreateThread(function()

            while inMenu do

                RageUI.IsVisible(RMenu:Get("wipe",'wipe_playerlist'), true, true, true, function()
                    for k,v in pairs(GetActivePlayers()) do 
                        RageUI.ButtonWithStyle(GetPlayerServerId(v).." - "..GetPlayerName(v), nil, { RightLabel = ">> Wipe" }, true, function(Hovered, Active, Selected)
                            if Selected then
                                SelectedPlayer = GetPlayerServerId(v)
                            end
                        end, RMenu:Get('wipe', 'wipe_confirm'))
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("wipe",'wipe_confirm'), true, true, true, function()
                    RageUI.ButtonWithStyle("~g~Oui", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            inMenu = false
                            TriggerServerEvent("sWipe:WipePlayer", SelectedPlayer)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~Non", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            inMenu = false
                            SelectedPlayer = nil
                        end
                    end)
                end, function()    
                end, 1)

                Citizen.Wait(0)
            end
            inMenu = false
        end)
    end
end

RegisterCommand("wipe", function()
    OpenWipeMenu()
end, false)