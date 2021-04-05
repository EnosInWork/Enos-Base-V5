
local config = {
    Heading = 219.18060302734,
    pedHash = "s_m_y_construct_01",
    AuTravaillemine = false,
    ArgentMin = 2,
    ArgentMax = 30,
}






RegisterNetEvent("RED_JOBS:mineAntiDump")
AddEventHandler("RED_JOBS:mineAntiDump", function()
    TriggerClientEvent("RED_JOBS:mineAntiDump", source, config, WorkerChillPos, WorkerWorkingPos)
end)
