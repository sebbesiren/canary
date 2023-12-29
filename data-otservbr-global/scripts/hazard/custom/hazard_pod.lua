local hazardPortalPositions = {}

local function spawnMonster(position, monsterName)
	tile = Tile(position)
	local creature = tile:getBottomCreature()
	if creature then
		position = creature:getClosestFreePosition(position, 4, false)
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	Game.createMonster(monsterName, position, false, true)
end

------ On Step in events
local function dealDamageToPlayer(player)
	player:getPosition():sendMagicEffect(CONST_ME_FIREATTACK)
	local damage = math.ceil(player:getMaxHealth() * 0.3)
	doTargetCombatHealth(0, player, COMBAT_FIREDAMAGE, -damage, -damage, CONST_ME_FIREATTACK)
end

------ Expire events
local function dealDamageToAll(position, monsterName)
	local spectators = Game.getSpectators(position, false, false, 10, 10, 10, 10)
	for _, spectator in ipairs(spectators) do
		if spectator and spectator:isPlayer() then
			position:sendDistanceEffect(spectator:getPosition(), CONST_ME_FIREATTACK)
			dealDamageToPlayer(spectator)
		end
	end
end

local function portalName(position)
	return "spawn_zone.x-" .. position.x .. ",y-" .. position.y .. ",z-" .. position.z
end

local function otherPortalTooClose(position)
	for _, portalPos in ipairs(hazardPortalPositions) do
		if portalPos.z == position.z and math.abs(portalPos.x - position.x) < 40 and math.abs(portalPos.y - position.y) < 40 then
			return true
		end
	end
	return false
end

local function spawnPortal(position, monsterName)
	local tile = Tile(position)
	if not tile then
		return
	end

	local portalId = 25051
	local existingPortal = tile:getItemById(portalId)
	if existingPortal then
		return
	end

	Game.createItem(portalId, 1, position)
	local name = portalName(position)
	local fromPos = Position(position.x - 4, position.y - 4, position.z)
	local toPos = Position(position.x + 4, position.y + 4, position.z)
	local spawnZone = SpawnZone(name, fromPos, toPos)
	spawnZone:setPeriod("120s")
	spawnZone:setMonstersPerCluster(2, 8)
	spawnZone:configureMonster(monsterName, 1)
	spawnZone:register()
	table.insert(hazardPortalPositions, position)
end

local function spawnFewEnemies(position, monsterName)
	---- 4 enemies
	for i = 1, 4 do
		spawnMonster(position, monsterName)
	end
end

local function spawnManyEnemies(position, monsterName)
	---- 8 enemies
	for i = 1, 8 do
		spawnMonster(position, monsterName)
	end
end

local function hazardPodExpire(position, monsterName)
	local tile = Tile(position)
	if tile then
		local podItem = tile:getItemById(ITEM_PRIMAL_POD)
		if podItem then
			local expireEvents = { dealDamageToAll, dealDamageToAll, spawnFewEnemies, spawnFewEnemies, spawnManyEnemies, spawnManyEnemies }

			if not otherPortalTooClose(position) then
				table.insert(expireEvents, spawnPortal)
			end

			local event = expireEvents[math.random(#expireEvents)]
			event(position, monsterName)
			podItem:remove()
		end
	end
end

local function hazardPodOnStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	local tile = Tile(position)
	if not tile then
		return
	end

	local podItem = tile:getItemById(ITEM_PRIMAL_POD)
	if not podItem then
		return
	end

	podItem:remove()
	local events = { dealDamageToPlayer }
	local event = events[math.random(#events)]
	event(player)
	return true
end

function createHazardPod(position, monsterName)
	local hazardPod = Game.createItem(ITEM_PRIMAL_POD, 1, position)
	if hazardPod then
		local podPosition = hazardPod:getPosition()
		addEvent(hazardPodExpire, 4000, podPosition, monsterName)
		local hazardPodEvent = MoveEvent()
		hazardPodEvent.onStepIn = hazardPodOnStepIn
		hazardPodEvent:position(position)
		hazardPodEvent:register()
	end
end
