ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---Comestibles basiques

ESX.RegisterUsableItem('pain', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pain', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_pain'))
end)

ESX.RegisterUsableItem('eau', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('eau', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_eau'))
end)

ESX.RegisterUsableItem('chocolat', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chocolat', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 75000)
	TriggerClientEvent('esx_basicneeds:onEatChocolate', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_chocolat'))
end)

ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	TriggerClientEvent('esx_basicneeds:onEatSandwich', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sandwich'))
end)

ESX.RegisterUsableItem('saucisson', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('saucisson', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEatSandwich', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_saucisson'))
end)

ESX.RegisterUsableItem('pizza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pizza', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEatSandwich', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_pizza'))
end)

ESX.RegisterUsableItem('hamburger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_status:add', source, 'thirst', -50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_hamburger'))
end)

ESX.RegisterUsableItem('chips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_status:add', source, 'thirst', -30000)
	TriggerClientEvent('esx_basicneeds:onEatChips', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_chips'))
end)

ESX.RegisterUsableItem('bolcacahuetes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolcacahuetes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_status:add', source, 'thirst', -30000)
	TriggerClientEvent('esx_basicneeds:onEatChips', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bolcacahuetes'))
end)

ESX.RegisterUsableItem('bolchips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolchips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_status:add', source, 'thirst', -30000)
	TriggerClientEvent('esx_basicneeds:onEatChips', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bolchips'))
end)

ESX.RegisterUsableItem('bolnoixcajou', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolnoixcajou', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_status:add', source, 'thirst', -30000)
	TriggerClientEvent('esx_basicneeds:onEatChips', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bolnoixcajou'))
end)

ESX.RegisterUsableItem('bolpistache', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolpistache', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_status:add', source, 'thirst', -30000)
	TriggerClientEvent('esx_basicneeds:onEatChips', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bolpistache'))
end)

ESX.RegisterUsableItem('mixapero', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mixapero', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_status:add', source, 'thirst', -30000)
	TriggerClientEvent('esx_basicneeds:onEatChips', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_mixapero'))
end)

---Boissons

ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fanta', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_fanta'))
end)

ESX.RegisterUsableItem('coca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coca', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrinkCoca', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_coca'))
end)

ESX.RegisterUsableItem('oasis', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('oasis', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_oasis'))
end)

ESX.RegisterUsableItem('orangina', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('orangina', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_orangina'))
end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprite', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sprite'))
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_icetea'))
end)

ESX.RegisterUsableItem('drpepper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('drpepper', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrinkCocaCola', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_drpepper'))
end)

ESX.RegisterUsableItem('energy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('energy', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 30000)
	TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_energy'))
end)

ESX.RegisterUsableItem('jusfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jusfruit', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 30000)
	TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_jusfruit'))
end)

ESX.RegisterUsableItem('limonade', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('limonade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_limonade'))
end)

ESX.RegisterUsableItem('coffee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffee', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkCoffe', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_coffee'))
end)

ESX.RegisterUsableItem('capuccino', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('capuccino', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkCapuccino', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_capuccino'))
end)

ESX.RegisterUsableItem('tea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tea', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', -100000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrinkTea', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_tea'))
end)

---Restaurants

ESX.RegisterUsableItem('chicken_burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chicken_burger', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_chicken_burger'))
end)

ESX.RegisterUsableItem('fish_burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fish_burger', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_fish_burger'))
end)

ESX.RegisterUsableItem('veggie_burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('veggie_burger', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_veggie_burger'))
end)

ESX.RegisterUsableItem('bacon_burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bacon_burger', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_bacon_burger'))
end)

ESX.RegisterUsableItem('steakhouse_burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('steakhouse_burger', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 450000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_steakhouse_burger'))
end)

ESX.RegisterUsableItem('terminator_burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('terminator_burger', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_cs_burger_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_terminator_burger'))
end)

ESX.RegisterUsableItem('tacos', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tacos', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 225000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_taco_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_taco'))
end)

ESX.RegisterUsableItem('chicken_wrap', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chicken_wrap', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 175000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_taco_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_chicken_wrap'))
end)

ESX.RegisterUsableItem('fish_wrap', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fish_wrap', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 175000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_taco_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_fish_wrap'))
end)

ESX.RegisterUsableItem('batonnets_de_mozzarella', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('batonnets_de_mozzarella', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 175000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_taco_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_batonnets_de_mozzarella'))
end)

ESX.RegisterUsableItem('oignon_rings', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('oignon_rings', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 175000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_donut_02')
    TriggerClientEvent('esx:showNotification', source, _U('eat_oignon_rings'))
end)

ESX.RegisterUsableItem('fries', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fries', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 125000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_food_chips')
    TriggerClientEvent('esx:showNotification', source, _U('eat_fries'))
end)

ESX.RegisterUsableItem('salade', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('salade', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_bowl_crisps')
    TriggerClientEvent('esx:showNotification', source, _U('eat_salade'))
end)


ESX.RegisterUsableItem('salade_cesar', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('salade_cesar', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 450000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_bowl_crisps')
    TriggerClientEvent('esx:showNotification', source, _U('eat_salade_cesar'))
end)

---Desserts

ESX.RegisterUsableItem('cupcake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cupcake', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEatCupCake', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cupcake'))
end)

ESX.RegisterUsableItem('milkshake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('milkshake', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source, 'prop_cs_milk_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_milkshake'))
end)

ESX.RegisterUsableItem('cheesecake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cheesecake', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_donut_01')
    TriggerClientEvent('esx:showNotification', source, _U('eat_cheesecake'))
end)

ESX.RegisterUsableItem('smoothie', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('smoothie', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkJuice', source)
    TriggerClientEvent('esx:showNotification', source, _U('eat_smoothie'))
end)

ESX.RegisterUsableItem('sundae', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sundae', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_candy_pqs')
    TriggerClientEvent('esx:showNotification', source, _U('eat_sundae'))
end)

ESX.RegisterUsableItem('churros', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('churros', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_donut_02')
    TriggerClientEvent('esx:showNotification', source, _U('eat_churros'))
end)

ESX.RegisterUsableItem('donuts', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('donuts', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_donut_02b')
    TriggerClientEvent('esx:showNotification', source, _U('eat_donuts'))
end)

ESX.RegisterUsableItem('brownie', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('brownie', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_donut_02b')
    TriggerClientEvent('esx:showNotification', source, _U('eat_brownie'))
end)

ESX.RegisterUsableItem('cookie', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cookie', 1)
	TriggerClientEvent('esx_status:add', source, 'hunger', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source, 'prop_donut_02')
    TriggerClientEvent('esx:showNotification', source, _U('eat_cookie'))
end)

-----/heal 

TriggerEvent('es:addGroupCommand', 'heal', 'superadmin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local target = tonumber(args[1])
		
		-- is the argument a number?
		if target ~= nil then
			
			-- is the number a valid player?
			if GetPlayerName(target) then
				print('esx_basicneeds: ' .. GetPlayerName(source) .. ' soigne un joueur!')
				TriggerClientEvent('esx_basicneeds:healPlayer', target)
				TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "Vous avez été soigné!")
			else
				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Joueur introuvable!")
			end
		else
			TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Erreur d\'écriture! Vous devez saisir l\' ID du joueur")
		end
	else
		-- heal source
		print('esx_basicneeds: ' .. GetPlayerName(source) .. ' est soigné!')
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Permission insuffisante.")
end, {help = "Soigne un joueur, ou vous-même - restaure soif, faim et santé."})
