ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)


RegisterNetEvent('cosasvariadas:kevlar')
AddEventHandler('cosasvariadas:kevlar', function()

    local playerPed = PlayerPedId()

    AddArmourToPed(playerPed,100)
    SetPedArmour(playerPed, 100)

end)
    