DecorRegister("Yay", 4)
Heading = 291.3
pedHash = "a_f_y_business_02"


zone = {
    Lifeinveders = vector3(-268.75, -962.48, 30.22313),
    Chantier = vector3(-509.94, -1001.59, 22.55),
    Jardinier = vector3(-1347.78, 113.09, 55.37),
    mine = vector3(2831.689, 2798.311, 56.49803),
    bucheron = vector3(-570.853, 5367.214, 69.21643),
}

local travailleZone = {
    {
        zone = vector3(-509.94, -1001.59, 22.55),
        nom = "Chantier",
        blip = 175,
        couleur = 44,
    },
    {
        zone = vector3(-1347.78, 113.09, 55.37),
        nom = "Golf",
        blip = 109,
        couleur = 43,
    },
    {
        zone = vector3(2831.689, 2798.311, 56.49803),
        nom = "Mine",
        blip = 477,
        couleur = 70,
    },
    {
        zone = vector3(-570.853, 5367.214, 70.21643),
        nom = "Bucheron",
        blip = 477,
        couleur = 21,
    },
    
}


Citizen.CreateThread(function()
    LoadModel(pedHash)
    local ped = CreatePed(2, GetHashKey(pedHash), zone.Lifeinveders, Heading, 0, 0)
    DecorSetInt(ped, "Yay", 5431)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, 1)

    local blip = AddBlipForCoord(zone.Lifeinveders)
    SetBlipSprite(blip, 590)
    SetBlipScale(blip, 0.7)
    SetBlipShrink(blip, true)
    SetBlipColour(blip, 11)

    for k,v in pairs(travailleZone) do
        local blip = AddBlipForCoord(v.zone)
        SetBlipSprite(blip, v.blip)
        SetBlipScale(blip, 0.7)
        SetBlipShrink(blip, true)
        SetBlipColour(blip, v.couleur)
        SetBlipAsShortRange(blip, true)


        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.nom)
        EndTextCommandSetBlipName(blip)
    end

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Pôle Emploi")
    EndTextCommandSetBlipName(blip)
end)


function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(100)
    end
end