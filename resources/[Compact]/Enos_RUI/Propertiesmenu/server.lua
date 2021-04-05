ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('aPropertiesmenu:Save')
AddEventHandler('aPropertiesmenu:Save', function(name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, price)
    local x_source = source

    MySQL.Async.fetchAll("SELECT name FROM properties WHERE name = @name", {

   	   ['@name'] = name,

    }, 
    function(result)
        if result[1] ~= nil then 
       	   TriggerClientEvent('esx:showNotification', x_source, 'Ce nom éxiste déja !')
       	else 
       	   Insert(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, price)   
        end 
    end)
end)

function Insert(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, price)
    MySQL.Async.execute('INSERT INTO properties (name, label ,entering ,`exit`,inside,outside,ipls,is_single,is_room,is_gateway,room_menu,price) VALUES (@name,@label,@entering,@exit,@inside,@outside,@ipls,@isSingle,@isRoom,@isGateway,@roommenu,@price)',
		{
			['@name'] = name,
			['@label'] = label,
			['@entering'] = entering,
			['@exit'] = exit,
			['@inside'] = inside,
			['@outside'] = outside,
			['@ipls'] = ipl,
			['@isSingle'] = isSingle,
			['@isRoom'] = isRoom,
			['@isGateway'] = isGateway,
			['@roommenu'] = roommenu,
			['@price'] = price,

		}, 
		function (rowsChanged)
			TriggerClientEvent('esx:showNotification', x_source, 'Propriété bien enregistré')
		end
	)
end
