-- Usage talkaction: "!automanapot mana potion / off" will auto pop mana potions for you
local bosstp = TalkAction("!bosstp")

local bosses = {
	{
		name = "Scarlett Etzel",
		position = Position(33395, 32670, 6),
		storage = 61305000 + 1804,
		count = 12,
		cost = 200000,
	},
	{
		name = "Timira The Many-Headed",
		position = Position(33803, 32700, 7),
		storage = 61305000 + 2250,
		count = 12,
		cost = 200000,
	},
	{
		name = "Grand Master Oberon",
		position = Position(33364, 31344, 9),
		storage = 61305000 + 1576,
		count = 12,
		cost = 200000,
	},
	{
		name = "Faceless Bane",
		position = Position(33638, 32562, 13),
		storage = 61305000 + 1727,
		count = 12,
		cost = 200000,
	},
	{
		name = "Drume",
		position = Position(32457, 32508, 6),
		storage = 61305000 + 1957,
		count = 12,
		cost = 200000,
	},
	{
		name = "Urmahlullu",
		position = Position(33918, 31626, 8),
		storage = 61305000 + 1811,
		count = 12,
		cost = 200000,
	},
}

local function sendBossTpModal(player)
	local window = ModalWindow({
		title = "Boss Teleporter",
		message = "Costs " .. cost .. "g and requires  " .. count .. " boss points.",
	})

	local playerBalance = player:getMoney() + player:getBankBalance()

	for _, bossConfig in pairs(bosses) do
		local choiceText = bossConfig.name
		window:addChoice(choiceText, function(player, button, choice)
			if button.name ~= "Select" then
				return true
			end

			local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
			local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
			if not inPz and inFight then
				player:sendCancelMessage("Unable to tp while in combat")
				return true
			end

			if player:getStorageValue(bossConfig.storage) < bossConfig.count then
				player:sendCancelMessage("You dont have enough boss points")
				return true
			end

			if bossConfig.cost > playerBalance then
				player:sendCancelMessage("You dont have enough money")
				return true
			end

			player:removeMoneyBank(cost)
			player:teleportTo(bossConfig.position)
		end)
	end

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

function bosstp.onSay(player, words, param)
	logger.debug("!bosstp executed")
	sendBossTpModal(player)
	return true
end

bosstp:separator(" ")
bosstp:groupType("normal")
bosstp:register()
