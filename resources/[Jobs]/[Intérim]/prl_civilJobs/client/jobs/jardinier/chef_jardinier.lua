RMenu.Add('Jardinier', 'main', RageUI.CreateMenu("Jardinier", " "))
RMenu:Get('Jardinier', 'main'):SetSubtitle("~b~Manageur du Golf")
RMenu:Get('Jardinier', 'main').EnableMouse = false;
RMenu:Get('Jardinier', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

local vehicle = nil
local ZoneDeSpawn = vector3(-1336.572, 118.7055, 56.51094)

RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.Jardinier, true)
    if distance <= 3.0 then
        HelpMsg("Appuyer sur ~b~E~w~ pour parler avec la personne.")
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('Jardinier', 'main'), not RageUI.Visible(RMenu:Get('Jardinier', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('Jardinier', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Button("Demander à travailler sur le Golf", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Alors comme ça tu veux bosser sur le ~g~Golf~w~ hein ? Très bien, change toi !",
                    })
                    RageUI.Visible(RMenu:Get('Jardinier', 'main'), not RageUI.Visible(RMenu:Get('Jardinier', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleJardinier = true
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local clothesSkin = {
                            ['bags_1'] = 0, ['bags_2'] = 0,
                                ['tshirt_1'] = 59, ['tshirt_2'] = 0,
                                ['torso_1'] = 56, ['torso_2'] = 0,
                                ['arms'] = 30,
                                ['pants_1'] = 31, ['pants_2'] = 0,
                                ['shoes_1'] = 25, ['shoes_2'] = 0,
                                ['mask_1'] = 0, ['mask_2'] = 0,
                                ['bproof_1'] = 0, ['bproof_2'] = 0,
                                ['helmet_1'] = 0, ['helmet_2'] = 0,
                        }
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                    end)
                    local spawnRandom = vector3(ZoneDeSpawn.x+math.random(1,15), ZoneDeSpawn.y+math.random(1,15), ZoneDeSpawn.z)
                    ESX.Game.SpawnVehicle(1783355638, spawnRandom, 274.95318603516, function(veh)
                        vehicle = NetworkGetNetworkIdFromEntity(veh)
                        local blip = AddBlipForEntity(veh)
                        SetBlipSprite(blip, 559)
                        SetBlipFlashes(blip, true)
                    end)
                    StartTravailleJardinier()
                end
            end)
            RageUI.Button("Arreter de travailler", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.",
                    })
                    RageUI.Visible(RMenu:Get('Jardinier', 'main'), not RageUI.Visible(RMenu:Get('Jardinier', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleJardinier = false
                    ESX.Game.DeleteVehicle(NetworkGetEntityFromNetworkId(vehicle))
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        local isMale = skin.sex == 0
                        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                TriggerEvent('esx:restoreLoadout')
                            end)
                        end)
                    end)
                end
            end)
        end, function()
            ---Panels
        end)
    end
end, 1)