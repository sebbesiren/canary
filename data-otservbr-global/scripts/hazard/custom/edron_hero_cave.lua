local hazard = Hazard.new({
	name = "hazard.edron-hero-cave",
	from = Position(33240, 31520, 9),
	to = Position(33370, 31626, 10),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
})
Game.createMonster("Hazard Guide", Position(33266, 31595, 9))

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

local deathEventName = "EdronHeroCaveDeath"
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
		local miniBosses = { "Shadowpelt", "Black Vixen", "Bloodback", "Sharpclaw" }
		local closestFreePosition = player:getClosestFreePosition(monster:getPosition(), 4, true)

		local boss = miniBosses[math.random(#miniBosses)]
		local boss_monster = Game.createMonster(boss, closestFreePosition.x == 0 and monster:getPosition() or closestFreePosition, false, true)
		if boss_monster then
			boss_monster:say(boss .. " has joined the fight.")
		end
	end

	chanceTo = math.random(0, 100)
	if chanceTo <= 1 and points >= 4 then
		createHazardPod(monster:getPosition(), monster:getName())
	end
	return true
end
deathEvent:register()
