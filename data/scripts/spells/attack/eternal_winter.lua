local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

local strongImpactItemIds = {
	43885
}
local fierceImpactItemIds = {
	43886
}
local critDamageItemIds = {
	43887
}

function onGetFormulaValues(player, level, maglevel)
	local min = level * 0.2 + maglevel * 8
	local max = level * 0.2 + maglevel * 16

	local multiplier = 1
	local weapon = creature:getSlotItem(CONST_SLOT_LEFT)
	if weapon then
		if table.includes(strongImpactItemIds, weapon:getId()) then
			multiplier = multiplier + 0.1
		elseif table.includes(fierceImpactItemIds, weapon:getId()) then
			multiplier = multiplier + 0.2
		end
	end
	local feet = creature:getSlotItem(CONST_SLOT_FEET)
	if feet and table.includes(critDamageItemIds, feet:getId()) then
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

spell:group("attack", "focus")
spell:id(118)
spell:name("Eternal Winter")
spell:words("exevo gran mas frigo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_ETERNAL_WINTER)
spell:level(60)
spell:mana(1050)
spell:isPremium(true)
spell:range(5)
spell:isSelfTarget(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(2 * 1000, 40 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()
