local hazard = Hazard.new({
	name = "hazard.rookgard",
	from = Position(31940, 32075, 4),
	to = Position(32200, 32257, 9),
	maxLevel = 45,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

local deathEventName = "RookgardDeath"
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
	if executeLevelUpEvent(points, 100) then
		onDeathForDamagingPlayers(creature, function(creature, damagingPlayer)
			attemptLevelUpPlayer(hazard, damagingPlayer, points)
		end)
	end

	chanceTo = math.random(0, 15)
	if chanceTo <= 1 then
		createHazardPod(monster:getPosition(), Game.getBoostedCreature())
	end

	return true
end
deathEvent:register()
