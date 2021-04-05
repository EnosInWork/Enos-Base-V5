
local config = {
    Heading = 85.79,
    pedHash = "s_m_y_construct_01",
    AuTravailleChantier = false,
    ArgentMin = 2,
    ArgentMax = 32,
}

local workzone = {
    {
        pos = vector3(-487.0, -986.95, 28.13),
        Heading = 273.2,
        scenario = "WORLD_HUMAN_WELDING",
    },
    {
        pos = vector3(-483.987, -986.7827, 28.13171),
        Heading = 90.383460998535,
        scenario = "WORLD_HUMAN_WELDING",
    },
    {
        pos = vector3(-482.7948, -995.856, 28.13281),
        Heading = 95.914886474609,
        scenario = "WORLD_HUMAN_WELDING",
    },
    {
        pos = vector3(-492.5294, -1005.513, 28.13171),
        Heading = 99.648864746094,
        scenario = "WORLD_HUMAN_WELDING",
    },


    {
        pos = vector3(-449.08, -998.68, 22.96),
        Heading = 268.47,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-464.5076, -1000.148, 22.71595),
        Heading = 3.7162296772003,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-465.889, -998.6741, 22.69423),
        Heading = 270.44155883789,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-464.4124, -997.1024, 22.71765),
        Heading = 184.32759094238,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-447.649, -997.1122, 22.98477),
        Heading = 181.08190917969,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-446.2953, -998.5501, 22.00837),
        Heading = 100.51464080811,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    {
        pos = vector3(-447.7392, -1000.15, 22.98311),
        Heading = 359.67852783203,
        scenario = "WORLD_HUMAN_HAMMERING",
    },


    {
        pos = vector3(-452.71, -1005.6, 22.94),
        Heading = 293.07,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
    {
        pos = vector3(-447.183, -1002.664, 22.992),
        Heading = 125.80912780762,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
    {
        pos = vector3(-449.1005, -1006.923, 22.96139),
        Heading = 24.118503570557,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
}



local WorkerChillPos = {
    ped1 = {
        pos = vector3(-517.21, -1010.1, 22.45),
        Heading = 52.55,
    },
    ped2 = {
        pos = vector3(-519.15, -1008.78, 22.37),
        Heading = 228.22,
    },
    ped3 = {
        pos = vector3(-511.11, -1006.96, 22.55),
        Heading = 353.89,
    },
    ped4 = {
        pos = vector3(-510.7, -1004.62, 22.55),
        Heading = 168.35,
    },
    
}


local WorkerWorkingPos = {
    ped1 = {
        pos = vector3(-482.87, -985.45, 28.13),
        Heading = 90.93,
        scenario = "WORLD_HUMAN_WELDING",
    },
    ped2 = {
        pos = vector3(-494.18, -984.56, 28.13),
        Heading = 181.04,
        scenario = "WORLD_HUMAN_WELDING",
    },
    ped3 = {
        pos = vector3(-462.95, -998.48, 22.74),
        Heading = 90.48,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    ped4 = {
        pos = vector3(-447.86, -1015.17, 22.99),
        Heading = 176.85,
        scenario = "WORLD_HUMAN_HAMMERING",
    },
    ped5 = {
        pos = vector3(-450.17, -1002.06, 23.11),
        Heading = 191.62,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
    ped6 = {
        pos = vector3(-447.62, -1005.67, 23.03),
        Heading = 52.82,
        scenario = "WORLD_HUMAN_CONST_DRILL",
    },
}



RegisterNetEvent("RED_JOBS:ChantierAntiDump")
AddEventHandler("RED_JOBS:ChantierAntiDump", function()
    TriggerClientEvent("RED_JOBS:ChantierAntiDump", source, config, workzone, WorkerChillPos, WorkerWorkingPos)
end)
