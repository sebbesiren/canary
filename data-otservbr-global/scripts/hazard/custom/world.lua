local hazard = Hazard.new({
	name = "hazard.world",
	from = Position({ x = 1, y = 1, z = 1 }),
	to = Position(34500, 33500, 15),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

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

	local player, points = hazard:getHazardPlayerAndPoints(monster:getDamageMap())
	if points < 1 then
		return true
	end

	if executeLevelUpEvent(points) then
		onDeathForDamagingPlayers(creature, function(creature, damagingPlayer)
			attemptLevelUpPlayer(hazard, damagingPlayer, points)
		end)
	end

	if executeCreateHazardPod(points) then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()

--
--local zoneEvent = ZoneEvent(hazardZone)
--function zoneEvent.afterEnter(zn, creature)
--	local player = creature:getPlayer()
--	if not player then
--		return
--	end
--
--	local worldLevel = math.min(math.floor( player:getLevel() / 50), hazard.maxLevel)
--	hazard:setPlayerMaxLevel(player, worldLevel)
--	player:sendTextMessage(MESSAGE_LOOK, "Maximum hazard level in world set to " .. worldLevel)
--end
--zoneEvent:register()
