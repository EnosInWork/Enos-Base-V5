local instance, instancedPlayers, registeredInstanceTypes, playersToHide = {}, {}, {}, {}
local instanceInvite, insideInstance
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetInstance()
	return instance
end

function CreateInstance(type, data)
	TriggerServerEvent('instance:create', type, data)
end

function CloseInstance()
	instance = {}
	TriggerServerEvent('instance:close')
	insideInstance = false
end

function EnterInstance(instance)
	insideInstance = true
	TriggerServerEvent('instance:enter', instance.host)

	if registeredInstanceTypes[instance.type].enter then
		registeredInstanceTypes[instance.type].enter(instance)
	end
end

function LeaveInstance()
	if instance.host then
		if #instance.players > 1 then
			ESX.ShowNotification(_U('left_instance'))
		end

		if registeredInstanceTypes[instance.type].exit then
			registeredInstanceTypes[instance.type].exit(instance)
		end

		TriggerServerEvent('instance:leave', instance.host)
	end

	insideInstance = false
end

function InviteToInstance(type, player, data)
	TriggerServerEvent('instance:invite', instance.host, type, player, data)
end

function RegisterInstanceType(type, enter, exit)
	registeredInstanceTypes[type] = {
		enter = enter,
		exit  = exit
	}
end

AddEventHandler('instance:get', function(cb)
	cb(GetInstance())
end)

AddEventHandler('instance:create', function(type, data)
	CreateInstance(type, data)
end)

AddEventHandler('instance:close', function()
	CloseInstance()
end)

AddEventHandler('instance:enter', function(_instance)
	EnterInstance(_instance)
end)

AddEventHandler('instance:leave', function()
	LeaveInstance()
end)

AddEventHandler('instance:invite', function(type, player, data)
	InviteToInstance(type, player, data)
end)

AddEventHandler('instance:registerType', function(name, enter, exit)
	RegisterInstanceType(name, enter, exit)
end)

RegisterNetEvent('instance:onInstancedPlayersData')
AddEventHandler('instance:onInstancedPlayersData', function(_instancedPlayers)
	instancedPlayers = _instancedPlayers
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(_instance)
	instance = {}
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(_instance)
	instance = _instance
end)

RegisterNetEvent('instance:onLeave')
AddEventHandler('instance:onLeave', function(_instance)
	instance = {}
end)

RegisterNetEvent('instance:onClose')
AddEventHandler('instance:onClose', function(_instance)
	instance = {}
end)

RegisterNetEvent('instance:onPlayerEntered')
AddEventHandler('instance:onPlayerEntered', function(_instance, player)
	instance = _instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	ESX.ShowNotification(_('entered_into', playerName))
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(_instance, player)
	instance = _instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	ESX.ShowNotification(_('left_out', playerName))
end)

RegisterNetEvent('instance:onInvite')
AddEventHandler('instance:onInvite', function(_instance, type, data)
	instanceInvite = {
		type = type,
		host = _instance,
		data = data
	}

	Citizen.CreateThread(function()
		Citizen.Wait(10000)

		if instanceInvite then
			ESX.ShowNotification(_U('invite_expired'))
			instanceInvite = nil
		end
	end)
end)

RegisterInstanceType('default')

-- Controls for invite
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if instanceInvite then
			ESX.ShowHelpNotification(_U('press_to_enter'))

			if IsControlJustReleased(0, 38) then
				EnterInstance(instanceInvite)
				ESX.ShowNotification(_U('entered_instance'))
				instanceInvite = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Instance players
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		playersToHide = {}

		if instance.host then
			-- Get players and sets them as pairs
			for k,v in ipairs(GetActivePlayers()) do
				playersToHide[GetPlayerServerId(v)] = true
			end

			-- Dont set our instanced players invisible
			for _,player in ipairs(instance.players) do
				playersToHide[player] = nil
			end
		else
			for player,_ in pairs(instancedPlayers) do
				playersToHide[player] = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()

		-- Hide all these players
		for serverId,_ in pairs(playersToHide) do
			local player = GetPlayerFromServerId(serverId)

			if NetworkIsPlayerActive(player) then
				local otherPlayerPed = GetPlayerPed(player)
				SetEntityVisible(otherPlayerPed, false, false)
				SetEntityNoCollisionEntity(playerPed, otherPlayerPed, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('instance:loaded')
end)

-- Fix vehicles randomly spawning nearby the player inside an instance
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) -- must be run every frame

		if insideInstance then
			SetVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)

			local pos = GetEntityCoords(PlayerPedId())
			RemoveVehiclesFromGeneratorsInArea(pos.x - 900.0, pos.y - 900.0, pos.z - 900.0, pos.x + 900.0, pos.y + 900.0, pos.z + 900.0)
		else
			Citizen.Wait(500)
		end
	end
end)