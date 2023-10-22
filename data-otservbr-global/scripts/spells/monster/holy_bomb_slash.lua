local spell = Spell("instant")

local combatConfig = {
	delay = 150,
	areas = {
		{
			{ 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 1, 0, 0, 0, 0, 0 },
			{ 1, 1, 1, 2, 0, 0, 0 },
			{ 1, 1, 1, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 1, 1, 1, 0, 0 },
			{ 0, 0, 1, 1, 1, 0, 0 },
			{ 0, 0, 0, 3, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 0 },
			{ 0, 0, 0, 2, 1, 1, 1 },
			{ 0, 0, 0, 0, 1, 1, 1 },
		},
	},
	combats = {},
	effect = CONST_ME_BLOCKHIT,
	type = COMBAT_HOLYDAMAGE,
	secondRotationEffect = CONST_ME_EXPLOSIONHIT,
	secondRotationType = COMBAT_FIREDAMAGE,
}

for _, area in ipairs(combatConfig.areas) do
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, combatConfig.type)
	combat:setParameter(COMBAT_PARAM_EFFECT, combatConfig.effect)
	combat:setArea(createCombatArea(area))

	table.insert(combatConfig.combats, combat)
end

for _, area in ipairs(combatConfig.areas) do
	local combat = Combat()
	combat:setParameter(COMBAT_PARAM_TYPE, combatConfig.secondRotationType)
	combat:setParameter(COMBAT_PARAM_EFFECT, combatConfig.secondRotationEffect)
	combat:setArea(createCombatArea(area))

	table.insert(combatConfig.combats, combat)
end

local function delayedCastSpell(combat, cid, var)
	local creature = Creature(cid)

	if not creature then
		return true
	end

	return combat:execute(creature, var)
end

function spell.onCastSpell(creature, var)
	cid = creature:getId()

	local castIndex = 0

	for _, combat in ipairs(combatConfig.combats) do
		addEvent(delayedCastSpell, combatConfig.delay * castIndex, combat, cid, var)
		castIndex = castIndex + 1
	end

	return true
end

spell:name("Holy Bomb Slash")
spell:words("###holy_bomb_slash")
spell:needDirection(true)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
