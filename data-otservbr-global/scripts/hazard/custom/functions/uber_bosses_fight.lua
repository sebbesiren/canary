local zone = Zone("uber-bosses")

local fromPos = Position(5068, 4799, 11)
local toPos = Position(5089, 4818, 11)

zone:addArea(fromPos, toPos)
zone:blockFamiliars()

local function removePlayers()
	zone:removePlayers()
end

local creatureOnHealthEventName = "UberBossOnHealthEvent"
local creatureOnDeathEventName = "UberBossOnDeathEvent"
local zoneEvent = ZoneEvent(zone)
function zoneEvent.onSpawn(monster, position)
	monster:registerEvent(creatureOnHealthEventName)
	monster:registerEvent(creatureOnDeathEventName)
end
function zoneEvent.afterEnter(zn, creature)
	local player = creature:getPlayer()
	if not player then
		return
	end

	if uberBossAvailable() then
		-- player is there outside of ongoing event
		addEvent(removePlayers, 5 * 1000)
	end
end
zoneEvent:register()

local onHealthEvent = CreatureEvent(creatureOnHealthEventName)
function onHealthEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	local multiplier = 1
	local monster = creature:getMonster()
	if monster then
		local scaleForPlayers = 3
		local countPlayersInZone = #zone:getPlayers()
		multiplier = scaleForPlayers / countPlayersInZone
		logger.debug("The multiplier is {} due to {} players being in zone and scaling around {} players.", multiplier, countPlayersInZone, scaleForPlayers)
	end

	return primaryDamage * multiplier, primaryType, secondaryDamage * multiplier, secondaryType
end
onHealthEvent:register()

local onDeathEvent = CreatureEvent(creatureOnDeathEventName)
function onDeathEvent.onDeath(creature)
	local monster = creature:getMonster()
	if not monster or not monster:getType():isRewardBoss() then
		return true
	end

	local zonePlayers = zone:getPlayers()
	for _, player in ipairs(zonePlayers) do
		player:sendTextMessage(MESSAGE_LOOK, "Congratulations on beating the Boss!! You will be removed from the zone within 30 seconds.")
	end

	addEvent(removePlayers, 30 * 1000)
	return true
end
onDeathEvent:register()
