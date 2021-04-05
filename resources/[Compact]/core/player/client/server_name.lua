function SetData()
	players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		table.insert( players, player )
end

	
	local name = GetPlayerName(PlayerId())
	local id = GetPlayerServerId(PlayerId())
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', "~p~Enøs Base V5~s~ Roleplay - ~p~".. #players .." ~s~connecté(e)s")
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetData()
	end
end)

Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_LEAVE", "Se déconnecter de ~p~Enos City~s~")
end)

Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_QUIT", "~o~Quitter FiveM")
end)