Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.MaxInService               = -1
Config.Locale                     = 'fr'


Config.baritem = {
    {nom = "Eau", prix = 5, item = "eau"},
    {nom = "Pain", prix = 5, item = "pain"},   
    {nom = "Bière", prix = 10, item = "biere"},   
    {nom = "Whisky", prix = 10, item = "whisky"},   
    {nom = "Vodka", prix = 10, item = "vodka"},   
    {nom = "Rhum", prix = 10, item = "rhum"},  
}


Config.pos = {

tpentrer = {
	position = {x = 132.58, y = -1294.04, z = 29.27}
},

tpsortie = {
	position = {x = 128.63, y = -1280.36, z = 29.27}
},

bar = {
	position = {x = 131.75, y = -1285.26, z = 29.27}
},
garagevoiture = {
    position = {x = 144.14, y = -1321.31, z = 29.23}
}
}

Config.garagevoiture = {
	{nom = "Nightshade", modele = "Nightshade"},
	{nom = "Asterope", modele = "Asterope"},
}

Config.spawn = {

	spawnvoiture = {
		position = {x = 139.06, y = -1323.88, z = 29.2, h = 67.07}
	}
}

