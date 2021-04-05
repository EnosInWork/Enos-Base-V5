Config = {}

cfg = {
	deformationMultiplier = -1,
	deformationExponent = 0.4,
	collisionDamageExponent = 0.6,

	damageFactorEngine = 10.0,
	damageFactorBody = 10.0,
	damageFactorPetrolTank = 64.0,
	engineDamageExponent = 0.6,
	weaponsDamageMultiplier = 0.01,
	degradingHealthSpeedFactor = 10,
	cascadingFailureSpeedFactor = 8.0,

	degradingFailureThreshold = 800.0,
	cascadingFailureThreshold = 360.0,
	engineSafeGuard = 100.0,

	torqueMultiplierEnabled = true,	

	limpMode = false,
	limpModeMultiplier = 0.15,

	preventVehicleFlip = true,

	sundayDriver = true,						-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
	sundayDriverAcceleratorCurve = 7.5,			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
	sundayDriverBrakeCurve = 5.0,				-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

	displayBlips = false,

	compatibilityMode = false,

	randomTireBurstInterval = 120,


	classDamageMultiplier = {
		[0] = 	1.0,		--	0: Compacts
				1.0,		--	1: Sedans
				1.0,		--	2: SUVs
				1.0,		--	3: Coupes
				1.0,		--	4: Muscle
				1.0,		--	5: Sports Classics
				1.0,		--	6: Sports
				1.0,		--	7: Super
				0.25,		--	8: Motorcycles
				0.7,		--	9: Off-road
				0.25,		--	10: Industrial
				1.0,		--	11: Utility
				1.0,		--	12: Vans
				1.0,		--	13: Cycles
				0.5,		--	14: Boats
				1.0,		--	15: Helicopters
				1.0,		--	16: Planes
				1.0,		--	17: Service
				0.75,		--	18: Emergency
				0.75,		--	19: Military
				1.0,		--	20: Commercial
				1.0			--	21: Trains
	}
}

repairCfg = {
	mechanics = {
		{name="Mechanic", id=446, r=25.0, x=-337.0,  y=-135.0,  z=39.0},	-- LSC Burton
		{name="Mechanic", id=446, r=25.0, x=-1155.0, y=-2007.0, z=13.0},	-- LSC by airport
		{name="Mechanic", id=446, r=25.0, x=734.0,   y=-1085.0, z=22.0},	-- LSC La Mesa
		{name="Mechanic", id=446, r=25.0, x=1177.0,  y=2640.0,  z=37.0},	-- LSC Harmony
		{name="Mechanic", id=446, r=25.0, x=108.0,   y=6624.0,  z=31.0},	-- LSC Paleto Bay
		{name="Mechanic", id=446, r=18.0, x=538.0,   y=-183.0,  z=54.0},	-- Mechanic Hawic
		{name="Mechanic", id=446, r=15.0, x=1774.0,  y=3333.0,  z=41.0},	-- Mechanic Sandy Shores Airfield
		{name="Mechanic", id=446, r=15.0, x=1143.0,  y=-776.0,  z=57.0},	-- Mechanic Mirror Park
		{name="Mechanic", id=446, r=30.0, x=2508.0,  y=4103.0,  z=38.0},	-- Mechanic East Joshua Rd.
		{name="Mechanic", id=446, r=16.0, x=2006.0,  y=3792.0,  z=32.0},	-- Mechanic Sandy Shores gas station
		{name="Mechanic", id=446, r=25.0, x=484.0,   y=-1316.0, z=29.0},	-- Hayes Auto, Little Bighorn Ave.
		{name="Mechanic", id=446, r=33.0, x=-1419.0, y=-450.0,  z=36.0},	-- Hayes Auto Body Shop, Del Perro
		{name="Mechanic", id=446, r=33.0, x=268.0,   y=-1810.0, z=27.0},	-- Hayes Auto Body Shop, Davis
		{name="Mechanic", id=446, r=27.0, x=1915.0,  y=3729.0,  z=32.0},	-- Otto's Auto Parts, Sandy Shores
		{name="Mechanic", id=446, r=45.0, x=-29.0,   y=-1665.0, z=29.0},	-- Mosley Auto Service, Strawberry
		{name="Mechanic", id=446, r=44.0, x=-212.0,  y=-1378.0, z=31.0},	-- Glass Heroes, Strawberry
		{name="Mechanic", id=446, r=33.0, x=258.0,   y=2594.0,  z=44.0},	-- Mechanic Harmony
		{name="Mechanic", id=446, r=18.0, x=-32.0,   y=-1090.0, z=26.0},	-- Simeons
		{name="Mechanic", id=446, r=25.0, x=-211.0,  y=-1325.0, z=31.0},	-- Bennys
		{name="Mechanic", id=446, r=25.0, x=903.0,   y=3563.0,  z=34.0},	-- Auto Repair, Grand Senora Desert
		{name="Mechanic", id=446, r=25.0, x=437.0,   y=3568.0,  z=38.0}		-- Auto Shop, Grand Senora Desert
	},

	fixMessages = {
		"You put the oil plug back in",
		"You stopped the oil leak using chewing gum",
		"You repaired the oil tube with gaffer tape",
		"You tightened the oil pan screw and stopped the dripping",
		"You kicked the engine and it magically came back to life",
		"You removed some rust from the spark tube",
		"You yelled at your vehicle, and it somehow had an effect"
	},
	fixMessageCount = 7,

	noFixMessages = {
		"You checked the oil plug. It's still there",
		"You looked at your engine, it seemed fine",
		"You made sure that the gaffer tape was still holding the engine together",
		"You turned up the radio volume. It just drowned out the weird engine noises",
		"You added rust-preventer to the spark tube. It made no difference",
		"Never fix something that ain't broken they said. You didn't listen. At least it didn't get worse"
	},
	noFixMessageCount = 6
}

RepairEveryoneWhitelisted = false
RepairWhitelist =
{
	"steam:11000011cbdc6c7"
}