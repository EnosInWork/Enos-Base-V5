Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'custom' -- 'en', 'sv' or 'custom'

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1222.82, -908.94, 12.32-0.98), heading = 32.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-46.65, -1757.91, 29.42-0.98), heading = 52.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1134.08, -982.72, 46.41-0.98), heading = 276.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1165.02, -323.87, 69.20-0.98), heading = 97.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1486.57, -377.62, 40.16-0.98), heading = 139.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1819.10, 793.05, 138.08-0.98), heading = 140.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-2966.35, 391.30, 15.04-0.98), heading = 88.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-3040.79, 583.97, 7.90-0.98), heading = 11.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-3244.24, 1000.17, 12.83-0.98), heading = 354.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(549.30, 2669.45, 42.15-0.98), heading = 94.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(2676.40, 3280.25, 55.24-0.98), heading = 337.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1959.10, 3741.63, 32.34-0.98), heading = 295.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1696.90, 4923.60, 42.06-0.98), heading = 330.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1728.71, 6417.05, 35.03-0.98), heading = 243.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1165.52, 2710.78, 38.15-0.98), heading = 191.0, money = {7500, 10000}, cops = 2, blip = false, name = 'Braquage Superette', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false}

}   

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'shopkeeper',
        ['robbed'] = "I was just robbed and ~r~don't ~w~have any money left!",
        ['cashrecieved'] = 'You got:',
        ['currency'] = '€',
        ['scared'] = 'Scared:',
        ['no_cops'] = 'There are ~r~not~w~ enough cops online!',
        ['cop_msg'] = 'We have sent a photo of the robber taken by the CCTV camera!',
        ['set_waypoint'] = 'Set waypoint to the store',
        ['hide_box'] = 'Close this box',
        ['robbery'] = 'Robbery in progress',
        ['walked_too_far'] = 'You walked too far away!'
    },
    ['sv'] = {
        ['shopkeeper'] = 'butiksbiträde',
        ['robbed'] = 'Jag blev precis rånad och har inga pengar kvar!',
        ['cashrecieved'] = 'Du fick:',
        ['currency'] = 'SEK',
        ['scared'] = 'Rädd:',
        ['no_cops'] = 'Det är inte tillräckligt med poliser online!',
        ['cop_msg'] = 'Vi har skickat en bild på rånaren från övervakningskamerorna!',
        ['set_waypoint'] = 'Sätt GPS punkt på butiken',
        ['hide_box'] = 'Stäng denna rutan',
        ['robbery'] = 'Pågående butiksrån',
        ['walked_too_far'] = 'Du gick för långt bort!'
    },
    ['custom'] = { -- edit this to your language
        ['shopkeeper'] = 'Commerçant',
        ['robbed'] = 'On vient de me voler et je ~r~n\'ai plus ~w~d\'argent !',
        ['cashrecieved'] = 'Vous avez :',
        ['currency'] = '€',
        ['scared'] = 'Effrayé :',
        ['no_cops'] = 'Il n\'y a ~r~pas~w~ assez de flics en ligne !',
        ['cop_msg'] = 'Nous avons envoyé une photo du voleur prise par la caméra de vidéosurveillance !',
        ['set_waypoint'] = 'Définir le waypoint jusqu\'au magasin',
        ['hide_box'] = 'Fermer cette boîte',
        ['robbery'] = 'Braquage en cours',
        ['walked_too_far'] = 'Tu es parti trop loin !'
    }
}