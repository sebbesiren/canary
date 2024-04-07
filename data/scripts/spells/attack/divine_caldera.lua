local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local strongImpactItemIds = {
	43877, 43879
}
local fierceImpactItemIds = {
	43878, 43880
}
local critDamageItemIds = {
	43881
}

function onGetFormulaValues(player, level, maglevel)
	local min = level * 0.2 + maglevel * 5 + 8
	local max = level * 0.2 + maglevel * 6.2 + 28

	local multiplier = 1
	local weapon = creature:getSlotItem(CONST_SLOT_LEFT)
	if weapon then
		if table.includes(strongImpactItemIds, weapon:getId()) then
			multiplier = multiplier + 0.1
		elseif table.includes(fierceImpactItemIds, weapon:getId()) then
			multiplier = multiplier + 0.2
		end
	end
	local legs = creature:getSlotItem(CONST_SLOT_LEGS)
	if legs and table.includes(critDamageItemIds, legs:getId()) then
		multiplier = multiplier + 0.05
	end
	logger.debug("Total multiplier: {}", multiplier)

	return -min * multiplier, -max * multiplier
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(124)
spell:name("Divine Caldera")
spell:words("exevo mas san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_CALDERA)
spell:level(50)
spell:mana(160)
spell:isPremium(true)
spell:isSelfTarget(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
