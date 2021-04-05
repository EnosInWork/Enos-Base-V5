-- @desc Shared config file
-- @author Elio
-- @version 2.0

-- Global configuration
Config = {
    language = 'fr',
    color = { r = 245, g = 167, b = 66, a = 255 }, -- Text color
    font = 0, -- Text font
    time = 5000, -- Duration to display the text (in ms)
    scale = 0.5, -- Text scale
    dist = 250, -- Min. distance to draw 
}

-- Languages available
Languages = {
    ['en'] = {
        commandName = 'me',
        commandDescription = 'Display an action above your head.',
        commandSuggestion = {{ name = 'action', help = '"scratch his nose" for example.'}},
        prefix = 'the person '
    },
    ['fr'] = {
        commandName = 'me',
        commandDescription = 'Affiche une action au dessus de votre tête.',
        commandSuggestion = {{ name = 'action', help = '"se gratte le nez" par exemple.'}},
        prefix = ' '
    },
}

--------------------------------------------------- Fuel 

ConfFuel = {}

-- Are you using ESX? Turn this to true if you would like fuel & jerry cans to cost something.
ConfFuel.UseESX = true

-- What should the price of jerry cans be?
ConfFuel.JerryCanCost = 500
ConfFuel.RefillCost = 750 -- If it is missing half of it capacity, this amount will be divided in half, and so on.

-- Fuel decor - No need to change this, just leave it.
ConfFuel.FuelDecor = "_FUEL_LEVEL"

-- What keys are disabled while you're fueling.
ConfFuel.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}

-- Want to use the HUD? Turn this to true.
ConfFuel.EnableHUD = false

-- ConfFuelure blips here. Turn both to false to disable blips all together.
ConfFuel.ShowNearestGasStationOnly = false
ConfFuel.ShowAllGasStations = true

-- ConfFuelure the strings as you wish here.
ConfFuel.Strings = {
	ExitVehicle = "Sortez du véhicule pour faire le plein",
	EToRefuel = "Appuyez sur ~g~E~w~ pour faire le plein du véhicule",
	JerryCanEmpty = "Le Jerry Can est vide",
	FullTank = "Le réservoir est plein",
	PurchaseJerryCan = "Appuyez sur ~g~E~w~ pour acheter un jerrycan pour ~g~$" .. ConfFuel.JerryCanCost,
	CancelFuelingPump = "Appuyez sur ~g~E~w~ pour arrêter le ravitaillement en carburant",
	CancelFuelingJerryCan = "Appuyez sur ~g~E~w~ pour arrêter le ravitaillement en carburant",
	NotEnoughCash = "Pas assez d'argent liquide",
	RefillJerryCan = "Appuyez sur ~g~E~w~ pour recharger le jerrycan pour ",
	NotEnoughCashJerryCan = "Pas assez d'argent pour remplir le jerrycan",
	JerryCanFull = "Le Jerry Can est pleins",
	TotalCost = "Prix",
}

if not ConfFuel.UseESX then
	ConfFuel.Strings.PurchaseJerryCan = "Appuyez sur ~g~E~w~ pour prendre un jerrycan"
	ConfFuel.Strings.RefillJerryCan = "Appuyez sur ~g~E~w~ pour recharger le jerrycan"
end

ConfFuel.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
ConfFuel.Blacklist = {
	--"Adder",
	--276773164
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
ConfFuel.RemoveHUDForBlacklistedVehicle = true

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
ConfFuel.Classes = {
	[0] = 0.7, -- Compacts
	[1] = 0.7, -- Sedans
	[2] = 0.7, -- SUVs
	[3] = 0.7, -- Coupes
	[4] = 0.7, -- Muscle
	[5] = 0.7, -- Sports Classics
	[6] = 0.7, -- Sports
	[7] = 0.7, -- Super
	[8] = 0.7, -- Motorcycles
	[9] = 0.7, -- Off-road
	[10] = 0.7, -- Industrial
	[11] = 0.7, -- Utility
	[12] = 0.7, -- Vans
	[13] = 0.7, -- Cycles
	[14] = 0.7, -- Boats
	[15] = 0.7, -- Helicopters
	[16] = 0.7, -- Planes
	[17] = 0.7, -- Service
	[18] = 0.7, -- Emergency
	[19] = 0.7, -- Military
	[20] = 0.7, -- Commercial
	[21] = 0.7, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
ConfFuel.FuelUsage = {
	[1.0] = 1.2,
	[0.9] = 1.0,
	[0.8] = 0.9,
	[0.7] = 0.8,
	[0.6] = 0.7,
	[0.5] = 0.6,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.3,
	[0.1] = 0.2,
	[0.0] = 0.0,
}

ConfFuel.GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

