function spawnCustomHazardBoss(player, monster, bosses)
	if player:kv():get("hazard-boss-deactivated") == true then
		return true
	end

	local closestFreePosition = player:getClosestFreePosition(monster:getPosition(), 4, true)

	local boss = bosses[math.random(#bosses)]
	local boss_monster = Game.createMonster(boss, closestFreePosition.x == 0 and monster:getPosition() or closestFreePosition, false, true)
	if boss_monster then
		boss_monster:say(boss .. " is hunting you. Kill him in order to raise your hazard level!")
	end
	return true
end

function executeLevelUpEvent(points, maxRoll)
	maxRoll = maxRoll or 300
	maxRoll = maxRoll - (points - 1) * 5

	local chanceTo = math.random(1, maxRoll)
	return chanceTo <= 1
end

function executeSpawnLootGoblin(points, monster)
	local monsterHealthPoints = math.floor(monster:getMaxHealth() / 1500)

	if monsterHealthPoints < 1 then
		return false
	end

	local totalPoints = points + monsterHealthPoints

	local chanceTo = math.random(1, 10000)
	return chanceTo <= totalPoints
end

function spawnLootGoblin(player, monster)
	local closestFreePosition = player:getClosestFreePosition(monster:getPosition(), 4, true)

	local boss = "Loot Goblin"
	local boss_monster = Game.createMonster(boss, closestFreePosition.x == 0 and monster:getPosition() or closestFreePosition, false, true)
	if boss_monster then
		boss_monster:say("Shiny shinies, all mine-mine! You'll never catch me, greedy hands!")
	end
	return true
end
