ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RMenu.Add('location', 'main', RageUI.CreateMenu("Location", "Location"))

local InCam = false
local CarPrev
local SelectedCarPrev

CreateThread(function()
    while true do
        Wait(1)
        local Distance = Vdist2(GetEntityCoords(GetPlayerPed(-1)), -1044.04, -2673.58, 13.83)
        if Distance < 500.0 then
            if Distance < 10.0 then
                AddTextEntry("HELP", "Appuyer sur ~INPUT_PICKUP~ pour parler avec la personne.")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 38) then
                    RageUI.Visible(RMenu:Get('location', 'main'), true)
                    InCam = true
                    GarageCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1035.04, -2666.01, 17.50, -20.0, 0.0, 100.0, 40.00, false, 0)
                    SetCamActive(GarageCam, true)
                    RenderScriptCams(true, true, 1500, true, true) 
                    local IsLocMenuOpen = true
                    while IsLocMenuOpen do
                        Wait(1)
                        if not RageUI.Visible(RMenu:Get('location', 'main')) then
                            IsLocMenuOpen = false
                            InCam = false
                            SetCamActive(GarageCam, false)
                            RenderScriptCams(false, true, 500, true, true) 
                            DestroyCam(GarageCam)
                            GarageCam = nil
                            if DoesEntityExist(CarPrev) then
                                DeleteEntity(CarPrev)
                            end
                            SelectedCarPrev = nil
                        end

                        RageUI.IsVisible(RMenu:Get('location', 'main'), true, true, true, function()

                            RageUI.ButtonWithStyle("Panto", " ", { RightLabel = "~h~~g~500$" }, true, function(_, Active, Selected)
                                if Active and SelectedCarPrev ~= 1 then
                                    SelectedCarPrev = 1
                                    if DoesEntityExist(CarPrev) then
                                        DeleteEntity(CarPrev)
                                    end
                                    while not HasModelLoaded(GetHashKey("panto")) do
                                        RequestModel(GetHashKey("panto"))
                                        Wait(100)
                                    end
                                    CarPrev = CreateVehicle(GetHashKey("panto"), -1047.62, -2669.05, 14.570, 321.0, false)
                                end
                                if Selected then
                                            if DoesEntityExist(CarPrev) then
                                                DeleteEntity(CarPrev)
                                            end
                                            while not HasModelLoaded(GetHashKey("panto")) do
                                                RequestModel(GetHashKey("panto"))
                                                Wait(100)
                                            end
                                            local FinalCar = CreateVehicle(GetHashKey("panto"), -1047.62, -2669.05, 14.570, 321.0, true)
                                            RageUI.Popup({
                                                colors = 140,
                                                message = "Véhicule de location sortie. Soit prudent sur la route. ~r~(-500$)",
                                            })
                                            TriggerServerEvent('buy:buy')                            
                                        RageUI:GoBack()
                                    else
                                end
                            end)
                            RageUI.ButtonWithStyle("Blista", " ", { RightLabel = "~h~~g~500$" }, true, function(_, Active, Selected)
                                if Active and SelectedCarPrev ~= 3 then
                                    SelectedCarPrev = 3
                                    if DoesEntityExist(CarPrev) then
                                        DeleteEntity(CarPrev)
                                    end
                                    while not HasModelLoaded(GetHashKey("blista")) do
                                        RequestModel(GetHashKey("blista"))
                                        Wait(100)
                                    end
                                    CarPrev = CreateVehicle(GetHashKey("blista"), -1047.62, -2669.05, 14.570, 321.0, false)
                                end
                                if Selected then
                                            if DoesEntityExist(CarPrev) then
                                                DeleteEntity(CarPrev)
                                            end
                                            while not HasModelLoaded(GetHashKey("blista")) do
                                                RequestModel(GetHashKey("blista"))
                                                Wait(100)
                                            end
                                            local FinalCar = CreateVehicle(GetHashKey("blista"), -1047.62, -2669.05, 14.570, 321.0, true)
                                            RageUI.Popup({
                                                colors = 140,
                                                message = "Véhicule de location sortie. Soit prudent sur la route. (-500$)",
                                            })
                                            TriggerServerEvent('buy:buy') 
                                        RageUI:GoBack()
                                    else
                                end
                            end)
                            RageUI.ButtonWithStyle("Faggio", " ", { RightLabel = "~h~~g~500$" }, true, function(_, Active, Selected)
                                if Active and SelectedCarPrev ~= 1 then
                                    SelectedCarPrev = 1
                                    if DoesEntityExist(CarPrev) then
                                        DeleteEntity(CarPrev)
                                    end
                                    while not HasModelLoaded(GetHashKey("faggio")) do
                                        RequestModel(GetHashKey("faggio"))
                                        Wait(100)
                                    end
                                    CarPrev = CreateVehicle(GetHashKey("faggio"), -1047.62, -2669.05, 14.570, 321.0, false)
                                end
                                if Selected then
                                            if DoesEntityExist(CarPrev) then
                                                DeleteEntity(CarPrev)
                                            end
                                            while not HasModelLoaded(GetHashKey("faggio")) do
                                                RequestModel(GetHashKey("faggio"))
                                                Wait(100)
                                            end
                                            local FinalCar = CreateVehicle(GetHashKey("faggio"), -1047.62, -2669.05, 14.570, 321.0, true)
                                            RageUI.Popup({
                                                colors = 140,
                                                message = "Véhicule de location sortie. Soit prudent sur la route. (-500$)",
                                            })
                                            TriggerServerEvent('buy:buy')                               
                                        RageUI:GoBack()
                                    else
                                end
                            end)
                        end)
                    end
                end
            end
        else
            Wait(5000)
        end
    end
end)

--------- PED & BLIPS -----------

DecorRegister("Yay", 4)
pedHash = "s_m_m_security_01"
zone = vector3(-1045.87, -2675.84, 12.83)
Heading = 315.00
Ped = nil
HeadingSpawn = 315.00

Citizen.CreateThread(function()
    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
    DecorSetInt(Ped, "Yay", 5431)
    FreezeEntityPosition(Ped, 1)
    TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)

    local blip = AddBlipForCoord(zone)
    SetBlipSprite(blip, 198)
    SetBlipScale(blip, 0.90)
    SetBlipShrink(blip, true)
    SetBlipColour(blip, 11)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Location | Voiture")
    EndTextCommandSetBlipName(blip)
    end)

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end