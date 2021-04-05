ESX                    = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('VmLife:DeleteTenue')
AddEventHandler('VmLife:DeleteTenue', function(id,label)

  MySQL.Async.execute(
    'DELETE FROM user_tenue WHERE id = @id',
    {
      ['@id'] =  id
    }
  )
  TriggerClientEvent("esx:showNotification",source,"Tenue supprimé")

end)

RegisterServerEvent('VmLife:RenameTenue')
AddEventHandler('VmLife:RenameTenue', function(id,label)

  MySQL.Async.execute(
    'UPDATE user_tenue SET label = @label WHERE id=@id',
    {
      ['@id'] = id,
      ['@label'] = label

    }
  )
  TriggerClientEvent("esx:showNotification",source,"Vous avez bien renommé votre tenue en "..label)

end)

ESX.RegisterServerCallback('Mushy:getMask', function(source, cb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  
  

  MySQL.Async.fetchAll(
    'SELECT * FROM user_accessories WHERE identifier = @identifier',
    {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)

      cb(result)
    --  --(json.encode(result))

  end )

end)

RegisterServerEvent('VmLife:SaveTenueS')
AddEventHandler('VmLife:SaveTenueS', function(label,skin)
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  MySQL.Async.execute(
    'INSERT INTO user_tenue (identifier,label,tenue) VALUES(@identifier,@label,@skin)',
    {
      ['@label'] = label, 
      ['@skin'] = json.encode(skin),

    ['@identifier'] =  xPlayer.identifier
    }
  )

end)

ESX.RegisterServerCallback('VmLife:GetTenues', function(source, cb, _)
	--("ss")
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT * FROM user_tenue WHERE identifier = @identifier',
		{
      ['@identifier'] = xPlayer.identifier
		},
    function(result)
			cb(result)
		end
	)
end)

RegisterServerEvent("Mushy:RenameMasque")
AddEventHandler("Mushy:RenameMasque", function(id,txt,type)
  MySQL.Async.execute(
    'UPDATE user_accessories SET label = @label WHERE id=@id',
    {
      ['@id'] = id,
      ['@label'] = txt

    }
  )
  TriggerClientEvent("esx:showNotification",source,"Vous avez bien renommé votre "..type.." en "..txt)

end)

RegisterServerEvent('Mushy:Delclo')
AddEventHandler('Mushy:Delclo', function(id,label,data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

			

			
			MySQL.Async.execute(
				'DELETE FROM user_accessories where id = @id',
				{
					['@id']   = id,

		
				}
			)
      TriggerClientEvent('esx:showNotification', _source, '~r~-1 '.. label)
      TriggerClientEvent("Mushy:SyncAccess",source)
      print("Delete Sync effectué !")

end)

RegisterServerEvent("Mushy:SetNewMasque")
AddEventHandler("Mushy:SetNewMasque", function(mask,variation,type,label)
  maskx = {mask_1=mask,mask_2=variation}
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

 -- if label == nil then
  --label = type
  --end
  if xPlayer.get('money') >= 50 then
    xPlayer.removeMoney(50)
  MySQL.Async.execute(
    'INSERT INTO user_accessories (identifier,mask,type,label) VALUES(@identifier,@mask,@type,@label)',
    {
      
      ['@mask'] = json.encode(maskx),
      ['@type'] = type,
      ['@label'] = label,
    ['@identifier'] =  xPlayer.identifier
    }
  )
  TriggerClientEvent("Mushy:SyncAccess",source)
  TriggerClientEvent("esx:showNotification",source,"~g~Vous avez reçu un nouveau " .. type .."~n~~r~-50$" )
else
  TriggerClientEvent('esx:showNotification', _source, 'Pas assez d\'argent (50$)')
end
end)

RegisterServerEvent('Mushy:GiveAccessories')
AddEventHandler('Mushy:GiveAccessories', function(target,id,label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayer2 = ESX.GetPlayerFromId(target)
	MySQL.Async.execute(
		'UPDATE user_accessories SET identifier = @identifier WHERE id = @id',
		{
			['@identifier']   = xPlayer2.identifier,
			['@id'] = id

		}
	)
			TriggerClientEvent('esx:showNotification', _source, '~r~-1 '.. label)
			TriggerClientEvent('esx:showNotification', target, '~g~+1 '.. label)
		
			TriggerClientEvent("Mushy:SyncAccess",source)
			TriggerClientEvent("Mushy:SyncAccess",target)

end)

RegisterNetEvent('shop:price')
AddEventHandler('shop:price', function(prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()
	xPlayer.removeMoney(prix)
	TriggerClientEvent('esx:showNotification', source, "~y~Shop~w~ : Vous avez payer 25$ ! ")

end)