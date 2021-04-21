anonymous = 0
position = 1420

print("^2Report Bot est EN LIGNE")

local mainMenu = RageUI.CreateMenu("", "Merci de votre aide!", position, nil, "banner", "shopui_title_gunclub")
local subMenu =  RageUI.CreateSubMenu(mainMenu, "", "Merci de votre aide!", position, nil, "banner", "shopui_title_gunclub")
local subMenu2 =  RageUI.CreateSubMenu(mainMenu, "", "Merci de votre aide!", position, nil, "banner", "shopui_title_gunclub")
local subMenu3 =  RageUI.CreateSubMenu(mainMenu, "", "Merci de votre aide!", position, nil, "banner", "shopui_title_gunclub")

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
end
mainMenu.EnableMouse = false
mainMenu.onIndexChange = function(Index)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if IsControlJustPressed(1, 57) then -- Key 344 ist F11
            RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
        end
    end
end)

local index = {
    checkbox = false,
    list = 2,
    heritage = 0.5,
    slider = 50,
    sliderprogress = 50,
    grid = {
        default = { x = 0.5, y = 0.5 },
        horizontal = { x = 0.5 },
        vertical = { y = 0.5 },
    },
    percentage = 0.5,
    color = {
        primary = { 1, 5 },
        secondary = { 1, 5 }
    },
}

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1.0)

        RageUI.IsVisible(mainMenu, function()

            RageUI.Button('Signaler un joueur ', '~g~Signaler un joueur', { RightLabel = "→→→" }, true, {
                onHovered = function()
                end,
                onSelected = function()

                local nameResults = KeyboardInput("Entrez le nom de la personne:", "", 20)
                local reasonResults = KeyboardInput("Raison: ", "", 200)

                if anonymous == 1 then
                    playerName = 'Anonymous'
                else
                    playerName = GetPlayerName(PlayerId())
                end

                if nameResults == nil or nameResults == "" then
                    TriggerEvent('chatMessage', "REPORT", {255, 0, 0}, "Aucun nom donné")
                else
                    TriggerServerEvent('player:results', nameResults, playerName, reasonResults)
                    TriggerEvent('chatMessage', "REPORT", {0, 255, 0}, "Vous avez signalé: ".. nameResults .. " Signalé en raison de: " .. reasonResults)
                    end
                end,
            });

            RageUI.Button('Signaler un bug', '~g~Signaler un Bug', { RightLabel = "→→→" }, true, {
                onHovered = function()
                end,
                onSelected = function()
                    local bugresults = KeyboardInput("REPORT BUG:", "", 200)

                    if anonymous == 1 then
                        playerName = 'Anonymous'
                    else
                        playerName = GetPlayerName(PlayerId())
                    end

                    if bugresults == "Describe the Bug" then
                        TriggerEvent('chatMessage', "Report", {255, 0, 0}, "Message vide")
                    elseif bugresults == nil or bugresults == "" then
                        TriggerEvent('chatMessage', "Report", {255, 0, 0}, "Message vide")
                    else
                        TriggerServerEvent('bugs:report', playerName, bugresults)
                        TriggerEvent('chatMessage', "Report", {0, 255, 0}, "Rapport de bugs réussi à l'équipe de DEV.")
                    end
                end,
            });

            RageUI.Button('RÉGLAGES', "~g~Réglages", { RightLabel = "→→→" }, true, {onSelected = function() end}, subMenu3);

            end, function()
        end)


            -- SETTNINGS
            RageUI.IsVisible(subMenu3, function()

                RageUI.Checkbox('Anonymous', 'Cela vous rendra anonyme lorsque vous signalerez un bug / joueur.', index.checkbox, {}, {
                    onChecked = function()
                        anonymous = 1
                    end,
                    onUnChecked = function()
                        anonymous = 0
                    end,
                    onSelected = function(Index)
                        index.checkbox = Index
                    end
                })

            end, function() end)
    end

end)

mainMenu:DisplayGlare(true)
subMenu:DisplayGlare(true)
subMenu2:DisplayGlare(true)
subMenu3:DisplayGlare(true)

mainMenu:DisplayPageCounter(true)
subMenu:DisplayPageCounter(true)
subMenu2:DisplayPageCounter(true)
subMenu3:DisplayPageCounter(true)

-- Functions below

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
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


AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        print('^1Report Bot est HORS LIGNE')
    end
end)