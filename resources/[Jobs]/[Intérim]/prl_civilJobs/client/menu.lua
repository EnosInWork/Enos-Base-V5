ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RMenu.Add('int', 'central', RageUI.CreateMenu("Pole-Emploi", "Centre"))
RMenu.Add('int', 'main', RageUI.CreateSubMenu(RMenu:Get('int', 'central'), "Pole-Emploi", "Métiers en Intérim"))
RMenu.Add('int', 'libre', RageUI.CreateSubMenu(RMenu:Get('int', 'central'), "Pole-Emploi", "Métiers Libre"))
RMenu.Add('int', 'whitelist', RageUI.CreateSubMenu(RMenu:Get('int', 'central'), "Pole-Emploi", "Métiers en Whitelist"))

RMenu:Get('int', 'central').Closed = function()
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(cam, 1)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end

local metier = {
    chantier = {
        nom = "Travailler sur le chantier",
        desc = "~g~Aucun diplôme demandé.",
        coords = zone.Chantier,
    },
    jardinier = {
        nom = "Nettoyer le terrain de golf",
        desc = "~g~Aucun diplôme demandé.",
        coords = zone.Jardinier,
    },
    Mine = {
        nom = "Travailler à la mine",
        desc = "~g~Aucun diplôme demandé.",
        coords = zone.mine,
    },
    Bucheron = {
        nom = "Travailler en temps que bucheron",
        desc = "~g~Aucun diplôme demandé.",
        coords = zone.bucheron,
    },
}


RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zone.Lifeinveders, true)
    if distance <= 3.0 then
        HelpMsg("Appuyez sur ~b~E~w~ pour parler avec la personne.")
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('int', 'central'), not RageUI.Visible(RMenu:Get('int', 'central')))
            CreateCamera()
        end
    end

    if RageUI.Visible(RMenu:Get('int', 'central')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Métiers en Intérim", null ,  {RightLabel = "→"},true, function()
            end, RMenu:Get('int', 'main'))

            RageUI.Button("Métiers Libre", null ,  {RightLabel = "→"},true, function()
            end, RMenu:Get('int', 'libre'))

            RageUI.Button("Métiers Whitelist", null ,  {RightLabel = "→"},true, function()
            end, RMenu:Get('int', 'whitelist'))

        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('int', 'libre')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Retourner au chomage", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('BuyChomeur')
                end
            end)

            RageUI.Button("Abatteur", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('BuyAbatteur')
                end
            end)

         RageUI.Button("Couturier", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('BuyCouturier')
                end
            end)

    RageUI.Button("Pêcheur", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('BuyPecheur')
                end
            end)

        RageUI.Button("Raffineur", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('BuyRaffineur')
                end
            end)

        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('int', 'whitelist')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("LSPD", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer la ~b~LSPD~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

            RageUI.Button("L.S.M.S", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~L.S.M.S~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

            RageUI.Button("FBI", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~FBI~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)  
            
            RageUI.Button("Gouvernement", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Gouvernement~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)  

            RageUI.Button("Concessionnaire", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Concess~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

            RageUI.Button("Concessionnaire-Moto", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Concess-Moto~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

            RageUI.Button("Mécano", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Benny's~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

            RageUI.Button("Vigneron", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Vigneron~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)
            
            RageUI.Button("Bahamas", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Bahamas~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)   

            RageUI.Button("Unicorn", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Unicorn~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)   

            RageUI.Button("Galaxy", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~Galaxy~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)  
            
            RageUI.Button("Armurier", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer l'~b~Armurie~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

            RageUI.Button("Agent-Immo", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer l'~b~Agence Immo~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

            RageUI.Button("WeazelNews", nil, {RightLabel = "→ Choisir"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.Popup({
                        message = "Pour intégrer le ~b~WeazelNews~w~, veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~",
                        sound = {
                            audio_name = "BASE_JUMP_PASSED",
                            audio_ref = "HUD_AWARDS",
                        }
                    })
                end
            end)

        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('int', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()


        
            for _,v in pairs(metier) do
                RageUI.Button(v.nom, v.desc, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        SetNewWaypoint(v.coords)
                        RageUI.Visible(RMenu:Get('int', 'main'), not RageUI.Visible(RMenu:Get('int', 'main')))
                        RenderScriptCams(0, 1, 1500, 1, 1)
                        DestroyCam(cam, 1)
                        RageUI.Popup({
                            message = "Vous avez choisis de ~b~"..v.nom.."~w~ ? Très bien, je vous ai donné les coordonées GPS sur votre téléphone. ~g~Merci d'utiliser nos services !",
                            sound = {
                                audio_name = "BASE_JUMP_PASSED",
                                audio_ref = "HUD_AWARDS",
                            }
                        })
                    end
                end)
            end

        end, function()
            ---Panels
        end)
    end
end, 1)

