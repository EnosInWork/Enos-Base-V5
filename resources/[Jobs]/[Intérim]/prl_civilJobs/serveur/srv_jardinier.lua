
local config = {
    Heading =279.0,
    pedHash = "s_m_m_gardener_01",
    AuTravailleJardinier = false,
    ArgentMin = 2,
    ArgentMax = 35,
}

local workzone = {
    {
        pos = vector3(-1285.259, 144.985, 58.30913),
        Heading = 185.89414978027,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
    {
        pos = vector3(-1221.565, 126.5285, 58.31039),
        Heading = 307.4296875,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
    {
        pos = vector3(-1164.854, 161.8388, 63.34848),
        Heading = 337.6379699707,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
    {
        pos = vector3(-1085.47, 118.8697, 59.06965),
        Heading = 91.725303649902,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
    {
        pos = vector3(-1079.786, 101.3815, 58.74107),
        Heading = 47.204990386963,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
    {
        pos = vector3(-1086.083, 88.50233, 56.43365),
        Heading = 29.01895904541,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
    {
        pos = vector3(-1089.475, 86.60812, 56.26409),
        Heading = 20.295095443726,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },

    {
        pos = vector3(-1172.939, 69.36817, 56.08248),
        Heading = 186.54618835449,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
    {
        pos = vector3(-1175.177, 62.14962, 55.27089),
        Heading = 274.15692138672,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },




    {
        pos = vector3(-1271.649, 125.3378, 57.7089),
        Heading = 255.12530517578,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
    {
        pos = vector3(-1196.044, 125.7478, 60.41936),
        Heading = 284.59030151367,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
    {
        pos = vector3(-1180.271, 171.2327, 63.69622),
        Heading = 178.75721740723,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
    {
        pos = vector3(-1146.694, 176.5815, 63.10544),
        Heading = 277.07141113281,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },

    {
        pos = vector3(-1156.889, 52.50682, 54.0273),
        Heading = 79.86287689209,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
    {
        pos = vector3(-1180.165, 12.37974, 49.70248),
        Heading = 40.883083343506,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
    {
        pos = vector3(-1198.765, 22.84433, 49.51952),
        Heading = 311.18786621094,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
}



local WorkerChillPos = {
    ped1 = {
        pos = vector3(-1342.128, 106.1473, 55.15339),
        Heading = 29.351299285889,
    },
    ped3 = {
        pos = vector3(-1349.7, 106.6977, 55.18651),
        Heading = 323.88757324219,
    },
    
}


local WorkerWorkingPos = {
    {
        pos = vector3(-1277.588, 139.2914, 57.24146),
        Heading = 67.615928649902,
        scenario = "WORLD_HUMAN_GARDENER_LEAF_BLOWER",
    },
    {
        pos = vector3(-1282.589, 133.2682, 56.79959),
        Heading = 43.779140472412,
        scenario = "WORLD_HUMAN_GARDENER_PLANT",
    },
}



RegisterNetEvent("RED_JOBS:JardinierAntiDump")
AddEventHandler("RED_JOBS:JardinierAntiDump", function()
    TriggerClientEvent("RED_JOBS:JardinierAntiDump", source, config, workzone, WorkerChillPos, WorkerWorkingPos)
end)
