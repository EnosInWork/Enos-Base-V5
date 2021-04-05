ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(0)
	end
end)


function HelpMsg(msg)
	AddTextEntry('LocationNotif', msg)
	BeginTextCommandDisplayHelp('LocationNotif')
	EndTextCommandDisplayHelp(0, false, true, -1)
end


function CreateCamera()
	Wait(1)
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x+2.0, coords.y+2.0, coords.z+2.0)
    SetCamFov(cam, 50.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+1.0)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end