Text               = {}
BanList            = {}
BanListLoad        = false
BanListHistory     = {}
BanListHistoryLoad = false
if Config.Lang == "fr" then Text = Config.TextFr elseif Config.Lang == "en" then Text = Config.TextEn else print("FIveM-BanSql : Invalid Config.Lang") end

CreateThread(function()
	while true do
		Wait(1000)
        if BanListLoad == false then
			loadBanList()
			if BanList ~= {} then
				print(Text.banlistloaded)
				BanListLoad = true
			else
				print(Text.starterror)
			end
		end
		if BanListHistoryLoad == false then
			loadBanListHistory()
            if BanListHistory ~= {} then
				print(Text.historyloaded)
				BanListHistoryLoad = true
			else
				print(Text.starterror)
			end
		end
	end
end)

CreateThread(function()
	while Config.MultiServerSync do
		Wait(30000)
		MySQL.Async.fetchAll(
		'SELECT * FROM banlist',
		{},
		function (data)
			if #data ~= #BanList then
			  BanList = {}

			  for i=1, #data, 1 do
				table.insert(BanList, {
					license    = data[i].license,
					identifier = data[i].identifier,
					liveid     = data[i].liveid,
					xblid      = data[i].xblid,
					discord    = data[i].discord,
					playerip   = data[i].playerip,
					reason     = data[i].reason,
					added      = data[i].added,
					expiration = data[i].expiration,
					permanent  = data[i].permanent
				  })
			  end
			loadBanListHistory()
			TriggerClientEvent('BanSql:Respond', -1)
			end
		end
		)
	end
end)


RegisterCommand("ban", function(source, args, raw)
	if source == 0 then
		cmdban(source, args)
	end
end, true)

RegisterCommand("unban", function(source, args, raw)
	if source == 0 then
		cmdunban(source, args)
	end
end, true)


RegisterCommand("search", function(source, args, raw)
	if source == 0 then
		cmdsearch(source, args)
	end
end, true)

RegisterCommand("banoffline", function(source, args, raw)
	if source == 0 then
		cmdbanoffline(source, args)
	end
end, true)

RegisterCommand("banhistory", function(source, args, raw)
	if source == 0 then
		cmdbanhistory(source, args)
	end
end, true)


