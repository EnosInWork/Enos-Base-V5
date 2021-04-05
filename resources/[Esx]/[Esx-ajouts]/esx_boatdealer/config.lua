-- ESX getter
trigger = "esx:getSharedObject"

-- Discord webhook
webhook = "putYourWebhookHere" -- CHANGE ME

-- Locales
menu_garage_separator_owned_vehicles = "Véhicules disponibles"
menu_garage_rightlabel_out = "Sortir"

menu_garage_title = "Concessionnaire Bateau"
menu_garage_subtitle = "~b~Sélectionnez votre véhicule"

menu_boatdealer_title = "Concessionnaire Bateau"
menu_boatdealer_subtitle = "~b~Faites votre choix"
menu_boatdealer_button_showVehicles = "Voir les véhicules disponibles"

msg_loading_server_synchronization = "En attente de la synchro. serveur..."
msg_loading_boatdealer_vehicles = "Chargement des véhicules..."
msg_awaiting_server_response = "~r~En attente d'une réponse du serveur"
msg_awaiting_server_infos = "Récupération des informations en cours..."
msg_loading_owned_boats = "Récupération de vos bateau..."
msg_boat_purchassed = "~g~Vous avez un nouveau véhicule !"
msg_not_vehicle_owner = "~r~Ce véhicule ne vous appartient pas !"
msg_no_enough_money = "~r~Vous n'avez pas assez d'argent"
msg_no_boats = "Vous n'avez pas de bateau"
msg_out_prefix = "[SORTI]"

blip_boatdealer = "Concessionnaire | Bateau"
blip_garage_out = "Garage"
blip_garage_back = "Garage"

help_open_boatdealer = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le concessionnaire bateau"
help_open_garage = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage bateau"
help_open_garage_back = "Appuyez sur ~INPUT_CONTEXT~ pour ranger votre vehicle"

-- boats dealer position
buy_marker = vector3(-1424.89, -1554.17, 2.05)
preview_position = vector3(-1419.63, -1573.52, 6.86)

-- boats garages
entry_points = {
    {
        open = vector3(-1404.06, -1619.17, 1.32),
        outPossibilites = {
            {
                pos = vector3(-1441.71, -1641.55, 2.54),
                heading = 121.4
            },

            {
                pos = vector3(-1472.96, -1571.5, 3.18),
                heading = 121.4
            }
        }
    }
}

returnb_points = {
    vector3(-1469.0, -1523.5, 0.10)
}