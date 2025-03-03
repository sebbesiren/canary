local hazard = Hazard.new({
	name = "hazard.world",
	from = Position(31900, 31000, 1),
	to = Position(34000, 33100, 15),
	--to = Position(34000, 33100, 1),
	minLevel = 0,
	maxLevel = 15,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

-- Gnomprona
hazardZone:subtractArea({ x = 33502, y = 32740, z = 13 }, { x = 33796, y = 32996, z = 15 })

-- Nerdherd
hazardZone:addArea({ x = 4000, y = 4000, z = 0 }, { x = 6500, y = 6500, z = 15 })

-- Hazard Origin
hazardZone:subtractArea({ x = 5067, y = 4907, z = 11 }, { x = 5096, y = 4928, z = 11 })

local deathEventName = "WorldHazardDeath"
local spawnEvent = ZoneEvent(hazardZone)
function spawnEvent.onSpawn(monster, position)
	monster:registerEvent(deathEventName)
end
spawnEvent:register()

local deathEvent = CreatureEvent(deathEventName)
function deathEvent.onDeath(creature)
	local monster = creature:getMonster()
	if not creature or not monster or not monster:hazard() or not hazard:isInZone(monster:getPosition()) then
		return true
	end

	-- don't spawn pods if the monster is a reward boss
	if monster:getType():isRewardBoss() then
		return true
	end

	local player, points = hazard:getHazardPlayerAndPoints(monster:getDamageMap())
	if points < 1 then
		return true
	end

	if executeCreateHazardPod(points) then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()

local zoneEvent = ZoneEvent(hazardZone)
function zoneEvent.afterEnter(zn, creature)
	local player = creature:getPlayer()
	if not player then
		return
	end

	hazard:setPlayerMaxLevel(player, hazard.maxLevel)
end
zoneEvent:register()
