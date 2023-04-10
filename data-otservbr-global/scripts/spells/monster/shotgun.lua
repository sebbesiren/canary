local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)

area = {
	{1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1},
	{0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0},
	{0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0},
	{0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0},
	{0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0},
	{0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 3, 1, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
}
combat:setArea(createCombatArea(area))

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:name("Shotgun")
spell:words("###shotgun")
spell:needDirection(true)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
