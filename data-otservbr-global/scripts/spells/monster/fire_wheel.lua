local spell = Spell("instant")

local areas = {
	{
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	},
	{
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0 },
		{ 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0 },
		{ 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0 },
		{ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	},
}
local combats = {}

for _, area in ipairs(areas) do
	local combat = Combat()

	function onTargetTile(creature, position)
		local tile = Tile(position)
		local creatures = tile:getCreatures()
		if creatures and #creatures > 0 then
			for _, c in pairs(creatures) do
				local player = Player(c)
				if player then
					logger.debug("Death ripple hit player")
					local min = player:getMaxHealth() * 0.0
					local max = player:getMaxHealth() * 0.20
					doTargetCombatHealth(creature, player, COMBAT_FIREDAMAGE, -min, -max, CONST_ME_NONE)
				end
			end
		end

		position:sendMagicEffect(CONST_ME_FIREAREA)
		return true
	end

	combat:setArea(createCombatArea(area))
	combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

	table.insert(combats, combat)
end

local function delayedCastSpell(combat, cid, var)
	local creature = Creature(cid)

	if not creature then
		return true
	end

	return combat:execute(creature, positionToVariant(creature:getPosition()))
end

function spell.onCastSpell(creature, var)
	logger.debug("Casting fire wheel")
	cid = creature:getId()

	for i, combat in pairs(combats) do
		addEvent(delayedCastSpell, (i - 1) * 1250, combat, cid, var)
	end

	return true
end

spell:name("Fire Wheel")
spell:words("###fire_wheel")
spell:needDirection(false)
spell:blockWalls(false)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
