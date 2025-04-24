local lobbyDuration = 60 * 1 -- 1 min
local fightDuration = 60 * 15 -- 15min
local teleportItemId = 25055
local entryLocations = {
	--Position(5080, 4916, 11),
	--Position(5083, 4916, 11),
	--Position(5080, 4919, 11),
	--Position(5083, 4919, 11),
	Position(32345, 32224, 7),
	Position(32369, 32244, 7),
	Position(5005, 4989, 11),
}
local exitLocations = {
	Position(5078, 4809, 11),
}
local uberBossesKvStore = kv.scoped("uber-bosses")

local function sendUberMessage(message)
	Game.broadcastMessage(message, MESSAGE_EVENT_ADVANCE)
	Webhook.sendMessage(":space_invader: " .. message, announcementChannels["raids"])
end

function uberBossAvailable()
	local previousStart = uberBossesKvStore:get("start") or 0
	return os.time() >= previousStart + lobbyDuration + fightDuration - 1 -- safety margin
end

local function createEntryLocation(position)
	teleportItem = Game.createItem(teleportItemId, 1, position)
	teleportItem:setUniqueId(65533)
end

local function createExitLocation(position)
	teleportItem = Game.createItem(teleportItemId, 1, position)
	teleportItem:setUniqueId(65532)
end

local function removeEntryOrExit(position)
	local tile = Tile(position)
	if tile then
		local teleportItem = tile:getItemById(teleportItemId)
		if teleportItem then
			teleportItem:remove()
		end
	end
end

local function endLobby()
	for _, entryLocation in ipairs(entryLocations) do
		removeEntryOrExit(entryLocation)
	end

	for _, exitLocation in ipairs(exitLocations) do
		removeEntryOrExit(exitLocation)
	end
end

function resetUberBosses(bossKilled)
	if not uberBossAvailable() and not bossKilled then
		return -- Another fight is ongoing
	end

	local zone = Zone.getByName("uber-bosses")
	local monsters = zone:getMonsters()
	local players = zone:getPlayers()
	if bossKilled then
		sendUberMessage("The uber boss was killed! You are now able to get the next boss.")
	elseif #monsters >= 1 or #players >= 1 then
		sendUberMessage("The uber boss fight has ended! You are now able to get the next boss.")
	end

	if #players then
		zone:removePlayers()
	end
	if #monsters then
		zone:removeMonsters()
	end
	zone:refresh()
	uberBossesKvStore:set("start", 0)
end

local function createBoss(bossName, position)
	local time_to_spawn = 3
	for i = 1, time_to_spawn do
		addEvent(function()
			position:sendMagicEffect(CONST_ME_TELEPORT)
		end, i * 1000)
	end
	addEvent(function()
		Game.createMonster(bossName, position, false, true)
	end, time_to_spawn * 1000)
end

local function startFight(bossName)
	sendUberMessage("The fight is starting! Take down the boss within " .. fightDuration / 60 .. " minutes!")

	endLobby()
	createBoss(bossName, Position(5078, 4809, 11))
	addEvent(resetUberBosses, fightDuration * 1000, false)
end

function attemptStartUberBoss(bossName)
	if uberBossAvailable() then
		uberBossesKvStore:set("start", os.time())
		sendUberMessage("Lobby has opened for boss " .. bossName .. ". The fight will start in " .. lobbyDuration / 60 .. " minutes.")

		for _, entryLocation in ipairs(entryLocations) do
			createEntryLocation(entryLocation)
		end

		for _, exitLocation in ipairs(exitLocations) do
			createExitLocation(exitLocation)
		end
		addEvent(startFight, lobbyDuration * 1000, bossName)
		return true
	else
		logger.debug("Attempt to start uber boss {} failed", bossName)
		return false
	end
end

local entryEvent = MoveEvent()
function entryEvent.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end
	local toPosition = Position(5078, 4801, 11)
	player:teleportTo(toPosition)
	toPosition:sendMagicEffect(CONST_ME_TELEPORT)

	return true
end
entryEvent:uid(65533)
entryEvent:register()

local exitEvent = MoveEvent()
function exitEvent.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end
	local toPosition = Position(32369, 32241, 7)
	player:teleportTo(toPosition)
	toPosition:sendMagicEffect(CONST_ME_TELEPORT)

	return true
end
exitEvent:uid(65532)
exitEvent:register()

function claimMajorSpellExecute(blockTime)
	blockTime = blockTime or 1
	local nextMajorSpell = uberBossesKvStore:get("next-major-spell") or 0
	local currentTime = os.time()
	if currentTime > nextMajorSpell then
		uberBossesKvStore:set("next-major-spell", currentTime + blockTime)
		return true -- able to cast spell
	end
	return false -- block cast
end
