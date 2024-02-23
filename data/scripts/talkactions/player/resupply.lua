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
	["heavy magic missile rune"] = { clientId = 3198, cost = 135 },
	["icicle rune"] = { clientId = 3158, cost = 135 },
	["fireball rune"] = { clientId = 3189, cost = 135 },
	["great fireball rune"] = { clientId = 3191, cost = 57 },
	["thunderstorm rune"] = { clientId = 3202, cost = 47 },
	["avalanche rune"] = { clientId = 3161, cost = 57 },
	["stone shower rune"] = { clientId = 3175, cost = 57 },
	["wild growth rune"] = { clientId = 3156, cost = 160 },
	["energy bomb rune"] = { clientId = 3149, cost = 203 },
	["fire bomb rune"] = { clientId = 3192, cost = 147 },
	["poison bomb rune"] = { clientId = 3173, cost = 85 },
	["backpack"] = { clientId = 2854, cost = 100 },
	["brown mushroom"] = { clientId = 3725, cost = 10 },
}
local availableItems = {}
for key, _ in pairs(items) do
	table.insert(availableItems, key)
end

function resupply.onSay(player, words, param)
	logger.debug("!resupply executed")

	local param_parts = param:split(",")

	if param_parts[1] == "list" then
		player:sendTextMessage(MESSAGE_LOOK, table.concat(availableItems, ", "))
		return true
	end

	local itemName = param_parts[1].lower()
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
		player:sendTextMessage(MESSAGE_LOOK, "Unknown item. Allowed items: " .. table.concat(availableItems, ", "))
		return true
	end

	local playerBalance = player:getMoney() + player:getBankBalance()
	local totalCost = item.cost * count
	if totalCost > playerBalance then
		player:sendCancelMessage("You dont have enough money")
		return true
	end

	player:removeMoneyBank(totalCost)
	player:addItem(item.clientId, count)

	return true
end

resupply:separator(" ")
resupply:groupType("normal")
resupply:register()
