Config                            = {}
Config.Locale                     = 'fr'

Config.DrawDistance               = 15

Config.Marker                     = {type = 21, x = 1.0, y = 1.0, z = 0.5, r = 173, g = 39, b = 142, a = 100, rotate = false}
Config.EnablePlayerManagement     = true 



Config.Zones = {

    Actions = {
        vector3(-1900.05, 2060.89, 140.89)
    },
    
    Boss = {
        vector3(-1912.21, 2073.41, 140.39)
    },

    Harv = {
		vector3(-1803.69, 2214.42, 91.43)
    },
    
    Craft = {
        vector3(-51.86, 1911.27, 195.36)
    },
    Sell = {
        vector3(359.38, -1109.02, 29.41)
    },

	Cloakroom = {
		vector3(-1911.58, 2074.02, 140.39)
	},

	Garage = {
		vector3(-1919.97, 2052.96, 140.74)
    }
}


-- Autres 

Vigne = {


    clothes = {


        specials = {


            [0] = {
                label = "Reprendre ça tenue civil",
                minimum_grade = 0,
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('vuzireee_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },

            [1] = {
                label = "Prendre un sac",
                minimum_grade = 0,
                variations = {
                    male = {
						['bags_1'] = 44,   ['bags_2'] = 0
                    },
                    female = {
						['bags_1'] = 44,   ['bags_2'] = 0
                    }
                },
                onEquip = function()
                    
                end
            }
        },

        grades = {

            [0] = {
                label = "Tenue Vigne",
                minimum_grade = 0,
                variations = {
                male = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 15, ['tshirt_2'] = 2,
                    ['torso_1'] = 65, ['torso_2'] = 2,
                    ['arms'] = 31,
                    ['pants_1'] = 38, ['pants_2'] = 2,
                    ['shoes_1'] = 12, ['shoes_2'] = 6,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['chain_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                },
                female = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 15,['tshirt_2'] = 2,
                    ['torso_1'] = 65, ['torso_2'] = 2,
                    ['arms'] = 36, ['arms_2'] = 0,
                    ['pants_1'] = 38, ['pants_2'] = 2,
                    ['shoes_1'] = 12, ['shoes_2'] = 6,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['chain_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                }
            },
            onEquip = function()
                
            end
        },
    }
    },

    vehicles = {
        car = {
            {category = "↓ ~b~Véhicules ~s~↓"},
            {model = "Speedo", label = "Véhicule de Travail", minimum_grade = 0},
        },
    }
}

