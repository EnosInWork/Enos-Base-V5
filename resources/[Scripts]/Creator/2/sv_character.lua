ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print('^2NCore | Nehco Creator')
print('^2NCore | charger avec succès !')

RegisterServerEvent('Nehco:saveOof')
AddEventHandler('Nehco:saveOof', function(sexe, prenom, nom, datedenaissance, taille)
    _source = source
    mySteamID = GetPlayerIdentifiers(_source)
    mySteam = mySteamID[1]

    MySQL.Async.execute('UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height WHERE identifier = @identifier', {
      ['@identifier']        = mySteam,
      ['@firstname']        = prenom,
      ['@lastname']        = nom,
      ['@dateofbirth']    = datedenaissance,
      ['@sex']            = sexe,
      ['@height']            = taille
    }, function(rowsChanged)
      if callback then
        callback(true)
      end
    end)
end)