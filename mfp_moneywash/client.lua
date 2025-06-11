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

-----------------------------------
_menuPool = NativeUI.CreatePool()
local mainMenu
local custom_washing


Citizen.CreateThread(function()
    while true do

        _menuPool:ProcessMenus()

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
		for k,v in pairs(Config.WashingLocations) do
			if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 1.5 then
		ShowInputNotification(Translation[Config.Locale]['open_menu']) end
        if IsControlJustReleased(0, 38) then
		if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < 1.5 then
            
			openMenu()
            else

            end
        end end

        Citizen.Wait(1)

    end
	
end)

function openMenu()
    mainMenu = NativeUI.CreateMenu(Translation[Config.Locale]['dealer'], Translation[Config.Locale]['dealer_subtitle'])
    _menuPool:Add(mainMenu)
	
	if Config.Framework == 'ESX' then
		local moneyshow = NativeUI.CreateItem(Translation[Config.Locale]['money_in_cash'], '')
    	mainMenu:AddItem(moneyshow)
	
		local empty = NativeUI.CreateItem('', '')
    	mainMenu:AddItem(empty)
	end

    local firstwash = NativeUI.CreateItem(Translation[Config.Locale]['firstone'], '') 
    mainMenu:AddItem(firstwash)
	
	local secondwash = NativeUI.CreateItem(Translation[Config.Locale]['secondone'], '') 
    mainMenu:AddItem(secondwash)
	
	local tripplewash = NativeUI.CreateItem(Translation[Config.Locale]['tripple'], '') 
    mainMenu:AddItem(tripplewash)
	
	local empty2 = NativeUI.CreateItem('', '')
    mainMenu:AddItem(empty2)
	
	local customwash = NativeUI.CreateItem(Translation[Config.Locale]['custom_washing_button'], '') 
    mainMenu:AddItem(customwash)
	
	if Config.Framework == 'ESX' then
    	ESX.TriggerServerCallback('mfp_moneywash:getMoney', function(money)
		   moneyshow:RightLabel('~r~$' .. money .. ',00')
		end)
	end
	

    firstwash.Activated = function(sender, index)
        TriggerServerEvent('mfp_moneywash:washMoney', 500)


		
		
    end
	secondwash.Activated = function(sender, index)
        TriggerServerEvent('mfp_moneywash:washMoney', 5000)


		
		
    end
	tripplewash.Activated = function(sender, index)
        TriggerServerEvent('mfp_moneywash:washMoney', 10000)


		
		
    end
	customwash.Activated = function(sender, index)
	    mainMenu:Visible(false)
		custom_washing()

		
		
    end
	

    mainMenu:Visible(true)

    _menuPool:MouseEdgeEnabled(false)
end


function ShowInputNotification(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    for k in pairs(Config.Npc) do
       RequestModel(GetHashKey("s_m_y_ammucity_01"))
       while not HasModelLoaded(GetHashKey("s_m_y_ammucity_01")) do
         Citizen.Wait(1)
       end
       local ped =  CreatePed(4, GetHashKey("s_m_y_ammucity_01"), Config.Npc[k].x, Config.Npc[k].y, Config.Npc[k].z, Config.Npc[k].h, false, true)
       TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, 1)
       FreezeEntityPosition(ped, true)
       SetEntityHeading(ped, Config.Npc[k].h, true)
       SetEntityInvincible(ped, true)
       SetBlockingOfNonTemporaryEvents(ped, true)
    end
end)

function custom_washing() 
	local amount = KeyboardInput("MFP_MONEYWASH_AMOUNT", Translation[Config.Locale]['custom_washing_text'], "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('mfp_moneywash:washMoney', amount)
		end
	end
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end