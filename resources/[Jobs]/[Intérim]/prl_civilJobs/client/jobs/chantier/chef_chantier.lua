RMenu.Add('Chantier', 'main', RageUI.CreateMenu("Chantier", " "))
RMenu:Get('Chantier', 'main'):SetSubtitle("~b~Manager du chantier")
RMenu:Get('Chantier', 'main').EnableMouse = false;
RMenu:Get('Chantier', 'main').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.Chantier, true)
    if distance <= 3.0 then
        HelpMsg("Appuyer sur ~b~E~w~ pour parler avec la personne.")
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('Chantier', 'main'), not RageUI.Visible(RMenu:Get('Chantier', 'main')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('Chantier', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            RageUI.Button("Demander à travailler sur le chantier", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Alors comme ça tu veux bosser sur le ~g~chantier~w~ hein ? Très bien, met un casque et prends t'es outils ! Je te préviens c'est pas pour les petite merdes !",
                    })
                    RageUI.Visible(RMenu:Get('Chantier', 'main'), not RageUI.Visible(RMenu:Get('Chantier', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleChantier = true
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
                        tenueWeed = true
                    end)
                    StartTravailleChantier()
                end
            end)
            RageUI.Button("Arreter de travailler", "", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.",
                    })
                    RageUI.Visible(RMenu:Get('Chantier', 'main'), not RageUI.Visible(RMenu:Get('Chantier', 'main')))
                    RenderScriptCams(0, 1, 1500, 1, 1)
                    DestroyCam(cam, 1)
                    AuTravailleChantier = false
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