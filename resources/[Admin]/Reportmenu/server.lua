webhook = "https://discord.com/api/webhooks/795583402585489428/BOJr-801dX7X4JZVGCe-FnYE-XhOuK7jDasqBXHCqDn50Ku_EdLlWr6UFNTiYk42Tpk3"
local DISCORD_NAME = "Report Bot" 
local DISCORD_IMAGE = "https://www.pngkit.com/png/detail/123-1239684_attention-png-not-found-icon-png.png"

PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({avatar_url = DISCORD_IMAGE, username = DISCORD_NAME, content = "Report Bot est **EN LIGNE**", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

RegisterServerEvent('bugs:report')
AddEventHandler('bugs:report',function(name, message)
    color = 16711680
    discordWebhook("" .. " **Nouveau bug signalé:** ", message , color, "Rapporté par: " .. name)
end)

RegisterServerEvent('player:results')
AddEventHandler('player:results', function(name1, name2, reason)
    color = 16711680
    discordWebhook("" .. name1 .. " a été signalé comme toxique! ", reason , color, "Rapporté par: " .. name2)
end)

function discordWebhook(title, msg, color, text)
    local connect = {
          {
              ["color"] = color,
              ["title"] = title,
              ["description"] = msg,
              ["footer"] = {
              ["text"] = text,
              },
          }
      }
      PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = connect, avatar_url = DISCORD_IMAGE, username = DISCORD_NAME}), { ['Content-Type'] = 'application/json' })
  end
