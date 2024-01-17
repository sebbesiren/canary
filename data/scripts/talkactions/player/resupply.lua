-- Usage talkaction: "!resupply mana potion, 1" will resupply the item if it is available
local resupply = TalkAction("!resupply")

local items = {
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
	["spectral bolt"] = { clientId = 35902, cost = 70 },
	["diamond arrow"] = { clientId = 35901, cost = 100 },
	["sudden death rune"] = { clientId = 3155, cost = 135 },
	["great fireball rune"] = { clientId = 3191, cost = 57 },
	["thunderstorm rune"] = { clientId = 3202, cost = 47 },
	["avalanche rune"] = { clientId = 3161, cost = 57 },
}

function resupply.onSay(player, words, param)
	logger.debug("!resupply executed")

	local param_parts = param:split(",")

	if param_parts[1] == "list" then
		for k, _ in pairs(items) do
			player:sendTextMessage(MESSAGE_LOOK, k)
		end
		player:sendTextMessage(MESSAGE_LOOK, "Check server log for items...")
		return true
	end

	local itemName = param_parts[1]
	local count = getMoneyCount(param_parts[2])
	if count == -1 then
		player:sendTextMessage(MESSAGE_LOOK, "Invalid item count: " .. count)
		return true
	end

	local item = items[itemName]

	if not item then
		for k, _ in pairs(items) do
			player:sendTextMessage(MESSAGE_LOOK, k)
		end
		player:sendTextMessage(MESSAGE_LOOK, "Unknown item. Check server log for available items... ")
		return true
	end

	local playerBalance = player:getMoney() + player:getBankBalance()
	local totalCost = item.cost * count
	if totalCost > playerBalance then
		player:sendCancelMessage("Insufficient balance")
		return true
	end

	local npc = Npc("Runtel Blackspark")
	npc:sellItem(player, item.clientId, count)

	return true
end

resupply:separator(" ")
resupply:groupType("normal")
resupply:register()
