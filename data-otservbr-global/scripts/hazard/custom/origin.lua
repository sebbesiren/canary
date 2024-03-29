local hazard = Hazard.new({
	name = "hazard.origin",
	from = Position(5067, 4907, 11),
	to = Position(5096, 4928, 11),
	maxLevel = 100,

	crit = true,
	dodge = false,
	damageBoost = true,
	defenseBoost = false,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)

local deathEventName = "OriginDeath"
local spawnEvent = ZoneEvent(hazardZone)
function spawnEvent.onSpawn(monster, position)
	monster:registerEvent(deathEventName)
end
function spawnEvent.afterEnter(zone, creature)
	local player = creature:getPlayer()
	if not player then
		return
	end

	hazard:setPlayerCurrentLevel(player, 1)
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

	math.randomseed(os.clock())
	-- Level up if monster is a boss
	local chanceTo = math.random(1, 40)
	if chanceTo <= 1 then
		onDeathForDamagingPlayers(creature, function(creature, damagingPlayer)
			if hazard:getPlayerMaxLevel(damagingPlayer) == points then
				hazard:levelUp(damagingPlayer)
			end
			if hazard:setPlayerCurrentLevel(damagingPlayer, points + 1) then
				damagingPlayer:sendTextMessage(MESSAGE_LOOK, "Hazard level set to " .. points + 1)
			end
		end)
	end

	local position = monster:getPosition()
	chanceTo = math.random(1, 40)
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
			"hazard fire totem"
		}
		local totem = Game.createMonster(totems[math.random(#totems)], position, false, true)
		if totem and totem:getMaxHealth() > monsterMaxHealth then
			totem:setMaxHealth(monsterMaxHealth)
			totem:setHealth(monsterMaxHealth)
		end
	end

	chanceTo = math.random(1, 2000)
	if chanceTo <= points then
		local bosses = { "Balrog" }
		if monsterMaxHealth > 3000 then
			table.insert(bosses, "Death Lord Athelstan")
		end
		if monsterMaxHealth > 6000 then
			table.insert(bosses, "Hellchaser Heip")
		end

		local bossName = bosses[math.random(#bosses)]
		attemptStartUberBoss(bossName)
	end

	return true
end
deathEvent:register()
