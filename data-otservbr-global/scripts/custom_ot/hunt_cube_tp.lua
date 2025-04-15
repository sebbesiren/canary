local huntCube = Action()

local config = {
	price = 1000,
	hunts = {
		{ name = "Demonwar Crypt", teleport = Position(33259, 31939, 15) },
	},
}

local function huntCubeMessage(player, effect, message)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	player:getPosition():sendMagicEffect(effect)
end

function huntCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)
	local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)

	if not inPz and inFight then
		huntCubeMessage(player, CONST_ME_POFF, "You can't use this when you're in a fight.")
		return false
	end

	if player:getMoney() + player:getBankBalance() < config.price then
		huntCubeMessage(player, CONST_ME_POFF, "You don't have enough money.")
		return false
	end

	local window = ModalWindow({
		title = "Hunt Portal Cube",
		message = "Select a Hunt - Price: " .. config.price .. " gold.",
	})

	for _, town in pairs(config.hunts) do
		if town.name then
			window:addChoice(town.name, function(player, button, choice)
				if button.name == "Select" then
					player:teleportTo(town.teleport, true)
					player:removeMoneyBank(config.price)
					huntCubeMessage(player, CONST_ME_TELEPORT, "Welcome to " .. town.name)
				end
				return true
			end)
		end
	end

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)

	return true
end

huntCube:id(36827)
huntCube:register()
