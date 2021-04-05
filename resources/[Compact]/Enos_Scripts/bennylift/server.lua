

--x=-224.42932128906,y=-1338.8306884766,z=17.723197937012  h=90.0



local liftData = {
	["789456"] = {
		code = "789456",
		
		controlup = {x=-230.79672241211,y=-1336.4926757813,z=30.902803421021}, --(Inter de control murale pour appeler la cabine)
		controldown = {x=-229.9367980957,y=-1336.5185546875,z=18.463350296021}, 
		
		up = {x=-224.9193,y=-1338.261,z=31.28919}, --(position cabine) --  -1.396 mais je sais pas pk ca se decal ???
		down = {x=-224.9193,y=-1338.261,z=18.8292},
		
		offsetup = {x=-224.9193,y=-1338.261,z=31.28919-1.396}, --  -1.396 mais je sais pas pk ca se decal ??? spawn
		offsetdown = {x=-224.9193,y=-1338.261,z=18.8292-1.396},
		
		controlCabineUp = {x=-228.44960021973,y=-1340.6348876953,z=30.893201828003}, --(Inter de control dans la cabine)
		controlCabineDown = {x=-228.94534301758,y=-1340.9337158203,z=18.523215103149},
		
		
		Zelevate=31.28919-18.8292, --Hauteur d'élévation Zmax - Zmin (flemme de calculer)
		
		isUp = true,
		
		isInUse = false,
		
		elevateProps = "patoche_elevatorb", --Cabine props
		rotation = {a=0.0,b=0.0,c=0.0},
		elevateHeading = 90.0, --Heading de l'ascenceur (World relative)
		elevateID = 0, -- ID du props spawn
		
		
		downDoorIsOpen = false,
		
		doorDown = "patoche_elevatorb_door",
		doorDownCoords = {x=-229.3393, y=-1338.831, z=17.53319},
		doorDownOpenCoords = {x=-229.3393, y=-1338.831, z=20.05319},
		doorDownHeading = 90.0,
		doorDownID = 0, -- ID du props spawn
		
		upDoorIsOpen = false,
		
		doorUp = "patoche_elevatorb_door",
		doorUpCoords = {x=-229.3393, y=-1338.831, z=30.00321},
		doorUpOpenCoords = {x=-229.3393, y=-1338.831, z=32.48326},
		doorUpHeading = 90.0,
		doorUpID = 0,-- ID du props spawn
		
	}
}
local CurFreezeVeh = {}
RegisterServerEvent('bennylift:askVehFreeze') --Monter (depuis l'intérieur)
AddEventHandler('bennylift:askVehFreeze', function(allVeh,liftcode)
	-- print("up : "..tostring(code))
	local lstVeh = allVeh
	-- Citizen.CreateThread(function()
		for k,v in pairs(lstVeh) do
			-- print("ent: "..tostring(v.entity).." id: "..tostring(v.netId).." owner: "..tostring(NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(v.netId))))
			
			table.insert(CurFreezeVeh,{ent=v.entity,netId=v.netId,owner=NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(v.netId))})
			-- TriggerClientEvent("bennylift:FreezeVeh",NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(v.netId)),v.netId,liftcode)
			TriggerClientEvent("bennylift:FreezeVeh",-1,v.netId,liftcode)
		end
	-- end)
end)

RegisterServerEvent('bennylift:askVehUnFreeze') --Monter (depuis l'intérieur)
AddEventHandler('bennylift:askVehUnFreeze', function(allVeh,liftcode)
	-- print("up : "..tostring(code))
	local lstVeh = allVeh
	-- Citizen.CreateThread(function()
		for k,v in pairs(lstVeh) do
			-- print("ent: "..tostring(v.entity).." id: "..tostring(v.netId).." owner: "..tostring(NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(v.netId))))
			
			-- table.insert(CurFreezeVeh,{ent=v.entity,netId=v.netId,owner=NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(v.netId))})
			-- TriggerClientEvent("bennylift:FreezeVeh",NetworkGetEntityOwner(NetworkGetEntityFromNetworkId(v.netId)),v.netId,liftcode)
			TriggerClientEvent("bennylift:UnFreezeVeh",-1,v.netId,liftcode)
		end
	-- end)
end)

RegisterServerEvent('bennylift:liftup') --Monter (depuis l'intérieur)
AddEventHandler('bennylift:liftup', function(code)
	-- print("up : "..tostring(code))
	Citizen.CreateThread(function()
		if not liftData[code].isInUse then
			-- print("not in use : "..tostring(code))
			liftData[code].isInUse = true
			TriggerClientEvent("bennylift:closeDoorDown",-1,code) --ferme porte du bas
			-- print("after door : "..tostring(code))
			Wait(3950)
			
			for i=1,5 do
				-- print("lift up")
				TriggerClientEvent("bennylift:StepUp",-1,code)
				Wait(2500)
				-- print("waitEnded")
			end
			TriggerClientEvent("bennylift:StepUpAndDoor",-1,code) -- et monte puis ouvre les portes

			liftData[code].isUp = true
			liftData[code].isInUse = false
			Wait(35000)
			TriggerClientEvent("bennylift:closeDoorUpIfnotBusy",-1,code)
		end
	end)
end)

RegisterServerEvent('bennylift:liftdown') --Descendre (depuis l'intérieur)
AddEventHandler('bennylift:liftdown', function(code)
	Citizen.CreateThread(function()
		if not liftData[code].isInUse then
			liftData[code].isInUse = true
			TriggerClientEvent("bennylift:closeDoorUp",-1,code)--ferme porte du haut
			Wait(3950)
			for i=1,5 do
				-- print("lift up")
				TriggerClientEvent("bennylift:StepDown",-1,code)
				Wait(2500)
				-- print("waitEnded")
			end
			
			TriggerClientEvent("bennylift:StepDownAndDoor",-1,code)-- et descend puis ouvre les portes
			liftData[code].isUp = false
			liftData[code].isInUse = false
			Wait(35000)
			TriggerClientEvent("bennylift:closeDoorDownIfnotBusy",-1,code)
		end
	end)
end)

RegisterServerEvent('bennylift:askUp')
AddEventHandler('bennylift:askUp', function(code)
	Citizen.CreateThread(function()
		if not liftData[code].isUp then -- si en bas monte et ouvre porte
			if not liftData[code].isInUse then
				liftData[code].isInUse = true
				TriggerClientEvent("bennylift:upAndDoor",-1,code)
				liftData[code].isUp = true
				liftData[code].isInUse = false
			end
		else -- déja en haut juste ouvre porte
			TriggerClientEvent("bennylift:openDoorUp",-1,code)
		end
	end)
end)

RegisterServerEvent('bennylift:askDown')
AddEventHandler('bennylift:askDown', function(code)
	Citizen.CreateThread(function()
		if liftData[code].isUp then -- si en haut descend et ouvre porte
			if not liftData[code].isInUse then
				liftData[code].isInUse = true
				TriggerClientEvent("bennylift:downAndDoor",-1,code)
				liftData[code].isUp = false
				liftData[code].isInUse = false
			end
		else -- déja en bas juste ouvre porte
			TriggerClientEvent("bennylift:openDoorDown",-1,code)
		end
	end)
end)

RegisterServerEvent('bennylift:GetStatus')
AddEventHandler('bennylift:GetStatus', function()
	local player = source
	TriggerClientEvent("bennylift:sendStatus",player,liftData)
end)

