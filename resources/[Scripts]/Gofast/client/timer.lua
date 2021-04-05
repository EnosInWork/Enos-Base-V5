local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.035, titleOffsetY = -0.018, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035 , timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 } 


local activeBars = {}
function AddTimerBar(title, itemData)
	if not itemData then return end
	RequestStreamedTextureDict("timerbars", true)

	local barIndex = #activeBars + 1
	activeBars[barIndex] = {
		title = title,
		text = itemData.text,
		textColor = itemData.color or { 255, 255, 255, 255 },
		percentage = itemData.percentage,
		endTime = itemData.endTime,
		pbarBgColor = itemData.bg or { 155, 155, 155, 255 },
		pbarFgColor = itemData.fg or { 255, 255, 255, 255 }
	}

	return barIndex
end

function RemoveTimerBar()
	activeBars = {}
	SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar(barIndex, itemData)
	if not activeBars[barIndex] or not itemData then return end
	for k,v in pairs(itemData) do
		activeBars[barIndex][k] = v
	end
end

function SecondsToClock(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		local mins = string.format("%02.f", math.floor(seconds / 60))
		local secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function DrawText2(intFont, stirngText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)
	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end
	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end
	SetTextEntry("STRING")
	AddTextComponentString(stirngText)
	DrawText(intPosX, intPosY)
end	


local HideHudComponentThisFrame = HideHudComponentThisFrame
local GetSafeZoneSize = GetSafeZoneSize
local DrawSprite = DrawSprite
local DrawText2 = DrawText2
local DrawRect = DrawRect
local SecondsToClock = SecondsToClock
local GetGameTimer = GetGameTimer
local textColor = { 200, 100, 100 }
local math = math

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local safeZone = GetSafeZoneSize()
		local safeZoneX = (1.0 - safeZone) * 0.5
		local safeZoneY = (1.0 - safeZone) * 0.5

		if #activeBars > 0 then
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)

			for i,v in pairs(activeBars) do
				local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
				DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
				DrawText2(0, v.title, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

				if v.percentage then
					local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
					local pbarY = drawY + ScreenCoords.pbarOffsetY;
					local width = Sizes.pbarWidth * v.percentage;

					DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

					DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
				elseif v.text then
					DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
				elseif v.endTime then
					local remainingTime = math.floor(v.endTime - GetGameTimer())
					DrawText2(0, SecondsToClock(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
				end
			end
		end
	end
end)
