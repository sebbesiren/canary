-- Usage talkaction: "!automanapot mana potion / off" will auto pop mana potions for you
local bosstp = TalkAction("!bosstp")

local bosses = {
	{ name = "Count Vlarkorth", position = Position(33456, 31408, 13), bossRaceId = 1753 },
	{ name = "Lord Azaram", position = Position(33423, 31497, 13), bossRaceId = 1756 },
	{ name = "Earl Osam", position = Position(33517, 31440, 13), bossRaceId = 1757 },
	{ name = "Sir Baeloc", position = Position(33426, 31408, 13), bossRaceId = 1755 },
	{ name = "Duke Krule", position = Position(33456, 31497, 13), bossRaceId = 1758 },
	{ name = "King Zelos", position = Position(33489, 31546, 13), bossRaceId = 1784 },
	{ name = "Scarlett Etzel", position = Position(33395, 32662, 6), bossRaceId = 1804 },
	{ name = "Lady Tenebris", position = Position(32902, 31628, 14), bossRaceId = 1315 },
	{ name = "Lloyd", position = Position(32759, 32873, 14), bossRaceId = 1329 },
	{ name = "Mounted Thorn Knight", position = Position(32657, 32882, 14), bossRaceId = 1297 },
	{ name = "Dragonking Zyrtarch", position = Position(33391, 31183, 10), bossRaceId = 1286 },
	{ name = "Brain Head", position = Position(31973, 32325, 10), bossRaceId = 1862 },
	{ name = "Irgix the Flimsy", position = Position(33492, 31400, 8), bossRaceId = 1890 },
	{ name = "Black Vixen", position = Position(33442, 32052, 9), bossRaceId = 1559 },
	{ name = "Darkfang", position = Position(33055, 31911, 9), bossRaceId = 1558 },
	{ name = "Bloodback", position = Position(33167, 31978, 8), bossRaceId = 1560 },
	{ name = "Timira The Many-Headed", position = Position(33804, 32702, 8), bossRaceId = 2250 },
	{ name = "Urmahlullu", position = Position(33920, 31623, 8), bossRaceId = 1811 },
	{ name = "Faceless Bane", position = Position(33643, 32561, 13), bossRaceId = 1727 },
	{ name = "Grand Master Oberon", position = Position(33364, 31342, 9), bossRaceId = 1576 },
	{ name = "Drume", position = Position(32462, 32508, 6), bossRaceId = 1957 },
	{ name = "The Fear Feaster", position = Position(33739, 31471, 14), bossRaceId = 1873 },
	{ name = "Kroazur", position = Position(33619, 32305, 9), bossRaceId = 1515 },
	{ name = "Ratmiral Blackwhiskers", position = Position(33894, 31386, 15), bossRaceId = 2006 },
	{ name = "Magma Bubble", position = Position(33669, 32933, 15), bossRaceId = 2242 },
	{ name = "Goshnar's Malice", position = Position(33679, 31599, 14), bossRaceId = 1901 },
	{ name = "Goshnar's Greed", position = Position(33776, 31665, 14), bossRaceId = 1905 },
	{ name = "Goshnar's Spite", position = Position(33774, 31634, 14), bossRaceId = 1903 },
	{ name = "Goshnar's Cruelty", position = Position(33854, 31854, 6), bossRaceId = 1902 },
	{ name = "Goshnar's Hatred", position = Position(33773, 31601, 14), bossRaceId = 1904 },
	{ name = "Murcion", position = Position(32978, 32365, 15), bossRaceId = 2362 },
	{ name = "Vemiath", position = Position(33078, 32333, 15), bossRaceId = 2365 },
	{ name = "Chagorz", position = Position(33078, 32367, 15), bossRaceId = 2366 },
	{ name = "Ichgahal", position = Position(32978, 32333, 15), bossRaceId = 2364 },
}

local function sendBossTpModal(player)
	local count = 12
	local cost = 50000

	local window = ModalWindow({
		title = "Boss Teleporter",
		message = "Pay " .. cost / 1000 .. "k gold to teleport to bosses you have at least " .. count .. " points in.",
	})

	local playerBalance = player:getMoney() + player:getBankBalance()

	for _, bossConfig in pairs(bosses) do
		local choiceText = bossConfig.name

		if player:getStorageValue(61305000 + bossConfig.bossRaceId) >= count then
			choiceText = choiceText .. " - OK"
		end

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

			if player:getStorageValue(61305000 + bossConfig.bossRaceId) < count then
				player:sendCancelMessage("You dont have enough boss points")
				return true
			end

			if cost > playerBalance then
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
