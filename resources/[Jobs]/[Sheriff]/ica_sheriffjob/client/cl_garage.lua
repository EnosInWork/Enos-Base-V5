ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RMenu.Add('garagesheriff', 'main', RageUI.CreateMenu("Garage", "Garage du SHERIFF"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('garagesheriff', 'main'), true, true, true, function() 

            RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if dist4 < 4 then
                DeleteEntity(veh)
                RageUI.CloseAll()
            end 
        end
    end) 

            if ESX.PlayerData.job.grade_name == 'recruit' or ESX.PlayerData.job.grade_name == 'officer' or ESX.PlayerData.job.grade_name == 'sergeant' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then 
                    RageUI.ButtonWithStyle("Chevrolet - Cadet", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then
                    Citizen.Wait(1)  
                    spawnuniCar("sheriff8")
                    RageUI.CloseAll()
                    end
                end)
            end

            if ESX.PlayerData.job.grade_name == 'officer' or ESX.PlayerData.job.grade_name == 'sergeant' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then 

                RageUI.ButtonWithStyle("Dodge - Officier", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then
                Citizen.Wait(1)  
                spawnuniCar("sheriff2")
                RageUI.CloseAll()
                end
            end)
        end


        if ESX.PlayerData.job.grade_name == 'sergeant' or ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then 

                RageUI.ButtonWithStyle("Ford Interceptor - Sergent", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then
                Citizen.Wait(1)  
                spawnuniCar("sheriff3")
                RageUI.CloseAll()
                end
            end)

                RageUI.ButtonWithStyle("Moto - Sergent", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then
                Citizen.Wait(1)  
                spawnuniCar("sheriffb")
                RageUI.CloseAll()
                end
            end)
        end

        if ESX.PlayerData.job.grade_name == 'lieutenant' or ESX.PlayerData.job.grade_name == 'boss' then 

            RageUI.ButtonWithStyle("Lieutenant - VIR", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then
                Citizen.Wait(1)  
                spawnuniCar("ghispo2")
                RageUI.CloseAll()
                end
            end)
        end

        if ESX.PlayerData.job.grade_name == 'boss' then

        RageUI.ButtonWithStyle("Commandant - VIR 2", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
            if (Selected) then
            Citizen.Wait(1)  
            spawnuniCar("rmodgt63sheriff")
            RageUI.CloseAll()
            end
        end)
    end

            
                end, function()
                end)

            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garagevoiture.position.x, Config.pos.garagevoiture.position.y, Config.pos.garagevoiture.position.z)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'sheriff' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('garagesheriff', 'main'), not RageUI.Visible(RMenu:Get('garagesheriff', 'main')))
                    end   
                end
               end 
        end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Config.spawn.spawnvoiture.position.x, Config.spawn.spawnvoiture.position.y, Config.spawn.spawnvoiture.position.z, Config.spawn.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "SHERIFF"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
    SetVehicleMaxMods(vehicle)
end

function SetVehicleMaxMods(vehicle)
    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
    ESX.Game.SetVehicleProperties(vehicle, props)
  end


Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_cop_01", 459.04, -1017.25, 27.15, 88.98, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
end)

  ------------------------ HELICO

  RMenu.Add('garageheli', 'main', RageUI.CreateMenu("Garage", "Garage du SHERIFF"))

  Citizen.CreateThread(function()
      while true do
          RageUI.IsVisible(RMenu:Get('garageheli', 'main'), true, true, true, function() 
  
              RageUI.ButtonWithStyle("Ranger au garage", nil, {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
              if (Selected) then   
              local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
              if dist4 < 4 then
                  DeleteEntity(veh)
                  RageUI.CloseAll()
              end 
          end
      end) 
  
              RageUI.ButtonWithStyle("Hélico du SHERIFF", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
              if (Selected) then
              Citizen.Wait(1)  
              spawnuniCarre("as350")
              RageUI.CloseAll()
              end
          end)
              
                  end, function()
                  end)
  
              Citizen.Wait(0)
          end
      end)
  
  Citizen.CreateThread(function()
          while true do
              Citizen.Wait(0)
      
  
      
                  local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                  local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garageheli.position.x, Config.pos.garageheli.position.y, Config.pos.garageheli.position.z)
              if dist3 <= 3.0 then
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'sheriff' then    
                      ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                      if IsControlJustPressed(1,51) then           
                          RageUI.Visible(RMenu:Get('garageheli', 'main'), not RageUI.Visible(RMenu:Get('garageheli', 'main')))
                      end   
                  end
                 end 
          end
  end)
  
  function spawnuniCarre(car)
      local car = GetHashKey(car)
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Citizen.Wait(0)
      end
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
      local vehicle = CreateVehicle(car, Config.spawn.spawnheli.position.x, Config.spawn.spawnheli.position.y, Config.spawn.spawnheli.position.z, Config.spawn.spawnheli.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "SHERIFF"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
      SetVehicleMaxMods(vehicle)
end

-------armurerie

RMenu.Add('armurerieSHERIFF', 'main', RageUI.CreateMenu("Armurerie", " "))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('armurerieSHERIFF', 'main'), true, true, true, function()   

            RageUI.ButtonWithStyle("Equipement de base", nil, { },true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('equipementbase')
                end
            end)


            if ESX.PlayerData.job.grade_name == 'officer' then
                for k,v in pairs(Config.armurerie) do
                RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerServerEvent('armurerie', v.arme, v.prix)
                    end
                end)
            end
        end

            if ESX.PlayerData.job.grade_name == 'sergeant' then
                for k,v in pairs(Config.arm) do
                RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerServerEvent('armurerie', v.arme, v.prix)
                    end
                end)
            end
        end

                    if ESX.PlayerData.job.grade_name == 'lieutenant' then
                    for k,v in pairs(Config.arm) do
                    RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                        if (Selected) then   
                            TriggerServerEvent('armurerie', v.arme, v.prix)
                        end
                    end)
                end
            end

            if ESX.PlayerData.job.grade_name == 'boss' then
                for k,v in pairs(Config.armi) do
                RageUI.ButtonWithStyle(v.nom, nil, { },true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerServerEvent('armurerie', v.arme, v.prix)
                    end
                end)
            end
        end

    



        end, function()
        end)
    Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, Config.pos.armurerie.position.x, Config.pos.armurerie.position.y, Config.pos.armurerie.position.z)
		    if dist2 <= 1.0 then
		    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sheriff' then 	
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder à l'armurerie")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('armurerieSHERIFF', 'main'), not RageUI.Visible(RMenu:Get('armurerieSHERIFF', 'main')))
                    end   
                end
            end 
        end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVMALE", "s_m_y_cop_01", 459.16, -988.84, 29.69, 128.67, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)
