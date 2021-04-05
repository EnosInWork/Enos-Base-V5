--||@SuperCoolNinja.||--

RegisterServerEvent("val_i:UpdateName")

AddEventHandler("val_i:UpdateName", function(nameInput)

	local source = source

	local identifier = GetPlayerIdentifiers(source)[1]

	local newName = nameInput

	if (tostring(newName) == nil) then

		return false

	  end

	MySQL.Async.execute("UPDATE users SET firstname=@nameInput WHERE identifier=@identifier", {['@identifier'] = identifier,['@nameInput'] = tostring(newName)})

	--print(identifier)

end)



RegisterServerEvent("val_i:UpdatePrenom")

AddEventHandler("val_i:UpdatePrenom", function(prenomInput)

	local source = source

	local identifier = GetPlayerIdentifiers(source)[1]

	local newPrenom = prenomInput

	if (tostring(newPrenom) == nil) then

		return false

	  end

	MySQL.Async.execute("UPDATE users SET lastname=@prenomInput WHERE identifier=@identifier", {['@identifier'] = identifier,['@prenomInput'] = tostring(newPrenom)})

end)



RegisterServerEvent("val_i:UpdateTaille")

AddEventHandler("val_i:UpdateTaille", function(tailleInput)

	local source = source

	local identifier = GetPlayerIdentifiers(source)[1]

	local newTaille = tailleInput

	if (tonumber(tailleInput) == nil) then

		return false

	  end

	MySQL.Async.execute("UPDATE users SET height=@tailleInput WHERE identifier=@identifier", {['@identifier'] = identifier,['@tailleInput'] = tonumber(newTaille)})

end)





RegisterServerEvent("val_i:Updatesex")

AddEventHandler("val_i:Updatesex", function(sexInput)

	local source = source

	local identifier = GetPlayerIdentifiers(source)[1]

	local newsex = sexInput

	if (tostring(sexInput) == nil) then

		return false

	  end

	MySQL.Async.execute("UPDATE users SET sex=@sexInput WHERE identifier=@identifier", {['@identifier'] = identifier,['@sexInput'] = tostring(newsex)})

end)



RegisterServerEvent("val_i:Updatedate")

AddEventHandler("val_i:Updatedate", function(dateInput)

	local source = source

	local identifier = GetPlayerIdentifiers(source)[1]

	local newdate = dateInput

	if (tostring(dateInput) == nil) then

      return false

	end

	MySQL.Async.execute("UPDATE users SET dateofbirth=@dateInput WHERE identifier=@identifier", {['@identifier'] = identifier,['@dateInput'] = tostring(newdate)})

end)