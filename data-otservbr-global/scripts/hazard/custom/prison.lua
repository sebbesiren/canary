local hazard = Hazard.new({
	name = "hazard.prison",
	from = Position(33500, 32325, 8),
	to = Position(33630, 32440, 10),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

local deathEventName = "PrisonDeath"
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

	local chanceTo = math.random(1, 10000)
	if chanceTo <= points then
		local raids = { "Gaz", "Omrafir" }
		Game.startRaid(raids[math.random(#raids)])
	end

	chanceTo = math.random(1, 400)
	if chanceTo <= 1 then
		local miniBosses = { "Horadron", "Terofar", "Zavarash" }
		spawnCustomHazardBoss(player, monster, miniBosses)
	end

	chanceTo = math.random(1, 20000)
	if chanceTo <= 1 then
		local miniBosses = { "Prince Drazzak" }
		spawnCustomHazardBoss(player, monster, miniBosses)
	end

	chanceTo = math.random(0, 150)
	if chanceTo <= 1 and points >= 4 then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()