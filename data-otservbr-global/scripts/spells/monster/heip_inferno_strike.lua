local spell = Spell("instant")

local area = {
	--{
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	--}
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
}
local combat = Combat()
function onTargetTile(creature, position)
	local tile = Tile(position)
	local creatures = tile:getCreatures()
	if creatures and #creatures > 0 then
		for _, c in pairs(creatures) do
			local player = Player(c)
			if player then
				local multiplier = 1
				local voc = player:getVocation():getBaseId()
				if voc == VOCATION.BASE_ID.SORCERER or voc == VOCATION.BASE_ID.DRUID then
					multiplier = 4
				elseif voc == VOCATION.BASE_ID.PALADIN then
					multiplier = 2
				elseif voc == VOCATION.BASE_ID.KNIGHT then
					multiplier = 1
				end

				local soakMultiplier = 20 -- no soak
				local spectators = Game.getSpectators(position, false, false, 2, 2, 2, 2)
				logger.debug("Number of nearby spectators " .. #spectators)
				if #spectators > 1 then
					soakMultiplier = 0.2
				end

				local min = player:getMaxHealth() * 0.2 * multiplier * soakMultiplier
				local max = player:getMaxHealth() * 0.4 * multiplier * soakMultiplier
				doTargetCombatHealth(creature, player, COMBAT_FIREDAMAGE, -min, -max, CONST_ME_NONE)
			end
		end
	end

	position:sendMagicEffect(CONST_ME_FIREAREA)
	return true
end

combat:setArea(createCombatArea(area))

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function doCast(casterPosition, targetPosition)
	local minDistance = 3
	return math.abs(casterPosition.x - targetPosition.x) > minDistance or math.abs(casterPosition.y - targetPosition.y) > minDistance
end

local function delayedCastSpell(combat, cid, var)
	local creature = Creature(cid)

	if not creature then
		return true
	end

	local playerId = var.number
	local player = Player(playerId)
	if not player then
		return true
	end

	var.pos = player:getPosition()

	creature:getPosition():sendDistanceEffect(var.pos, CONST_ANI_LARGEROCK)
	return combat:execute(creature, var)
end

function spell.onCastSpell(creature, var)
	if not claimMajorSpellExecute(5) then
		return true
	end

	local creaturePosition = creature:getPosition()
	local spectators = Game.getSpectators(creaturePosition, false, false, 12, 12, 12, 12)
	if #spectators < 3 then
		return true
	end

	for _, spectator in ipairs(spectators) do
		if spectator and spectator:isPlayer() then
			local targetPosition = spectator:getPosition()
			if doCast(creaturePosition, targetPosition) then
				creature:say("Inferno Strike on " .. spectator:getName() .. " [stack]", TALKTYPE_MONSTER_SAY)
				var.number = spectator:getId()

				return addEvent(delayedCastSpell, 3000, combat, creature:getId(), var)
			end
		end
	end

	return true
end

spell:name("Heip Inferno Strike")
spell:words("###heip_inferno_strike")
spell:needDirection(false)
spell:blockWalls(false)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
