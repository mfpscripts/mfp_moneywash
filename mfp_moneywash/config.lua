Config = {}
Translation = {}

Config.Framework == 'ESX' -- ESX or QBCORE

Config.Locale = 'en' -- 'en' for english, 'de' for german

Config.washPercent = 0.75 -- Percentage of the money that goes back (default: 0.75 <-- means 75%)

Anit2much = true -- activate a notification if a player have too much blackmoney before washing in discord as a warning (maybe a cheater...)
Anti_MoneyMax = 10000000 -- 10 mil could be sus xD

Dicordlogging = false -- type true to enable it!
DiscordWebhook = {
    ['webhook'] = '',
}

Config.WashingLocations = {
{ ['x'] = 3.24, ['y'] = -1309.98, ['z'] = 30.16} -- mehrere Möglich!
}

Config.Npc = { -- coords to add more npc's [dealers] you want
   { ['x'] = 3.24, ['y'] = -1309.98, ['z'] = 29.16, ['h'] = 10.99}, -- mehrere möglich!

}

Config.AdvancedNotification = true -- ESX ONLY
function ShowNotification(message)

	-- standalone
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
  
	-- esx
	-- ESX.ShowNotification(message)
  
	-- qbcore
	-- QBCore.Functions.Notify(message, 'primary', 5000)
  
	-- custom
	-- exports["rtx_notify"]:Notify("Phone Battery", message, 5000, "info")
	-- exports["mythic_notify"]:SendAlert("inform", message, 5000)
  end

Translation = {
    ['de'] = {
	    ----------- MENU -----------
        ['open_menu'] = 'Drücke ~INPUT_PICKUP~ um mit dem Mann zu reden',
		['dealer'] = 'Geldwäscher',
		['dealer_contact'] = 'Kontaktmann',
		['dealer_subtitle'] = 'Wasche dein Geld bei mir!',
		['firstone'] = '~r~500$',
	    ['secondone'] = '~r~5.000$',
		['tripple'] = '~r~10.000$',
        ['custom_washing_button'] = '~o~Eigene Summe',
		['money_in_cash'] = '~r~Schwarzgeld',
		['custom_washing_text'] = 'Wie viel Geld benötigst du gewaschen?',
		-------- NOTIFICATIONS --------
		['notification_1'] = 'Es werden ~r~%s$~s~ gewaschen! Bitte warte kurz...',
		['notification_2'] = 'Deine ~r~%s$~s~ wurden ~g~erfolgreich~s~ gewaschen, verpiss dich jetzt! Der Rest ist mein Anteil!',
		['notification_3'] = '~r~Du musst auch %s$ haben, um es zu waschen...',
    },

    ['en'] = {
		----------- MENU -----------
        ['open_menu'] = 'Press ~INPUT_PICKUP~ to talk to the man',
		['dealer'] = 'Money Launderer',
		['dealer_contact'] = 'Mediator',
		['dealer_subtitle'] = 'Wash your money with me!',
		['firstone'] = '~r~500$',
	    ['secondone'] = '~r~5.000$',
		['tripple'] = '~r~10.000$',
        ['custom_washing_button'] = '~o~Own amount',
		['money_in_cash'] = '~r~Blackmoney',
		['custom_washing_text'] = 'How much money do you need laundered?',
		-------- NOTIFICATIONS --------
		['notification_1'] = '~r~%s$~s~ are being washed! Please wait a moment...',
		['notification_2'] = 'Your ~r~%s$~s~ have been washed ~g~successfully~s~, now fuck off! The rest is my share!',
		['notification_3'] = '~r~You must also have %s$ to wash it...',
    },
}