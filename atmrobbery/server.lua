local QBCore = exports['qb-core']:GetCoreObject()
local Cooldown = false
local cashA = 50
local cashB = 150


-- hack
QBCore.Functions.CreateUseableItem('hacking_device', function(source)
	local Player = QBCore.Functions.GetPlayer(source)
   TriggerClientEvent('hack:hacking_device',source)
end)

-- Recompensa
RegisterServerEvent("atmrobbery:success")
AddEventHandler("atmrobbery:success",function()
    local src = source
	local Player =  QBCore.Functions.GetPlayer(source)
    local bags = 1
	local info = {
		worth = math.random(cashA, cashB)
	}
	Player.Functions.AddItem('markedbills', bags, false, info)
	--Player.Functions.AddItem("markedbills", tonumber(reward))
    Player.Functions.RemoveItem("hacking_device", 1)
	--TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["markedbills"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
end)

-- Cooldown
RegisterServerEvent('atmrobbery:Server:BeginCooldown')
AddEventHandler('atmrobbery:Server:BeginCooldown', function()
    Cooldown = true
    local timer = 60 * 1000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

QBCore.Functions.CreateCallback("atmrobbery:Cooldown",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false)
        
    end
end)
