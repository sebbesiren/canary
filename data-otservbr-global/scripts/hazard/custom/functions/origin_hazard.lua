local duration = 60 * 10 -- 10 min
local teleportItemId = 32979
local spawnLocations = {
	Position({ x = 5075, y = 4913, z = 11 }),
	Position({ x = 5081, y = 4913, z = 11 }),
	Position({ x = 5088, y = 4913, z = 11 }),
	Position({ x = 5088, y = 4922, z = 11 }),
	Position({ x = 5081, y = 4922, z = 11 }),
	Position({ x = 5075, y = 4922, z = 11 }),
	Position({ x = 5075, y = 4917, z = 11 }),
	Position({ x = 5088, y = 4917, z = 11 }),
}
local entryTeleport = {
	event = MoveEvent(),
	uid = 65534,
}
local hazardKvStore = kv.scoped("hazard")

function originHazardEnded()
	local previousStart = hazardKvStore:scoped("origin-hazard"):get("start") or 0

	local hasEnded = os.time() > previousStart + duration
	if hasEnded then
		return true
	end

	local hazard = Hazard.getByName("hazard.origin")
	local players = hazard.zone:getPlayers()
	if #players == 0 and os.time() > previousStart + 30 then
		return true
	end

	return false
end

function originHazardAvailable()
	local previousStart = hazardKvStore:scoped("origin-hazard"):get("start") or 0
	return os.time() > previousStart + duration
end

local function exitOriginHazard(player)
	local positionBeforeEntry = player:kv():scoped("origin-hazard"):get("position-before-entry") or Position(32369, 32241, 7)
	player:teleportTo(positionBeforeEntry)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

local function removeOriginHazardTeleport()
	--entryTeleport.event:unregister()
	local tile = Tile(entryTeleport.position)
	if tile then
		local teleportItem = tile:getItemById(teleportItemId)
		if teleportItem then
			teleportItem:remove()
		end
	end
end

local function resetOriginHazard()
	local hazard = Hazard.getByName("hazard.origin")
	local players = hazard.zone:getPlayers()
	for _, player in ipairs(players) do
		exitOriginHazard(player)
	end

	local monsters = hazard.zone:getMonsters()
	for _, monster in ipairs(monsters) do
		monster:remove()
	end
	removeOriginHazardTeleport()
	hazardKvStore:scoped("origin-hazard"):set("start", 0)

	local message = "Origin hazard has ended and is now available again."
	Game.broadcastMessage(message, MESSAGE_EVENT_ADVANCE)
	Webhook.sendMessage(":space_invader: " .. message, announcementChannels["raids"])
end

local function spawnMonster(monsterName)
	local time_to_spawn = 2
	local basePosition = spawnLocations[math.random(#spawnLocations)]
	local position = Position(
		math.floor(basePosition.x + math.random(-3, 3) + 0.5), -- makes it round
		math.floor(basePosition.y + math.random(-3, 3) + 0.5), -- makes it round
		basePosition.z
	)

	for i = 1, time_to_spawn do
		addEvent(function()
			position:sendMagicEffect(CONST_ME_TELEPORT)
		end, i * 1000)
	end
	addEvent(function()
		Game.createMonster(monsterName, position, false, true)
	end, time_to_spawn * 1000)
end

local function handleMonsterSpawn(monsterName)
	local hazard = Hazard.getByName("hazard.origin")

	local startTime = hazardKvStore:scoped("origin-hazard"):get("start")
	local elapsedTime = os.time() - startTime

	local monsters = hazard.zone:getMonsters()
	local countMonsters = 0
	for _, monster in ipairs(monsters) do
		local isInfluenced = monster:getForgeStack() > 0

		if monster:getName():lower() == monsterName:lower() and not isInfluenced then
			countMonsters = countMonsters + 1
		end
	end

	local maxMonsters = 12 + math.floor(elapsedTime / 60) -- add another monster every 30th second

	local monstersToSpawn = maxMonsters - #monsters
	if monstersToSpawn < 0 then
		return
	end

	for _ = 1, monstersToSpawn do
		spawnMonster(monsterName)
	end
end

local function originHazardLoop(monsterName)
	if originHazardEnded() then
		resetOriginHazard()
	else
		handleMonsterSpawn(monsterName)

		addEvent(originHazardLoop, 5 * 1000, monsterName)
	end
end

local function startOriginHazard(monsterName)
	local startTime = os.time()
	hazardKvStore:scoped("origin-hazard"):set("start", startTime)
	originHazardLoop(monsterName)
	local message = "A player has entered the Hazard Origins. Next possible event in " .. math.floor(duration / 60) .. " minutes."
	Game.broadcastMessage(message, MESSAGE_EVENT_ADVANCE)
	Webhook.sendMessage(":space_invader: " .. message, announcementChannels["raids"])
end

function createOriginHazardTeleport(position, killedMonsterName)
	if not originHazardAvailable() then
		return false
	end

	teleportItem = Game.createItem(teleportItemId, 1, position)
	teleportItem:setUniqueId(entryTeleport.uid)

	entryTeleport.position = position

	startOriginHazard(killedMonsterName)
end

function entryTeleport.event.onStepIn(creature, item, position, fromPosition)
	logger.debug("entryTeleportOnStepIn")
	local player = creature:getPlayer()
	if not player then
		return
	end

	player:kv():scoped("origin-hazard"):set("position-before-entry", fromPosition)
	local teleportToPosition = Position({ x = 5081, y = 4910, z = 11 })
	player:teleportTo(teleportToPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

	return true
end
entryTeleport.event:uid(65534)
entryTeleport.event:register()

local exit = MoveEvent()
function exit.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	resetOriginHazard()
end
exit:position(Position({ x = 5081, y = 4926, z = 11 }))
exit:register()
