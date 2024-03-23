local hazard = Hazard.new({
	name = "hazard.issavi-surface",
	from = Position(33917, 31541, 7),
	to = Position(33978, 31687, 7),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)
hazardZone:addArea({ x = 33895, y = 31554, z = 7 }, { x = 33917, y = 31685, z = 7 })
hazardZone:addArea({ x = 33874, y = 31564, z = 7 }, { x = 33895, y = 31684, z = 7 })
hazardZone:addArea({ x = 33761, y = 31664, z = 7 }, { x = 33924, y = 31767, z = 7 })
hazardZone:addArea({ x = 33847, y = 31605, z = 7 }, { x = 33912, y = 31672, z = 7 })

local deathEventName = "IssaviSurfaceDeath"
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

	-- Level up if monster is a boss
	if monster:getType():isRewardBoss() then
		onDeathForDamagingPlayers(creature, function(creature, damagingPlayer)
			attemptLevelUpPlayer(hazard, damagingPlayer, points)
		end)

		return true
	end

	local miniBosses = { "Yirkas Blue Scales" }

	if executeLevelUpEvent(points) then
		spawnCustomHazardBoss(player, monster, miniBosses)
	end

	if executeCreateHazardPod(points) then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()
