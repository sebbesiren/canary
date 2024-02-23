local hazard = Hazard.new({
	name = "hazard.ankrahmun-mother-scarabs",
	from = Position(33312, 32579, 11),
	to = Position(33396, 32693, 12),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})
-- {x = 33312, y = 32579, z = 11}
-- {x = 33396, y = 32693, z = 12}

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

local deathEventName = "AnkrahmunScarabDeath"
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
			if hazard:getPlayerMaxLevel(damagingPlayer) == points then
				hazard:levelUp(damagingPlayer)
			end
		end)

		return true
	end

	local miniBosses = { "Fleshcrawler" }

	if executeLevelUpEvent(points) then
		spawnCustomHazardBoss(player, monster, miniBosses)
	end

	if executeCreateHazardPod(points) then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()
