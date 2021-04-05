Config = {}

-- Language du menu
-- Menu language
Config.Locale = 'fr'

-- Location du spawn joueur après la création du personnage
-- Rental of player spawn after character creation
Config.PlayerSpawn = {x = -1042.635, y =-2745.828, z = 21.359, h = -30.0}

-- Name of parents for inheritance (Do not add / remove character, you can just replace them)
-- Nom des parents pour l'héritage (Ne pas ajouter / supprimer de personnage, vous pouvez juste les remplacés)
Config.MotherList = { "Hannah", "Aubrey", "Jasmine", "Gisele", "Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole", "Ashley", "Gracie", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma" }
Config.FatherList = { "Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony",  "Claude", "Niko" }

-- List of outfit
-- Liste des tenues
Config.Outfit = {
	{
		label = 'Sous-Vêtement',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {15, 0},
				decals = {0, 0},
				arms = {15, 0},
				pants = {61, 4},
				shoes = {34, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {15, 0},
				torso = {5, 0},
				decals = {0, 0},
				arms = {15, 0},
				pants = {57, 0},
				shoes = {35, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			}
		}
	},
	{
		label = 'Vagos',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {14, 1},
				decals = {0, 0},
				arms = {1, 0},
				pants = {42, 5},
				shoes = {8, 6},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {60, 0},
				torso = {35, 0},
				decals = {0, 0},
				arms = {5, 0},
				pants = {3, 8},
				shoes = {50, 0},
				chain = {90, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	},
	{
		label = 'Ballas',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {75, 6},
				decals = {0, 0},
				arms = {1, 0},
				pants = {86, 22},
				shoes = {8, 12},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {60, 0},
				torso = {65, 7},
				decals = {0, 0},
				arms = {6, 0},
				pants = {89, 22},
				shoes = {8, 11},
				chain = {90, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	},
	{
		label = 'Affaire',
		id = {
			male = {
				tshirt = {21, 0},
				torso = {29, 1},
				decals = {0, 0},
				arms = {12, 0},
				pants = {37, 2},
				shoes = {10, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {21, 2},
				torso = {58, 0},
				decals = {0, 0},
				arms = {6, 0},
				pants = {37, 0},
				shoes = {19, 13},
				chain = {90, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	},
	{
		label = 'Families',
		id = {
			male = {
				tshirt = {15, 0},
				torso = {128, 0},
				decals = {0, 0},
				arms = {0, 0},
				pants = {42, 6},
				shoes = {6, 0},
				chain = {0, 0},
				helmet = {-1, 0},
				glasses = {0, 0}
			},
			female = {
				tshirt = {60, 0},
				torso = {31, 1},
				decals = {0, 0},
				arms = {5, 0},
				pants = {45, 0},
				shoes = {1, 8},
				chain = {36, 0},
				helmet = {-1, 0},
				glasses = {0, 0}	
			}
		}
	}
}