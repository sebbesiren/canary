local hazard = Hazard.new({
	name = "hazard.ingol",
	from = Position(33666, 32447, 10),
	to = Position(33805, 32602, 10),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)
hazardZone:addArea({x = 33665, y = 32482, z = 9}, {x = 33821, y = 32604, z = 9})
hazardZone:addArea({x = 33670, y = 32546, z = 8}, {x = 33782, y = 32635, z = 8})


local deathEventName = "IngolDeath"
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

	chanceTo = math.random(1, 400)
	if chanceTo <= 1 then
		local miniBosses = { "Mozradek" }
		spawnCustomHazardBoss(player, monster, miniBosses)
	end

	chanceTo = math.random(0, 150)
	if chanceTo <= 1 and points >= 4 then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()
