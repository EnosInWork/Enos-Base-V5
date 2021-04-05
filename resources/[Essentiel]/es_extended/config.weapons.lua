Config.Weapons = {

	{
		name = 'WEAPON_KNIFE',
		label = _U('weapon_knife'),
		components = {}
	},

	{
		name = 'WEAPON_NIGHTSTICK',
		label = _U('weapon_nightstick'),
		components = {}
	},

	{
		name = 'WEAPON_HAMMER',
		label = _U('weapon_hammer'),
		components = {}
	},

	{
		name = 'WEAPON_BAT',
		label = _U('weapon_bat'),
		components = {}
	},

	{
		name = 'WEAPON_GOLFCLUB',
		label = _U('weapon_golfclub'),
		components = {}
	},

	{
		name = 'WEAPON_CROWBAR',
		label = _U('weapon_crowbar'),
		components = {}
	},

	{
		name = 'WEAPON_PISTOL',
		label = _U('weapon_pistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = _U('weapon_combatpistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = _U('weapon_appistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = _U('weapon_pistol50'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_REVOLVER',
		label = _U('weapon_revolver'),
		components = {}
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = _U('weapon_snspistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = _U('weapon_heavypistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = _U('weapon_vintagepistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = _U('weapon_microsmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_SMG',
		label = _U('weapon_smg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SMG_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SMG_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = _U('weapon_assaultsmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = _U('weapon_minismg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_02') }
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = _U('weapon_machinepistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = _U('weapon_combatpdw'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') }
		}
	},
	
	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = _U('weapon_pumpshotgun'),
		components = {
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_SR_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = _U('weapon_sawnoffshotgun'),
		components = {
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = _U('weapon_assaultshotgun'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = _U('weapon_bullpupshotgun'),
		components = {
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = _U('weapon_heavyshotgun'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = _U('weapon_assaultrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = _U('weapon_carbinerifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02') },
			{ name = 'clip_box', label = _U('component_clip_box'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = _U('weapon_advancedrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = _U('weapon_specialcarbine'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = _U('weapon_bullpuprifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW') }
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = _U('weapon_compactrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03') }
		}
	},

	{
		name = 'WEAPON_MG',
		label = _U('weapon_mg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MG_CLIP_02') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = _U('weapon_combatmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = _U('weapon_gusenberg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02') },
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = _U('weapon_sniperrifle'),
		components = {
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
			{ name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = _U('weapon_heavysniper'),
		components = {
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
			{ name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') }
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = _U('weapon_marksmanrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_GRENADELAUNCHER',
		label = _U('weapon_grenadelauncher'),
		components = {}
	},

	{
		name = 'WEAPON_RPG',
		label = _U('weapon_rpg'),
		components = {}
	},

	{
		name = 'WEAPON_STINGER',
		label = _U('weapon_stinger'),
		components = {}
	},

	{
		name = 'WEAPON_MINIGUN',
		label = _U('weapon_minigun'),
		components = {}
	},

	{
		name = 'WEAPON_GRENADE',
		label = _U('weapon_grenade'),
		components = {}
	},

	{
		name = 'WEAPON_STICKYBOMB',
		label = _U('weapon_stickybomb'),
		components = {}
	},

	{
		name = 'WEAPON_SMOKEGRENADE',
		label = _U('weapon_smokegrenade'),
		components = {}
	},

	{
		name = 'WEAPON_BZGAS',
		label = _U('weapon_bzgas'),
		components = {}
	},

	{
		name = 'WEAPON_MOLOTOV',
		label = _U('weapon_molotov'),
		components = {}
	},

	{
		name = 'WEAPON_FIREEXTINGUISHER',
		label = _U('weapon_fireextinguisher'),
		components = {}
	},

	{
		name = 'WEAPON_PETROLCAN',
		label = _U('weapon_petrolcan'),
		components = {}
	},

	{
		name = 'WEAPON_DIGISCANNER',
		label = _U('weapon_digiscanner'),
		components = {}
	},

	{
		name = 'WEAPON_BALL',
		label = _U('weapon_ball'),
		components = {}
	},

	{
		name = 'WEAPON_BOTTLE',
		label = _U('weapon_bottle'),
		components = {}
	},

	{
		name = 'WEAPON_DAGGER',
		label = _U('weapon_dagger'),
		components = {}
	},

	{
		name = 'WEAPON_FIREWORK',
		label = _U('weapon_firework'),
		components = {}
	},

	{
		name = 'WEAPON_MUSKET',
		label = _U('weapon_musket'),
		components = {}
	},

	{
		name = 'WEAPON_STUNGUN',
		label = _U('weapon_stungun'),
		components = {}
	},

	{
		name = 'WEAPON_HOMINGLAUNCHER',
		label = _U('weapon_hominglauncher'),
		components = {}
	},

	{
		name = 'WEAPON_PROXMINE',
		label = _U('weapon_proxmine'),
		components = {}
	},

	{
		name = 'WEAPON_SNOWBALL',
		label = _U('weapon_snowball'),
		components = {}
	},

	{
		name = 'WEAPON_FLAREGUN',
		label = _U('weapon_flaregun'),
		components = {}
	},

	{
		name = 'WEAPON_GARBAGEBAG',
		label = _U('weapon_garbagebag'),
		components = {}
	},

	{
		name = 'WEAPON_HANDCUFFS',
		label = _U('weapon_handcuffs'),
		components = {}
	},

	{
		name = 'WEAPON_MARKSMANPISTOL',
		label = _U('weapon_marksmanpistol'),
		components = {}
	},

	{
		name = 'WEAPON_KNUCKLE',
		label = _U('weapon_knuckle'),
		components = {}
	},

	{
		name = 'WEAPON_HATCHET',
		label = _U('weapon_hatchet'),
		components = {}
	},

	{
		name = 'WEAPON_RAILGUN',
		label = _U('weapon_railgun'),
		components = {}
	},

	{
		name = 'WEAPON_MACHETE',
		label = _U('weapon_machete'),
		components = {}
	},

	{
		name = 'WEAPON_SWITCHBLADE',
		label = _U('weapon_switchblade'),
		components = {}
	},

	{
		name = 'WEAPON_DBSHOTGUN',
		label = _U('weapon_dbshotgun'),
		components = {}
	},

	{
		name = 'WEAPON_AUTOSHOTGUN',
		label = _U('weapon_autoshotgun'),
		components = {}
	},

	{
		name = 'WEAPON_BATTLEAXE',
		label = _U('weapon_battleaxe'),
		components = {}
	},

	{
		name = 'WEAPON_COMPACTLAUNCHER',
		label = _U('weapon_compactlauncher'),
		components = {}
	},

	{
		name = 'WEAPON_PIPEBOMB',
		label = _U('weapon_pipebomb'),
		components = {}
	},

	{
		name = 'WEAPON_POOLCUE',
		label = _U('weapon_poolcue'),
		components = {}
	},

	{
		name = 'WEAPON_WRENCH',
		label = _U('weapon_wrench'),
		components = {}
	},

	{
		name = 'WEAPON_FLASHLIGHT',
		label = _U('weapon_flashlight'),
		components = {}
	},

	{
		name = 'GADGET_NIGHTVISION',
		label = _U('gadget_nightvision'),
		components = {}
	},

	{
		name = 'GADGET_PARACHUTE',
		label = _U('gadget_parachute'),
		components = {}
	},

	{
		name = 'WEAPON_FLARE',
		label = _U('weapon_flare'),
		components = {}
	},

	{
		name = 'WEAPON_DOUBLEACTION',
		label = _U('weapon_doubleaction'),
		components = {}
	}

}
