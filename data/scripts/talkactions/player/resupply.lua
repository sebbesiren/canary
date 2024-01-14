-- Usage talkaction: "!resupply mana potion, 1" will resupply the item if it is available
local resupply = TalkAction("!resupply")

local items = {
	["mana potion"] = { clientId = 268 },
	["strong mana potion"] = { clientId = 237 },
	["great mana potion"] = { clientId = 238 },
	["ultimate mana potion"] = { clientId = 23373 },
	["health potion"] = { clientId = 266 },
	["strong health potion"] = { clientId = 236 },
	["great health potion"] = { clientId = 239 },
	["ultimate health potion"] = { clientId = 7643 },
	["supreme health potion"] = { clientId = 23375 },
	["great spirit potion"] = { clientId = 7642 },
	["ultimate spirit potion"] = { clientId = 23374 },
	["spectral bolt"] = { clientId = 35902 },
	["diamond arrow"] = { clientId = 35901 },
	["sudden death rune"] = { clientId = 3155 },
	["great fireball rune"] = { clientId = 3191 },
	["thunderstorm rune"] = { clientId = 3202 },
	["avalanche rune"] = { clientId = 3161 },
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
	end

	local npc = Npc("Runtel Blackspark")

	npc:sellItem(player, item.clientId, count)

	return true
end

resupply:separator(" ")
resupply:groupType("normal")
resupply:register()
