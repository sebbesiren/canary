local hazardPortals = {}
local hazardPortalArtefacts = { 24228, 19135 }

local function spawnMonster(position, monsterName)
	tile = Tile(position)
	local creature = tile:getBottomCreature()
	if creature then
		position = creature:getClosestFreePosition(position, 4, false)
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	local monster = Game.createMonster(monsterName, position, false, true)
	if monster then
		chanceTo = math.random(1, 1000)
		if chanceTo <= 5 then
			Game.makeFiendishMonster(monster:getId(), true)
		elseif chanceTo <= 50 then
			local influencedMonster = Monster(ForgeMonster:pickInfluenced())
			-- If it's reached the limit, we'll remove one to add the new one.
			if ForgeMonster:exceededMaxInfluencedMonsters() then
				if influencedMonster then
					Game.removeInfluencedMonster(influencedMonster:getId())
				end
			end
			local influencedLevel = math.random(1, 14)
			Game.addInfluencedMonster(monster)
			monster:setForgeStack(influencedLevel)
		end
	end
end

------ On Step in events
local function dealDamageToPlayer(player)
	player:getPosition():sendMagicEffect(CONST_ANI_SUDDENDEATH)
	local damage = math.ceil(player:getMaxHealth() * 0.2)
	doTargetCombatHealth(0, player, COMBAT_DEATHDAMAGE, -damage, -damage, COMBAT_DEATHDAMAGE)
end

------ Expire events
--local function dealDamageToAll(position, monsterName)
--	local spectators = Game.getSpectators(position, false, false, 10, 10, 10, 10)
--	for _, spectator in ipairs(spectators) do
--		if spectator and spectator:isPlayer() then
--			position:sendDistanceEffect(spectator:getPosition(), CONST_ME_FIREATTACK)
--			dealDamageToPlayer(spectator)
--		end
--	end
--end

local function portalName(position)
	return "spawn_zone.x-" .. position.x .. ",y-" .. position.y .. ",z-" .. position.z
end

local function otherPortalTooClose(position)
	local portalMinDistance = 20
	for _, portal in ipairs(hazardPortals) do
		local portalPos = portal.position
		if portalPos.z == position.z and math.abs(portalPos.x - position.x) < portalMinDistance and math.abs(portalPos.y - position.y) < portalMinDistance then
			return true
		end
	end
	return false
end

local function removePortal()
	local hazardPortal = hazardPortals[1]
	hazardPortal.spawnZone:unregister()
	local position = hazardPortal.position
	local tile = Tile(position)
	for _, artefactId in ipairs(hazardPortalArtefacts) do
		local gameArtefact = tile:getItemById(artefactId)
		gameArtefact:remove()
	end

	table.remove(hazardPortals, 1)
end

local function spawnPortal(position, monsterName)
	local tile = Tile(position)
	if not tile then
		return
	end

	for _, artefactId in ipairs(hazardPortalArtefacts) do
		Game.createItem(artefactId, 1, position)
	end

	local name = portalName(position)
	local fromPos = Position(position.x - 4, position.y - 4, position.z)
	local toPos = Position(position.x + 4, position.y + 4, position.z)
	local spawnZone = SpawnZone(name, fromPos, toPos)
	spawnZone:setPeriod("60s")
	spawnZone:setMonstersPerCluster(4, 8)
	spawnZone:configureMonster(monsterName, 1)
	spawnZone:register()
	table.insert(hazardPortals, { ["position"] = position, ["spawnZone"] = spawnZone })
	addEvent(removePortal, 1000 * 60 * 60) -- 1h
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

local function originHazard(position, monsterName)
	createOriginHazardTeleport(position, monsterName)
end

local eventScalingFactors = {
	--dealDamageToAll = 50,
	spawnFewEnemies = 100,
	spawnManyEnemies = 200,
}
local events = {
	--dealDamageToAll = dealDamageToAll,
	spawnFewEnemies = spawnFewEnemies,
	spawnManyEnemies = spawnManyEnemies,
	spawnPortal = spawnPortal,
	originHazard = originHazard,
}

-- SELECT EVENT FUNCTIONS
local previousEvent = nil
local function getTotalScale()
	local totalScale = 0
	for _, scale in pairs(eventScalingFactors) do
		totalScale = totalScale + scale
	end
	return totalScale
end

local function selectEvent()
	local totalScale = getTotalScale()
	local randomValue = math.random() * totalScale -- Scale random value by total scale
	local cumulativeScale = 0

	-- Iterate over event scaling factors
	for eventName, scale in pairs(eventScalingFactors) do
		cumulativeScale = cumulativeScale + scale
		if randomValue <= cumulativeScale then
			if eventName == previousEvent then
				previousEvent = nil
				math.randomseed(os.clock())
				return selectEvent()
			else
				previousEvent = eventName
			end

			logger.debug("Event: " .. eventName)
			return events[eventName] -- Return the event name when the scaled random value falls within its range
		end
	end
end

local function insertEvent(eventName, scalingFactor)
	eventScalingFactors[eventName] = scalingFactor
end

local function removeEvent(eventName)
	if eventScalingFactors[eventName] ~= nil then
		eventScalingFactors[eventName] = nil
	end
end

local function hazardPodExpire(position, monsterName)
	local tile = Tile(position)
	if tile then
		local podItem = tile:getItemById(ITEM_PRIMAL_POD)
		if podItem then
			if otherPortalTooClose(position) or monsterName:lower() == "fungosaurus" then
				removeEvent("spawnPortal")
			else
				insertEvent("spawnPortal", 125)
			end

			if originHazardAvailable() and monsterName:lower() ~= "fungosaurus" then
				insertEvent("originHazard", 10)
			else
				removeEvent("originHazard")
			end

			math.randomseed(os.clock())
			local event = selectEvent()
			event(position, monsterName)
			podItem:remove()
		end
	end
end

--local primalPod = MoveEvent()
--
--function primalPod.onStepIn(creature, item, position, fromPosition)
--	local player = creature:getPlayer()
--	if not player then
--		return
--	end
--
--	local tile = Tile(position)
--	if not tile then
--		return
--	end
--
--	local podItem = tile:getItemById(ITEM_PRIMAL_POD)
--	if not podItem then
--		return
--	end
--
--	podItem:remove()
--	dealDamageToPlayer(player)
--	return true
--end
--primalPod:id(ITEM_PRIMAL_POD)
--primalPod:register()

function createHazardPod(position, monsterName)
	local hazardPod = Game.createItem(ITEM_PRIMAL_POD, 1, position)
	if hazardPod then
		local podPosition = hazardPod:getPosition()
		addEvent(hazardPodExpire, 4000, podPosition, monsterName)
	end
end

function executeCreateHazardPod(points, maxRoll)
	--if points < 2 then
	--	return false
	--end
	maxRoll = maxRoll or 75
	maxRoll = maxRoll - points

	if maxRoll < 20 then
		maxRoll = 20
	end

	local chanceTo = math.random(1, maxRoll)
	return chanceTo <= 1
end
