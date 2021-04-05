Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(818894667369283624)
		SetDiscordRichPresenceAsset('logo1')
        SetDiscordRichPresenceAssetText('Enøs-V5')
    --    SetDiscordRichPresenceAssetSmall('logo0')
    --    SetDiscordRichPresenceAssetSmallText('discord.gg/dressko')
		SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/pRXCnA8")
		Citizen.Wait(60000)
	end
end)