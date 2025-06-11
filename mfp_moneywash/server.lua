---------------------------------
--		    FRAMEWORK		   --
---------------------------------
if Config.Framework == 'ESX' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'QBCORE' then
        RegisterNetEvent('QBCore:Client:UpdateObject', function()
        QBCore = exports['qb-core']:GetCoreObject()
    end)
end
---------------------------------
--			  Script		   --
---------------------------------


RegisterServerEvent('mfp_moneywash:washMoney')
AddEventHandler('mfp_moneywash:washMoney', function(money)
	local player = source
    local xPlayer = nil
    local moneyhave = nil
	local useESX = nil

    if Config.Framework == 'ESX' then
		useESX = true
        xPlayer = ESX.GetPlayerFromId(player)
        moneyhave = xPlayer.getMoney()
    elseif Config.Framework == 'QBCORE' then
		useESX = false
        xPlayer = QBCore.Functions.GetPlayer(player)
        moneyhave = xPlayer.Functions.GetMoney("cash")
    end

    if moneyhave >= money then
        if useESX then
            xPlayer.removeAccountMoney('black_money', money)
			if Config.AdvancedNotification then
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, Translation[Config.Locale]['dealer'], Translation[Config.Locale]['dealer_contact'], (Translation[Config.Locale]['notification_1']):format(money), 'CHAR_BLOCKED', 7 )
			else
				ShowNotification(Translation[Config.Locale]['notification_1']):format(money)
			end
			-- WAIT
			Citizen.Wait(10000)

			if Config.AdvancedNotification then
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, Translation[Config.Locale]['dealer'], Translation[Config.Locale]['dealer_contact'], (Translation[Config.Locale]['notification_2']):format(total), 'CHAR_BLOCKED', 7 )
			else
				ShowNotification(Translation[Config.Locale]['notification_2']):format(money)
			end
			xPlayer.addMoney(total)
        elseif not useESX then
            xPlayer.Functions.RemoveItem('markedbills', amount)

			Citizen.Wait(10000)
			-- WAIT
			xPlayer.Functions.AddMoney('cash', newAmount)
        end
		if Dicordlogging then
			TriggerEvent('mfp_moneywash:discordlog', '__**MONEYWASHING**__\n\n**[Player]**: '..xPlayer.name..'\n**[Identifier]**: || '..xPlayer.identifier..' || \n**[WASHED MONEY]**: $'..total..'', DiscordWebhook['webhook'])
		end
	end -- end of moneyhave >= money
end)

function sendLogs (message,webhook)
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
end


------------ DISCORD LOGGING --------------
RegisterServerEvent('mfp_moneywash:discordlog')
AddEventHandler('mfp_moneywash:discordlog', function(message, webhook)
sendLogs(message , webhook)
end)

--- MONEY DISPLAY ---
if Config.Framework == 'ESX' then
	ESX.RegisterServerCallback('mfp_moneywash:getMoney', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local money = xPlayer.getAccount('black_money').money
		
		cb(money)
	end)
end


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print(" _____ _____ _____ _____ _____ _____ _____ _____ _____ _____ ")
	print("|     |   __|  _  |   __|     | __  |     |  _  |_   _|   __|")
	print("| | | |   __|   __|__   |   --|    -|-   -|   __| | | |__   |")
	print("|_|_|_|__|  |__|  |_____|_____|__|__|_____|__|    |_| |_____|")
	print("The resource " .. resourceName .. " has been started")
	if Dicordlogging then
		  TriggerEvent('mfp_moneywash:discordlog', "**mfp_moneywash** has been started succesfully!", DiscordWebhook['webhook'])
		  end
  end)