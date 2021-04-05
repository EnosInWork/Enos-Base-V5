ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local MenuBalchie = false

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", 10)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local function openBlanchiement()
	RMenu.Add("zj_blanchi", "zj_blanchi_main", RageUI.CreateMenu("~y~Blanchiment","Pourcentage : ~r~35%"))
	RMenu:Get('zj_blanchi', 'zj_blanchi_main'):SetRectangleBanner(0, 0, 0, 255)
	RMenu:Get('zj_blanchi', 'zj_blanchi_main').Closed = function()
		MenuBalchie = false
	end  
	  
    if not MenuBalchie then 
        MenuBalchie = true
		RageUI.Visible(RMenu:Get('zj_blanchi', 'zj_blanchi_main'), true)

		Citizen.CreateThread(function()
			while MenuBalchie do
				RageUI.IsVisible(RMenu:Get("zj_blanchi",'zj_blanchi_main'),true,true,true,function()
					RageUI.ButtonWithStyle("Blanchir votre argent", nil, {RightLabel = "~r~→"}, true, function(_, _, s)
						if s then
							local argent = KeyboardInput("Combien d'agent as-tu ?", '' , '', 8)
							TriggerServerEvent('jejey:blanchiement', argent)	
						end
					end)
				end, function()    
				end, 1)
				Wait(1)
			end

		Wait(0)
		MenuBalchie = false
		end)
	end
end

local Blanchir = {
	LOC = {
		{position = vector3(1109.063, -2336.487, 31.29795)}
	}
}

Citizen.CreateThread(function()

	local hash = GetHashKey("ig_ortega")
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end 
	ped = CreatePed("0x26A562B7", hash, 1109.063, -2336.487, 30.29795, 111.9, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)	
	SetEntityHeading(ped, 111.9)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)

    while true do
        local PlyCoord = GetEntityCoords(GetPlayerPed(-1))
        local dst = GetDistanceBetweenCoords(PlyCoord, true)

        for k,v in pairs(Blanchir.LOC) do
            if #(PlyCoord - v.position) < 1.5 then
                RageUI.Text({ message = "Appuyez sur [~y~E~s~] pour parler à Carlos", time_display = 1 })
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('open:blanchir')
                end
            end
        end
        Wait(5)
    end
end)

RegisterNetEvent("open:blanchir")
AddEventHandler("open:blanchir", function()
    openBlanchiement()
end)

