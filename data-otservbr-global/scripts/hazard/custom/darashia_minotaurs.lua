local hazard = Hazard.new({
	name = "hazard.darashia-minotaurs",
	from = Position(33286, 32273, 5),
	to = Position(33329, 32300, 11),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

local deathEventName = "DarashiaMinoDeath"
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

	chanceTo = math.random(1, 50)
	if chanceTo <= 1 then
		local miniBosses = { "Bovinus" }
		spawnCustomHazardBoss(player, monster, miniBosses)
	end

	--chanceTo = math.random(1, 1000)
	--if chanceTo <= 1 then
	--	local miniBosses = { "The Horned Fox" }
	--	spawnCustomHazardBoss(player, monster, miniBosses)
	--end

	chanceTo = math.random(0, 50)
	if chanceTo <= 1 then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()
