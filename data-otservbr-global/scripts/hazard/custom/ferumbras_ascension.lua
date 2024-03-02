local hazard = Hazard.new({
	name = "hazard.ferumbras-ascension-grimeleech",
	from = Position(33177, 31421, 11),
	to = Position(33250, 31488, 13),
	maxLevel = 20,

	crit = true,
	dodge = true,
	damageBoost = true,
	defenseBoost = true,
})

hazard:register()

local hazardZone = Zone.getByName(hazard.name)
hazardZone:addArea({ x = 33277, y = 32314, z = 14 }, { x = 33362, y = 32406, z = 14 })

-- north
hazardZone:addArea({ x = 33612, y = 32617, z = 10 }, { x = 33686, y = 32725, z = 11 })
hazardZone:addArea({ x = 33606, y = 32612, z = 11 }, { x = 33686, y = 32725, z = 11 })
hazardZone:addArea({ x = 33614, y = 32618, z = 10 }, { x = 33670, y = 32689, z = 10 })

-- north east
hazardZone:addArea({ x = 33606, y = 32616, z = 14 }, { x = 33682, y = 32726, z = 14 })
hazardZone:addArea({ x = 33601, y = 32613, z = 13 }, { x = 33702, y = 32721, z = 13 })
hazardZone:subtractArea({ x = 33603, y = 32662, z = 14 }, { x = 33627, y = 32683, z = 14 })

-- east
hazardZone:addArea({ x = 33378, y = 32418, z = 13 }, { x = 33436, y = 32475, z = 13 })
hazardZone:addArea({ x = 33371, y = 32378, z = 15 }, { x = 33447, y = 32450, z = 15 })

--south east
hazardZone:addArea({ x = 33374, y = 32323, z = 11 }, { x = 33439, y = 32412, z = 11 })
hazardZone:addArea({ x = 33356, y = 32318, z = 13 }, { x = 33438, y = 32386, z = 13 })
hazardZone:addArea({ x = 33376, y = 32320, z = 14 }, { x = 33438, y = 32348, z = 14 })


-- south west
hazardZone:addArea({ x = 33413, y = 32773, z = 8 }, { x = 33498, y = 32830, z = 12 })

-- west
hazardZone:addArea({ x = 33409, y = 32676, z = 13 }, { x = 33499, y = 32761, z = 14 })

local deathEventName = "FerumbrasAscensionGrimeDeath"
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

	local miniBosses = { "The Lord of the Lice", "Bragrumol" }

	if executeLevelUpEvent(points) then
		spawnCustomHazardBoss(player, monster, miniBosses)
	end

	if executeCreateHazardPod(points) then
		createHazardPod(monster:getPosition(), monster:getName())
	end

	return true
end
deathEvent:register()
