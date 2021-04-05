local LivraisonStart = false -- pour que le mec qui est en gofast voit le draw marker ainsi que le blips ou nn
local plyPed = PlayerPedId()



spawnCar = function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car,  762.51458740234,-1866.2678222656,28.667362213135, 263.71, true, false)
	SetEntityAsMissionEntity(vehicle, true, true)
	TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
    SetVehicleNumberPlateText(vehicle, "GO FAST")
end

---- PED
Citizen.CreateThread(function()
    RequestModel(GetHashKey("s_m_m_bouncer_01"))

    while not HasModelLoaded(GetHashKey("s_m_m_bouncer_01")) do
        Wait(1)
    end


    local npc2 = CreatePed("PED_TYPE_CIVMALE", "s_m_m_bouncer_01", 755.02111816406, -1865.4534912109,  28.293727874756, 100.40, false, true)

    FreezeEntityPosition(npc2, true)
    SetEntityHeading(npc2, 263.71)
    SetEntityInvincible(npc2, true) 
    SetBlockingOfNonTemporaryEvents(npc2, true)


    Citizen.Wait(200)
	TaskStartScenarioInPlace(npc2, "WORLD_HUMAN_SMOKING_POT", 0, 1)

end)

local gofast1 = {
	{x = 1764.2255859375, y = -1655.9798583984, z = 111.70049621582}
}

local gofast2 = {
	{x = 147.23368835449, y = 320.84851074219, z = 111.15874816895}
}


local gofast3 = {
	{x = 48.053672790527, y = 6657.3837890625, z = 30.754762191772}
}


function SendDistressSignal()	
    TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'D\'après mes infos un  Gofast a commencer')
end





trajet = {

	court = function()

		LivraisonStart = true 


		Citizen.CreateThread(function()

			while true do
				Citizen.Wait(5)
				if LivraisonStart == true then
					for k in pairs(gofast1) do
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gofast1[k].x, gofast1[k].y, gofast1[k].z)
						if dist <= 15.0 then
							DrawMarker(Config.MarkerType, gofast1[k].x, gofast1[k].y, gofast1[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
							
						end
						if dist <= 1.5 then
							ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour livrer votre ~b~butin")
							if IsControlJustPressed(1,51) then
								if IsPedSittingInAnyVehicle(plyPed) then
									SetVehicleDoorOpen(GetVehiclePedIsIn(plyPed, false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('reward', 2000)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast1)

								else
									ESX.ShowNotification('Il est où le véhicule que je t\'ai donné ? Dégage man !')
								end




							end
						end
					end
				end


			end
		end)
		
		SendDistressSignal()
		BlipsGofast1 = AddBlipForCoord(1764.2255859375,-1655.9798583984,112.68049621582)
		SetBlipSprite(BlipsGofast1, 1)
		SetBlipScale(BlipsGofast1, 0.85)
		SetBlipColour(BlipsGofast1, 1)
		PulseBlip(BlipsGofast1)
		SetBlipRoute(BlipsGofast1,  true)

		AddTimerBar("Temps restants", {endTime=GetGameTimer()+90000})
		Wait(90000)
		RemoveTimerBar()
		RemoveBlip(BlipsGofast1)
		SetVehicleEngineHealth(GetVehiclePedIsIn(plyPed, false), 10)
		LivraisonStart = false



	end,
	moyen = function()
		LivraisonStart = true 


		Citizen.CreateThread(function()

			while true do
				Citizen.Wait(5)
				if LivraisonStart == true then
					for k in pairs(gofast2) do
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gofast2[k].x, gofast2[k].y, gofast2[k].z)
						if dist <= 15.0 then
							DrawMarker(Config.MarkerType, gofast2[k].x, gofast2[k].y, gofast2[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
							
						end
						if dist <= 1.5 then
							ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour livrer votre ~b~butin")
							if IsControlJustPressed(1,51) then
								if IsPedSittingInAnyVehicle(plyPed)  then
									SetVehicleDoorOpen(GetVehiclePedIsIn(plyPed, false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('reward', 4000)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast2)

								else
									ESX.ShowNotification('Il est où le véhicule que je t\'ai donné ? Dégage man !')
								end




							end
						end
					end
				end


			end
		end)
		SendDistressSignal()
		BlipsGofast2 = AddBlipForCoord(147.23368835449,320.84851074219,112.13874816895)
		SetBlipSprite(BlipsGofast2, 1)
		SetBlipScale(BlipsGofast2, 0.85)
		SetBlipColour(BlipsGofast2, 1)
		PulseBlip(BlipsGofast2)
		SetBlipRoute(BlipsGofast2,  true)

		AddTimerBar("Temps restants", {endTime=GetGameTimer()+150000})
		Wait(150000)
		RemoveTimerBar()
		RemoveBlip(BlipsGofast2)
		SetVehicleEngineHealth(GetVehiclePedIsIn(plyPed, false), 10)
		LivraisonStart = false

    end,

	long = function ()
		LivraisonStart = true 


		Citizen.CreateThread(function()

			while true do
				Citizen.Wait(5)
				if LivraisonStart == true then
					for k in pairs(gofast3) do
						local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gofast3[k].x, gofast3[k].y, gofast3[k].z)
						if dist <= 15.0 then
							DrawMarker(Config.MarkerType, gofast3[k].x, gofast3[k].y, gofast3[k].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
							
						end
						if dist <= 1.5 then
							ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour livrer votre ~b~butin")
							if IsControlJustPressed(1,51) then
								if IsPedSittingInAnyVehicle(plyPed)  then
									SetVehicleDoorOpen(GetVehiclePedIsIn(plyPed, false), 5, false)
									Wait(2000)
									LivraisonStart = false
									TriggerServerEvent('reward', 7000)
									TriggerEvent('esx:deleteVehicle')
									RemoveTimerBar()
									RemoveBlip(BlipsGofast3)

								else
									ESX.ShowNotification('Il est où le véhicule que je t\'ai donné ? Dégage man !')
								end




							end
						end
					end
				end


			end
		end)
		SendDistressSignal()
		BlipsGofast3 = AddBlipForCoord(48.053672790527,6657.3837890625,31.734762191772)
		SetBlipSprite(BlipsGofast3, 1)
		SetBlipScale(BlipsGofast3, 0.85)
		SetBlipColour(BlipsGofast3, 1)
		PulseBlip(BlipsGofast3)
		SetBlipRoute(BlipsGofast3,  true)

		AddTimerBar("Temps restants", {endTime=GetGameTimer()+480000})
		Wait(480000)
		RemoveTimerBar()
		RemoveBlip(BlipsGofast3)
		SetVehicleEngineHealth(GetVehiclePedIsIn(plyPed, false), 10)
		LivraisonStart = false
    end
}





