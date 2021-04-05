RegisterNetEvent('BanSql:Respond')
AddEventHandler('BanSql:Respond', function()
	TriggerServerEvent("BanSql:CheckMe")
end)

--Event Demo

--TriggerServerEvent("BanSql:ICheat")
--TriggerServerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason")