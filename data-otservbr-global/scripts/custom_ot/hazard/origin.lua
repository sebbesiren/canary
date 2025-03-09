local hazard = Hazard.new({
	name = "hazard.origin",
	from = Position(5067, 4907, 11),
	to = Position(5096, 4928, 11),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

local deathEventName = "OriginDeath"
local spawnEvent = ZoneEvent(hazardZone)
function spawnEvent.onSpawn(monster, position)
	monster:registerEvent(deathEventName)
end
--function spawnEvent.afterEnter(zone, creature)
--	local player = creature:getPlayer()
--	if not player then
--		return
--	end
--
--	hazard:setPlayerCurrentLevel(player, 1)
--end
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

	math.randomseed(os.clock())
	-- Level up if monster is a boss

	local position = monster:getPosition()
	local chanceTo = math.random(1, 40)
	if chanceTo <= 1 then
		position:sendMagicEffect(CONST_ME_TELEPORT)
		local newMonster = Game.createMonster(monster:getName(), position, false, true)
		local influencedLevel = math.random(1, 15)

		if influencedLevel == 15 then
			Game.makeFiendishMonster(newMonster:getId(), true)
		else
			-- If it's reached the limit, we'll remove one to add the new one.
			if ForgeMonster:exceededMaxInfluencedMonsters() then
				local influencedMonster = Monster(ForgeMonster:pickInfluenced())
				if influencedMonster then
					Game.removeInfluencedMonster(influencedMonster:getId())
				end
			end
			Game.addInfluencedMonster(newMonster)
			newMonster:setForgeStack(influencedLevel)
		end
		newMonster:say("I've risen again, stronger than ever!")
	end

	local monsterMaxHealth = monster:getMaxHealth()
	chanceTo = math.random(1, 30)
	if chanceTo <= 1 then
		local totems = {
			"hazard death totem",
			"hazard fire totem",
		}
		local totem = Game.createMonster(totems[math.random(#totems)], position, false, true)
		if totem and totem:getMaxHealth() > monsterMaxHealth then
			totem:setMaxHealth(monsterMaxHealth)
			totem:setHealth(monsterMaxHealth)
		end
	end

	local multiplier = math.min(1, 15000 / monsterMaxHealth)
	local baseChance = math.max(300, 500 - points * 10)

	chanceTo = math.random(1, math.ceil(baseChance * multiplier))
	if chanceTo <= 1 then
		local bosses = {
			"Urmahlullu the Immaculate",
			"Count Vlarkorth",
			"Duke Krule",
			"Sir Baeloc",
			"Mitmah Vanguard",
		}

		if monsterMaxHealth > 2500 then
			for _ = 1, 6 do
				table.insert(bosses, "Balrog")
				table.insert(bosses, "Mitmah Vanguard")
				table.insert(bosses, "The Rootkraken")
				table.insert(bosses, "Death Lord Athelstan")
			end
		end
		if monsterMaxHealth > 5000 then
			for _ = 1, 4 do
				table.insert(bosses, "Balrog")
				table.insert(bosses, "The Rootkraken")
				table.insert(bosses, "Death Lord Athelstan")
			end
		end
		if monsterMaxHealth > 7500 then
			table.insert(bosses, "Apocalypse")
		end
		if monsterMaxHealth > 15000 then
			for _ = 1, 15 do
				table.insert(bosses, "Hellchaser Heip")
			end
		end

		local bossName = bosses[math.random(#bosses)]
		attemptStartUberBoss(bossName)
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
