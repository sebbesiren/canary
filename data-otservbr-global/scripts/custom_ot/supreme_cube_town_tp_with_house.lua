local supremeCube = Action()

local config = {
	price = 1000,
	storage = 9007,
	cooldown = 1,
	towns = {
		{ name = "Hunt - Demonwar Crypt", teleport = Position(33259, 31939, 15) },
		{ name = "Town - Ab'Dendriel", teleport = Position(32732, 31634, 7) },
		{ name = "Town - Ankrahmun", teleport = Position(33194, 32853, 8) },
		{ name = "Town - Carlin", teleport = Position(32360, 31782, 7) },
		{ name = "Town - Darashia", teleport = Position(33213, 32454, 1) },
		{ name = "Town - Edron", teleport = Position(33217, 31814, 8) },
		{ name = "Town - Farmine", teleport = Position(33023, 31521, 11) },
		{ name = "Town - Issavi", teleport = Position(33921, 31477, 5) },
		{ name = "Town - Kazordoon", teleport = Position(32649, 31925, 11) },
		{ name = "Town - Krailos", teleport = Position(33657, 31665, 8) },
		{ name = "Town - Liberty Bay", teleport = Position(32317, 32826, 7) },
		{ name = "Town - Marapur", teleport = Position(33842, 32853, 7) },
		{ name = "Town - Port Hope", teleport = Position(32594, 32745, 7) },
		{ name = "Town - Rathleton", teleport = Position(33594, 31899, 6) },
		{ name = "Town - Roshamuul", teleport = Position(33513, 32363, 6) },
		{ name = "Town - Svargrond", teleport = Position(32212, 31132, 7) },
		{ name = "Town - Thais", teleport = Position(32369, 32241, 7) },
		{ name = "Town - Venore", teleport = Position(32957, 32076, 7) },
		{ name = "Town - Yalahar", teleport = Position(32787, 31276, 7) },
	},
}

local function supremeCubeMessage(player, effect, message)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	player:getPosition():sendMagicEffect(effect)
end

local function houseTp(player, button, choice)
	if button.name == "Select" then
		local playerName = string.match(choice.text, "House %- (.+)")
		local house = nil
		if playerName then
			local otherPlayer = Player(playerName)
			if otherPlayer then
				house = otherPlayer:getHouse()
			end
		else
			house = player:getHouse()
		end

		if house then
			player:teleportTo(house:getExitPosition(), true)
			player:removeMoneyBank(config.price)
			supremeCubeMessage(player, CONST_ME_TELEPORT, "Welcome to your house.")
			player:setStorageValue(config.storage, os.time() + config.cooldown)
		else
			supremeCubeMessage(player, CONST_ME_POFF, "You don't have a house.")
		end
	end
	return true
end

function supremeCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
	local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

	if not inPz and inFight then
		supremeCubeMessage(player, CONST_ME_POFF, "You can't use this when you're in a fight.")
		return false
	end

	if player:getMoney() + player:getBankBalance() < config.price then
		supremeCubeMessage(player, CONST_ME_POFF, "You don't have enough money.")
		return false
	end

	if player:getStorageValue(config.storage) > os.time() then
		local remainingTime = player:getStorageValue(config.storage) - os.time()
		supremeCubeMessage(player, CONST_ME_POFF, "You can use it again in: " .. remainingTime .. " seconds.")
		return false
	end

	local window = ModalWindow({
		title = "Supreme Cube",
		message = "Select a City - Price: " .. config.price .. " gold.",
	})

	for _, town in pairs(config.towns) do
		if town.name then
			window:addChoice(town.name, function(player, button, choice)
				if button.name == "Select" then
					player:teleportTo(town.teleport, true)
					player:removeMoneyBank(config.price)
					supremeCubeMessage(player, CONST_ME_TELEPORT, "Welcome to " .. town.name)
					player:setStorageValue(config.storage, os.time() + config.cooldown)
				end
				return true
			end)
		end
	end

	if player:getHouse() then
		window:addChoice("House", function(player, button, choice)
			return houseTp(player, button, choice)
		end)
	end

	local guild = player:getGuild()
	if guild then
		local membersOnline = guild:getMembersOnline()
		for _, member in ipairs(membersOnline) do
			if player:getGuid() ~= member:getGuid() then
				if member:getHouse() then
					window:addChoice("House - " .. member:getName(), function(member, button, choice)
						return houseTp(member, button, choice)
					end)
				end
			end
		end
	end

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)

	return true
end

supremeCube:id(31633)
supremeCube:register()