TriggerEvent('es:addGroupCommand', 'sqlban', Config.Permission, function (source, args, user)
	cmdban(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.ban, params = {{name = "id"}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

TriggerEvent('es:addGroupCommand', 'sqlunban', Config.Permission, function (source, args, user)
	cmdunban(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.unban, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addGroupCommand', 'sqlsearch', Config.Permission, function (source, args, user)
	cmdsearch(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.bansearch, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addGroupCommand', 'sqlbanoffline', Config.Permission, function (source, args, user)
	cmdbanoffline(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.banoff, params = {{name = "permid", help = Text.permid}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

TriggerEvent('es:addGroupCommand', 'sqlbanhistory', Config.Permission, function (source, args, user)
	cmdbanhistory(source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.history, params = {{name = "name", help = Text.steamname}, }})

TriggerEvent('es:addGroupCommand', 'sqlbanreload', Config.Permission, function (source)
  BanListLoad        = false
  BanListHistoryLoad = false
  Wait(5000)
  if BanListLoad == true then
	TriggerEvent('bansql:sendMessage', source, Text.banlistloaded)
	if BanListHistoryLoad == true then
		TriggerEvent('bansql:sendMessage', source, Text.historyloaded)
	end
  else
	TriggerEvent('bansql:sendMessage', source, Text.loaderror)
  end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.reload})


--How to use from server side : TriggerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason",TargetId)
RegisterServerEvent('BanSql:ICheat')
AddEventHandler('BanSql:ICheat', function(reason,servertarget)
	local license,identifier,liveid,xblid,discord,playerip,target
	local duree     = 0
	local reason    = reason

	if not reason then reason = "Auto Anti-Cheat" end

	if tostring(source) == "" then
		target = tonumber(servertarget)
	else
		target = source
	end

	if target and target > 0 then
		local ping = GetPlayerPing(target)
	
		if ping and ping > 0 then
			if duree and duree < 365 then
				local sourceplayername = "Anti-Cheat-System"
				local targetplayername = GetPlayerName(target)
					for k,v in ipairs(GetPlayerIdentifiers(target))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
						elseif string.sub(v, 1, string.len("live:")) == "live:" then
							liveid = v
						elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
							xblid  = v
						elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
							discord = v
						elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
							playerip = v
						end
					end
			
				if duree > 0 then
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
					DropPlayer(target, Text.yourban .. reason)
				else
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
					DropPlayer(target, Text.yourpermban .. reason)
				end
			
			else
				print("BanSql Error : Auto-Cheat-Ban time invalid.")
			end	
		else
			print("BanSql Error : Auto-Cheat-Ban target are not online.")
		end
	else
		print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
	end
end)

RegisterServerEvent('BanSql:CheckMe')
AddEventHandler('BanSql:CheckMe', function()
	doublecheck(source)
end)

-- console / rcon can also utilize es:command events, but breaks since the source isn't a connected player, ending up in error messages
AddEventHandler('bansql:sendMessage', function(source, message)
	if source ~= 0 then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist ', message } } )
	else
		print('SqlBan: ' .. message)
	end
end)

AddEventHandler('playerConnecting', function (playerName,setKickReason)
	local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	--Si Banlist pas chargée
	if (Banlist == {}) then
		Citizen.Wait(1000)
	end

    if steamID == "n/a" and Config.ForceSteam then
		setKickReason(Text.invalidsteam)
		CancelEvent()
    end

	for i = 1, #BanList, 1 do
		if 
			  ((tostring(BanList[i].license)) == tostring(license) 
			or (tostring(BanList[i].identifier)) == tostring(steamID) 
			or (tostring(BanList[i].liveid)) == tostring(liveid) 
			or (tostring(BanList[i].xblid)) == tostring(xblid) 
			or (tostring(BanList[i].discord)) == tostring(discord) 
			or (tostring(BanList[i].playerip)) == tostring(playerip)) 
		then

			if (tonumber(BanList[i].permanent)) == 1 then

				setKickReason(Text.yourpermban .. BanList[i].reason)
				CancelEvent()
				break

			elseif (tonumber(BanList[i].expiration)) > os.time() then

				local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
				if tempsrestant >= 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = (day - math.floor(day)) * 24
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day ..txthrs .. Text.hour ..txtminutes .. Text.minute)
						CancelEvent()
						break
				elseif tempsrestant >= 60 and tempsrestant < 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = tempsrestant / 60
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day .. txthrs .. Text.hour .. txtminutes .. Text.minute)
						CancelEvent()
						break
				elseif tempsrestant < 60 then
					local txtday     = 0
					local txthrs     = 0
					local txtminutes = math.ceil(tempsrestant)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day .. txthrs .. Text.hour .. txtminutes .. Text.minute)
						CancelEvent()
						break
				end

			elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then

				deletebanned(license)
				break
			end
		end
	end
end)

AddEventHandler('es:playerLoaded',function(source)
	CreateThread(function()
	Wait(5000)
		local license,steamID,liveid,xblid,discord,playerip
		local playername = GetPlayerName(source)

		for k,v in ipairs(GetPlayerIdentifiers(source))do
			if string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
			elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamID = v
			elseif string.sub(v, 1, string.len("live:")) == "live:" then
				liveid = v
			elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
				xblid  = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
				discord = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
				playerip = v
			end
		end

		MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
			['@license'] = license
		}, function(data)
		local found = false
			for i=1, #data, 1 do
				if data[i].license == license then
					found = true
				end
			end
			if not found then
				MySQL.Async.execute('INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername)', 
					{ 
					['@license']    = license,
					['@identifier'] = steamID,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			else
				MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername WHERE `license` = @license', 
					{ 
					['@license']    = license,
					['@identifier'] = steamID,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			end
		end)
		if Config.MultiServerSync then
			doublecheck(source)
		end
	end)
end)