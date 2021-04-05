--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 0



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
    lsd = 1,
    coke = 1,
    fish = 1,
    meth = 1,
    marijuana = 70,
    cannabis = 70,
    wood = 1,
    fishd = 1,
    opium = 1,
    stone = 1,
    petrol = 1,
    essence = 1,
    gitanes = 1,
    malbora = 1,
    tabacbrun = 1,
    tabacblond = 1,
    alive_chicken = 1,
    cutted_wood = 2,
    tabacbrunsec = 2, 
    washed_stone = 2,
    petrol_raffin = 2,
    tabacblondsec = 2,
    slaughtered_chicken = 2,
    packaged_chicken = 1,
    bandage = 2,
    fixkit = 2,
    fixtool = 2,
    gazbottle = 2,
    lsd_pooch = 2,
    coke_pooch = 2,
    meth_pooch = 2,
    opium_pooch = 2,
    weed_pooch = 2,
    carokit = 2,
    medkit = 2,
    blowpipe = 2,
    iron = 11,
    gold = 11,
    diamons = 11,
    cooper = 1,
    raisin = 10,
    jus_raisin = 20,
    grand_cru = 20,
    vine = 20,
    fishandchips = 2,
    fish = 1,
    pain = 1,
    eau = 1,
}


Config.VehicleLimit = {
    [0] = 50, --Compact             -3
    [1] = 40, --Sedan               -3
    [2] = 60, --SUV                 -4
    [3] = 40, --Coupes              -2
    [4] = 40, --Muscle              -2
    [5] = 40, --Sports Classics     -2
    [6] = 40, --Sports              -2
    [7] = 40, --Super               -2
    [8] = 0, --Motorcycles
    [9] = 45, --Off-road            -3
    [10] = 100, --Industrial         -5
    [11] = 70000, --Utility            -3
    [12] = 70000, --Vans               -2
    [13] = 0, --Cycles
    [14] = 60, --Boats              -5
    [15] = 40, --Helicopters        -2
    [16] = 0, --Planes
    [17] = 100, --Service            -5
    [18] = 100, --Emergency          -5
    [19] = 0, --Military
    [20] = 100, --Commercial         -5
    [21] = 0, --Trains
}
Config.VehiclePlate = {
	taxi        = "TAXI",
	cop         = "LSPD",
	ambulance   = "EMS0",
	mecano	    = "MECA",
}
