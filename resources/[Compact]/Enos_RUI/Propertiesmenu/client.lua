ESX = nil

local preview_possible = false

local propr = {
	index = 1,
	list = {"Petite", "Centre Ville", "Moderne", "Haute", "Luxe", "Motel", "Entrepot grand", "Entrepot moyen", "Entrepot petit" , "Sous marin" , "Bureau d'avocat" , "Bunker luxieux" , "Maison 3 étages" , "Retour"},
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end

	RMenu.Add('menu', 'main', RageUI.CreateMenu("Agence Immobilière", "~b~Agence Immobilière"))
	RMenu.Add('menu', 'editlogements', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Création de propriété", "~b~Création de propriété"))
	RMenu.Add('menu', 'modelprop', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Modèle Intérieur", "~b~Visite Intérieur"))
	RMenu.Add('menu', 'visiterprop', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Visiter Intérieur", "~b~Visite Intérieur"))
    RMenu:Get('menu', 'main'):SetSubtitle("~b~Agence Immobilière")
    RMenu:Get('menu', 'main').EnableMouse = false
	RMenu:Get('menu', 'main').Closed = function()

		A.Menu = false
    end
end)

A = {
    Menu = false,
}

local name = ''
local exit = ''
local label = ''
local inside = ''
local outside = ''
local ipl = ''
local isRoom = ''
local roommenu = ''
local price = ''
local entering = ''
local entrer = ''
local isSingle = ''
local price = 0 

local debug = false -- debug mode


local zones = { 
	['AIRP'] = "Los Santos International Airport",
	['ALAMO'] = "Alamo Sea", 
	['ALTA'] = "Alta", 
	['ARMYB'] = "Fort Zancudo", 
	['BANHAMC'] = "Banham Canyon Dr", 
	['BANNING'] = "Banning", 
	['BEACH'] = "Vespucci Beach", 
	['BHAMCA'] = "Banham Canyon", 
	['BRADP'] = "Braddock Pass", 
	['BRADT'] = "Braddock Tunnel", 
	['BURTON'] = "Burton", 
	['CALAFB'] = "Calafia Bridge", 
	['CANNY'] = "Raton Canyon", 
	['CCREAK'] = "Cassidy Creek", 
	['CHAMH'] = "Chamberlain Hills", 
	['CHIL'] = "Vinewood Hills", 
	['CHU'] = "Chumash", 
	['CMSW'] = "Chiliad Mountain State Wilderness", 
	['CYPRE'] = "Cypress Flats", 
	['DAVIS'] = "Davis", 
	['DELBE'] = "Del Perro Beach", 
	['DELPE'] = "Del Perro", 
	['DELSOL'] = "La Puerta", 
	['DESRT'] = "Grand Senora Desert", 
	['DOWNT'] = "Downtown", 
	['DTVINE'] = "Downtown Vinewood", 
	['EAST_V'] = "East Vinewood", 
	['EBURO'] = "El Burro Heights", 
	['ELGORL'] = "El Gordo Lighthouse", 
	['ELYSIAN'] = "Elysian Island", 
	['GALFISH'] = "Galilee", 
	['GOLF'] = "GWC and Golfing Society", 
	['GRAPES'] = "Grapeseed", 
	['GREATC'] = "Great Chaparral", 
	['HARMO'] = "Harmony", 
	['HAWICK'] = "Hawick", 
	['HORS'] = "Vinewood Racetrack", 
	['HUMLAB'] = "Humane Labs and Research", 
	['JAIL'] = "Bolingbroke Penitentiary", 
	['KOREAT'] = "Little Seoul", 
	['LACT'] = "Land Act Reservoir", 
	['LAGO'] = "Lago Zancudo", 
	['LDAM'] = "Land Act Dam", 
	['LEGSQU'] = "Legion Square", 
	['LMESA'] = "La Mesa", 
	['LOSPUER'] = "La Puerta", 
	['MIRR'] = "Mirror Park", 
	['MORN'] = "Morningwood", 
	['MOVIE'] = "Richards Majestic", 
	['MTCHIL'] = "Mount Chiliad", 
	['MTGORDO'] = "Mount Gordo", 
	['MTJOSE'] = "Mount Josiah", 
	['MURRI'] = "Murrieta Heights", 
	['NCHU'] = "North Chumash", 
	['NOOSE'] = "N.O.O.S.E", 
	['OCEANA'] = "Pacific Ocean", 
	['PALCOV'] = "Paleto Cove", 
	['PALETO'] = "Paleto Bay", 
	['PALFOR'] = "Paleto Forest", 
	['PALHIGH'] = "Palomino Highlands", 
	['PALMPOW'] = "Palmer-Taylor Power Station", 
	['PBLUFF'] = "Pacific Bluffs", 
	['PBOX'] = "Pillbox Hill", 
	['PROCOB'] = "Procopio Beach", 
	['RANCHO'] = "Rancho", 
	['RGLEN'] = "Richman Glen", 
	['RICHM'] = "Richman", 
	['ROCKF'] = "Rockford Hills", 
	['RTRAK'] = "Redwood Lights Track", 
	['SANAND'] = "San Andreas", 
	['SANCHIA'] = "San Chianski Mountain Range", 
	['SANDY'] = "Sandy Shores", 
	['SKID'] = "Mission Row", 
	['SLAB'] = "Stab City", 
	['STAD'] = "Maze Bank Arena", 
	['STRAW'] = "Strawberry", 
	['TATAMO'] = "Tataviam Mountains", 
	['TERMINA'] = "Terminal", 
	['TEXTI'] = "Textile City", 
	['TONGVAH'] = "Tongva Hills", 
	['TONGVAV'] = "Tongva Valley", 
	['VCANA'] = "Vespucci Canals", 
	['VESP'] = "Vespucci", 
	['VINE'] = "Vinewood",
	['WINDF'] = "Ron Alternates Wind Farm", 
	['WVINE'] = "West Vinewood",
	['ZANCUDO'] = "Zancudo River",
	['ZP_ORT'] = "Port of South Los Santos", 
	['ZQ_UAR'] = "Davis Quartz" 
	}


local function noSpace(str)
	local normalisedString = string.gsub(str, "%s+", "")
	return normalisedString
 end
 
 function OpenKeyboard(type, labelText)
	 
	 AddTextEntry('FMMC_KEY_TIP1', labelText)
	 DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 25)
	 blockinput = true
 
	 while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		 Citizen.Wait(0)
	 end
		 
	 if UpdateOnscreenKeyboard() ~= 2 then
		 local result = GetOnscreenKeyboardResult() 
		 Citizen.Wait(500) 
		 blockinput = false 
		 if type == "name" then 
			 ESX.ShowNotification("Nom assigné : ~b~"..noSpace(result))
			 return noSpace(result) 
		 elseif type == "label" then 
			 ESX.ShowNotification("Label assigné : ~b~"..result)
			 return result
		 else 
			 if tonumber(result) == nil then 
				ESX.ShowNotification("Vous devez entré un ~r~prix")
				return
			 end	
			 ESX.ShowNotification("Prix assigné : ~b~"..tonumber(result).."~w~ $")
			 return tonumber(result)
		 end
	 else
		 Citizen.Wait(500)
		 blockinput = false 
		 return nil
	 end
 end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function openPropertiesMenu()
    if A.Menu then
        A.Menu = false
    else
        A.Menu = true
        RageUI.Visible(RMenu:Get('menu', 'main'), true)

        Citizen.CreateThread(function()
			while A.Menu do
				RageUI.IsVisible(RMenu:Get('menu', 'main'), true, true, true, function()
					RageUI.ButtonWithStyle("Créer une propriété", nil, { RightLabel = "→→" },true, function()
					end, RMenu:Get('menu', 'editlogements'))
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'editlogements'), true, true, true, function()

					RageUI.ButtonWithStyle("Définir le nom de la propriété", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							name  =  OpenKeyboard('name', 'Entrer un nom sans éspace !')
						end
					end)
					RageUI.ButtonWithStyle("Définir le label de la propriété", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							label = OpenKeyboard('label', 'Entrer un label !')
						end
					end)
					RageUI.Separator()
					
					RageUI.ButtonWithStyle("Définir point d'entrée (exterieur)", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							local pos = GetEntityCoords(PlayerPedId())
							local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	        				local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
							local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
							
							entering = json.encode(PlayerCoord)

							PedPosition = pos
							DrawMarker(1, pos.x, pos.y, pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.5, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)  
							ESX.ShowNotification('position de la porte d\'~g~entrée~s~ : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z.. '~w~, Adresse : ~b~'..current_zone.. '')
						end
					end)
					RageUI.ButtonWithStyle("Définir point de sortie (extérieur)", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							local pos = GetEntityCoords(PlayerPedId())
							local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
							local Out = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z+2, 4)}
							outside  = json.encode(Out)
							ESX.ShowNotification('position de la ~r~sortie~s~ : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z..'')
						end
					end)
					RageUI.ButtonWithStyle("Définir point coffre (intérieur)", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							local pos = GetEntityCoords(PlayerPedId())
							local CoffreCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 
							roommenu = json.encode(CoffreCoord)
							ESX.ShowNotification('position du coffre :~b~'..CoffreCoord.x..' , '..CoffreCoord.y..' , '..CoffreCoord.z.. '')
							inventoryVector = GetEntityCoords(PlayerPedId())
						--	previewMarkers["dressingVector"] = {vector = dressingVector, color = {r = 0, g = 0, b = 255}}
						end
					end)
					RageUI.Separator("")

					RageUI.Checkbox("Mode Visite", description, checkbox,{ RightLabel = "" },function(Hovered,Ative,Selected,Checked)
						if (Selected) then
							checkbox = not checkbox
							if Checked then
								RageUI.Text({
									message = "~g~Mode Visite activé~s~ \nRevenez à l'agence en cliquant sur Retour",
									time_display = 10000
								})
								preview_possible = true
							else
								RageUI.Text({
									message = "~r~Mode Visite désactivé~s~",
									time_display = 10000
								})
								preview_possible = false
							end
						end
					end)

					RageUI.List('~b~Voici la liste des propriétés', propr.list, propr.index, nil, {}, true, function(Hovered, Active, Selected, Index)
						if (Active) then 
							propr.index = Index
						end
						if (Selected) then
							if preview_possible then
								if Index == 1 then
									SetEntityCoords(GetPlayerPed(-1), 265.6031, -1002.9244, -99.0086)
									ipl = '[]'
									inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
									exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
									isSingle = 1
									isRoom = 1
									isGateway = 0    
								elseif Index == 2 then
									SetEntityCoords(GetPlayerPed(-1), -616.8566, 59.3575, 98.2000)
									ipl = '[]'
									inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
									exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
									isSingle = 1
									isRoom = 1
									isGateway = 0     
								elseif Index == 3 then
									SetEntityCoords(GetPlayerPed(-1), -788.3881, 320.2430, 187.3132)
									ipl = '["apa_v_mp_h_01_a"]'
									inside = '{"x":-785.13,"y":315.79,"z":187.91}'
									exit = '{"x":-786.87,"y":315.7497,"z":186.91}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 4 then
									SetEntityCoords(GetPlayerPed(-1), -1459.1700, -520.5855, 56.9247)  
									ipl = '[]'
									inside = '{"x":-1459.17,"y":-520.58,"z":54.929}'
									exit = '{"x":-1451.6394,"y":-523.5562,"z":55.9290}'
									isSingle = 1
									isRoom = 1
									isGateway = 0      
								elseif Index == 5 then
									SetEntityCoords(GetPlayerPed(-1), -674.4503, 595.6156, 145.3796)
									ipl = '[]'
									inside = '{"x":-680.6088,"y":590.5321,"z":145.39}'
									exit = '{"x":-681.6273,"y":591.9663,"z":144.3930}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 6 then
									SetEntityCoords(GetPlayerPed(-1), 151.0994, -1007.8073, -98.9999)
									ipl = '["hei_hw1_blimp_interior_v_motel_mp_milo_"]'
									inside = '{"x":151.45,"y":-1007.57,"z":-98.9999}'
									exit = '{"x":151.3258,"y":-1007.7642,"z":-100.0000}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 7 then
									SetEntityCoords(GetPlayerPed(-1), 1026.8707, -3099.8710, -38.9998)
									ipl = '[]'
									inside = '{"x":1026.5056,"y":-3099.8320,"z":-38.9998}'
									exit   = '{"x":998.1795"y":-3091.9169,"z":-39.9999}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 8 then
									SetEntityCoords(GetPlayerPed(-1), 1072.8447, -3100.0390, -38.9999)
									ipl = '[]'
									inside = '{"x":1048.5067,"y":-3097.0817,"z":-38.9999}'
									exit   = '{"x":1072.5505,"y":-3102.5522,"z":-39.9999}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 9 then
									SetEntityCoords(GetPlayerPed(-1), 1104.7231, -3100.0690, -38.9999)
									ipl = '[]'
									inside = '{"x":1088.1834,"y":-3099.3547,"z":-38.9999}'
									exit   = '{"x":1104.6102,"y":-3099.4333,"z":-39.9999}'
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 10 then
									SetEntityCoords(GetPlayerPed(-1), 514.33, 4886.18, -62.59)
									ipl = '[]'
									inside = '{"x":514.3687,"y":4885.9448,"z":-62.590}'
									exit = '{"x":514.292,"y":4887.785,"z":-62.590}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 11 then
									SetEntityCoords(GetPlayerPed(-1), -1902.603, -573.016, 19.09)
									ipl = '[]'
									inside = '{"x":-1902.603,"y":-573.016,"z":19.09}'
									exit = '{"x":-1902.236,"y":-572.634,"z":19.09}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 12 then
									SetEntityCoords(GetPlayerPed(-1), -1520.95, -3002.184, -82.207)
									ipl = '[]'
									inside = '{"x":-1520.95,"y":-3002.184,"z":-82.207}'
									exit = '{"x":-1520.808,"y":-2978.501,"z":-80.453}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 13 then
									SetEntityCoords(GetPlayerPed(-1), -174.284, 497.640, 137.663)
									ipl = '[]'
									inside = '{"x":-173.977,"y":496.7333,"z":137.666}'
									exit = '{"x":-174.284,"y":497.640,"z":137.663}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 14 then
									SetEntityCoords(GetPlayerPed(-1), -718.76, 262.12, 83.1)
									print('Agence Immo')
								end
							else
								RageUI.Text({
									message = "~r~Mode Visite désactivé~s~ \nAction impossible",
									time_display = 5000
								})
							end
						end
					end)
					
					RageUI.ButtonWithStyle("Définir prix", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							price = OpenKeyboard('price', 'Entrer un prix')
						end
					end)

					RageUI.ButtonWithStyle("~r~Annuler", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							if PedPosition ~= nil then
								SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)
							end  
			 
							Citizen.Wait(50)
							RageUI.CloseAll()
							ESX.ShowNotification('~b~Création de propriété\n~s~Création annulée.')
						end
					end)

					RageUI.ButtonWithStyle("~g~Valider", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							if tonumber(price) == nil or tonumber(price) == 0 then
								ESX.ShowNotification('~r~Vous n\'avez aucun prix assigné !')
							else 
								if name == '' then 
									ESX.ShowNotification('~r~Vous n\'avez aucun nom assigné !')
								else 	
								   TriggerServerEvent('aPropertiesmenu:Save', name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, price)
							   
								   Citizen.Wait(15)
								   SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)
								end
							end   
							
							if debug then 
								print('Name'..name)
								print('ipl' ..ipl)
								print('label' ..label)
								print('entering' ..entering)
								print('inside' ..inside)
								print('roommenu' ..roommenu)
								print('exit' ..exit)
								print('outside' ..outside)
								print('price'..price)
								if garage ~= nil then 
									print('garage'..garage)
								end	   
							end  
						end
					end)
					
				end)
				Wait(0)
			end
		end)
	end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if IsControlJustPressed(0,344) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'realestateagent' then
			openPropertiesMenu() 
            RageUI.IsVisible(RMenu:Get('menu', 'main'), not RageUI.IsVisible(RMenu:Get('menu', 'main')))
        end
    end
end)





