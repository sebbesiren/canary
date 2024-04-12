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
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 3, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
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
					multiplier = 2
				elseif voc == VOCATION.BASE_ID.PALADIN then
					multiplier = 2
				elseif voc == VOCATION.BASE_ID.KNIGHT then
					multiplier = 1
				end

				local min = player:getMaxHealth() * 0.20 * multiplier
				local max = player:getMaxHealth() * 0.25 * multiplier
				doTargetCombatHealth(creature, player, COMBAT_ENERGYDAMAGE, -min, -max, CONST_ME_NONE)
			end
		end
	end

	position:sendMagicEffect(CONST_ME_ENERGYAREA)
	return true
end

combat:setArea(createCombatArea(area))

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local function doCast(casterPosition, targetPosition)
	local minDistance = 3
	return math.abs(casterPosition.x - targetPosition.x) > minDistance or math.abs(casterPosition.y - targetPosition.y) > minDistance
end

function spell.onCastSpell(creature, var)
	if not claimMajorSpellExecute() then
		return true
	end

	local creaturePosition = creature:getPosition()
	local spectators = Game.getSpectators(creaturePosition, false, false, 4, 12, 4, 12)

	for _, spectator in ipairs(spectators) do
		if spectator and spectator:isPlayer() then
			var.number = spectator:getId()
			var.pos = spectator:getPosition()
			if doCast(creaturePosition, var.pos) then
				creaturePosition:sendDistanceEffect(var.pos, CONST_ANI_EXPLOSION)
				combat:execute(creature, var)
			end
		end
	end

	return true
end

spell:name("Heip Energy Ball")
spell:words("###heip_energy_ball")
spell:needDirection(false)
spell:blockWalls(false)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
