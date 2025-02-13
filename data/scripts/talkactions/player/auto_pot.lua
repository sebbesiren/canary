-- Usage talkaction: "!automanapot mana potion / off" will auto pop mana potions for you
local autopot = TalkAction("!autopot")

local pots = {
	["mana potion"] = { clientId = 268, cost = 56 },
	["strong mana potion"] = { clientId = 237, cost = 93 },
	["great mana potion"] = { clientId = 238, cost = 144 },
	["ultimate mana potion"] = { clientId = 23373, cost = 438 },
	["health potion"] = { clientId = 266, cost = 50 },
	["strong health potion"] = { clientId = 236, cost = 115 },
	["great health potion"] = { clientId = 239, cost = 225 },
	["ultimate health potion"] = { clientId = 7643, cost = 379 },
	["supreme health potion"] = { clientId = 23375, cost = 625 },
	["great spirit potion"] = { clientId = 7642, cost = 228 },
	["ultimate spirit potion"] = { clientId = 23374, cost = 438 },
}

local availablePots = {}
for key, _ in pairs(pots) do
	table.insert(availablePots, key)
end

local function autoPotLoop(player)
	local potNames = player:kv():scoped("auto-pot"):get("pot")

	local nextDelay = 200

	for _, potName in ipairs(potNames) do
		local pot = pots[potName]

		if not pot then
			return true
		end

		local playerBalance = player:getMoney() + player:getBankBalance()
		if pot.cost > playerBalance then
			player:sendCancelMessage("You dont have enough money")
			return true
		end

		if not player:canDoPotionAction() then
			goto continue
		end

		local checkMana = string.find(potName, "mana") or string.find(potName, "spirit")
		local checkHealth = string.find(potName, "health") or string.find(potName, "spirit")

		local usePot = true
		if checkMana and checkHealth then
			usePot = player:getMana() / player:getMaxMana() < 0.75 or player:getHealth() / player:getMaxHealth() < 0.75
		elseif checkHealth then
			usePot = player:getHealth() / player:getMaxHealth() < 0.75
		elseif checkMana then
			usePot = player:getMana() / player:getMaxMana() < 0.75
		end

		if not usePot then
			goto continue
		end

		local item = player:findItemInInbox(pot.clientId)

		if item == nil then
			player:removeMoneyBank(pot.cost, true)
			player:addItemStoreInbox(pot.clientId, 1, true, false)
			item = player:findItemInInbox(pot.clientId)
		end

		if item then
			if onUsePotion(player, item, { x = CONTAINER_POSITION }, player) then
				player:setNextPotionAction(configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL))
				nextDelay = configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL) + 50
				break
			end
		end

		:: continue ::
	end

	addEvent(function()
		autoPotLoop(player)
	end, nextDelay)

end

function autopot.onSay(player, words, param)
	logger.debug("!autopot executed")

	local param_parts = param:split(",")

	if param_parts[1]:lower() == "off" then
		player:kv():scoped("auto-pot"):set("pot", "off")
	else
		local potNames = {
			string.trim(param_parts[1]:lower())
		}

		if #param_parts > 1 then
			table.insert(potNames, string.trim(param_parts[2]:lower()))
		end

		for _, potName in ipairs(potNames) do
			if not pots[potName] then
				for k, _ in pairs(pots) do
					player:sendTextMessage(MESSAGE_LOOK, k)
				end
				player:sendTextMessage(MESSAGE_LOOK, "Unknown pot. Allowed pots: " .. table.concat(availablePots, ", "))
				return true
			end
		end

		player:kv():scoped("auto-pot"):set("pot", potNames)
		player:sendTextMessage(MESSAGE_LOOK, "Activated auto pots: " .. table.concat(potNames, ", "))
		autoPotLoop(player)
	end

	return true
end

autopot:separator(" ")
autopot:groupType("normal")
autopot:register()
