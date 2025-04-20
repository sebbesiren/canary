local huntCube = Action()

local config = {
	price = 1000,
	hunts = {
		{ name = "Demonwar Crypt", teleport = Position(33259, 31939, 15) },
		{ name = "Gnomprona", teleport = Position(33547, 32908, 15) }, -- Central Gnomprona area
		{ name = "Asuras", teleport = Position({ x = 32949, y = 32691, z = 7 }) }, -- Asura Palace in Port Hope
		{ name = "Walls", teleport = Position({ x = 33034, y = 31176, z = 6 }) }, -- Wall area near Darashia
		{ name = "Warzones", teleport = Position(32796, 31765, 10) }, -- Warzone entrance in Thais area
		{ name = "Prison", teleport = Position({ x = 33514, y = 32381, z = 11 }) }, -- Thais prison underground
		{ name = "Oramond Sewers", teleport = Position({ x = 33575, y = 31926, z = 7 }) }, -- Rathleton sewers
		{ name = "Oramond Catacombs", teleport = Position({ x = 33458, y = 31715, z = 9 }) }, -- Below Rathleton
		{ name = "Inquisition", teleport = Position({ x = 33192, y = 31689, z = 14 }) }, -- Inquisition quest area
		{ name = "Summercourt", teleport = Position({ x = 33672, y = 32231, z = 7 }) }, -- Feyrist surface
		{ name = "Wintercourt", teleport = Position({ x = 33680, y = 32154, z = 7 }) }, -- Feyrist underground
		{ name = "Turtles Laguna Island", teleport = Position({ x = 32440, y = 32973, z = 7 }) }, -- Liberty Bay turtle island
		{ name = "Edron Heroes", teleport = Position({ x = 33227, y = 31651, z = 7 }) }, -- Hero Cave in Edron
		{ name = "Edron Vampire Crypt", teleport = Position({ x = 32991, y = 31628, z = 10 }) }, -- Vampire Crypt in Edron
		{ name = "Grimvale", teleport = Position({ x = 33341, y = 31694, z = 7 }) }, -- Grimvale island surface
		{ name = "Deeper Banuta", teleport = Position({ x = 32892, y = 32632, z = 11 }) }, -- Banuta underground in Port Hope
		{ name = "Medusa Tower", teleport = Position({ x = 32863, y = 32828, z = 7 }) }, -- Medusa area in Darashia
		{ name = "Wyrms Drefia", teleport = Position({ x = 33067, y = 32397, z = 12 }) }, -- Drefia wyrm caves
		{ name = "Mother of Scarabs Lair", teleport = Position({ x = 33353, y = 32612, z = 10 }) }, -- Ankrahmun scarab lair
		{ name = "Yielothax", teleport = Position({ x = 33143, y = 31532, z = 3 }) }, -- Yielothax dimension
		{ name = "Edron Demons", teleport = Position({ x = 33211, y = 31642, z = 13 }) }, -- Demon cave in Edron
		{ name = "Falcons", teleport = Position(33363, 31343, 7) }, -- Falcon Bastion
		{ name = "Lion Sanctum", teleport = Position({ x = 33123, y = 32234, z = 12 }) }, -- Lion Sanctum in Darashia
		{ name = "Plains of Havoc", teleport = Position({ x = 32755, y = 32307, z = 7 }) }, -- Central PoH near Venore
		{ name = "Mintwallin", teleport = Position({ x = 32495, y = 32104, z = 15 }) }, -- Minotaur city under Thais
		{ name = "Orc Fortress", teleport = Position({ x = 32865, y = 31772, z = 7 }) }, -- Orc Fortress near Thais
		{ name = "Vengoth", teleport = Position({ x = 32953, y = 31490, z = 6 }) }, -- Vengoth castle entrance
		{ name = "Soulpit", teleport = Position({ x = 32375, y = 31164, z = 8 }) },
		{ name = "Drefia Grim Reapers", teleport = Position({ x = 33029, y = 32450, z = 11 }) },
		{ name = "Nightmare Isles", teleport = Position({ x = 33496, y = 32616, z = 8 }) },
		{ name = "Secret Library", teleport = Position(32522, 32537, 12) },
	},
}

local function huntCubeMessage(player, effect, message)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
	player:getPosition():sendMagicEffect(effect)
end

local function ensureLocationsArePzMarked()
	for _, hunt in pairs(config.hunts) do
		local position = hunt.teleport
		local tile = Tile(position)
		if tile and not tile:hasFlag(TILESTATE_PROTECTIONZONE) then
			tile:setFlag(TILESTATE_PROTECTIONZONE)
			Game.createItem(23717, 1, position) -- Emerald carpet (green for protection zone)
		end
	end
end

function huntCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	ensureLocationsArePzMarked()

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
