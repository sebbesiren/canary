local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

local strongImpactItemIds = {
	43882,
}
local fierceImpactItemIds = {
	43883,
}
local critDamageItemIds = {
	43884,
}

function onGetFormulaValues(player, level, maglevel)
	local min = level * 0.2 + maglevel * 8
	local max = level * 0.2 + maglevel * 16

	local multiplier = 1
	local weapon = player:getSlotItem(CONST_SLOT_LEFT)
	if weapon then
		if table.contains(strongImpactItemIds, weapon:getId()) then
			multiplier = multiplier + 0.1
		elseif table.contains(fierceImpactItemIds, weapon:getId()) then
			multiplier = multiplier + 0.2
		end
	end
	local feet = player:getSlotItem(CONST_SLOT_FEET)
	if feet and table.contains(critDamageItemIds, feet:getId()) then
		multiplier = multiplier + 0.05
	end
	logger.debug("Total multiplier: {}", multiplier)

	return -min * multiplier, -max * multiplier
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:group("attack", "focus")
spell:id(24)
spell:name("Hell's Core")
spell:words("exevo gran mas flam")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_HELL_SCORE)
spell:level(60)
spell:mana(1100)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(2 * 1000, 40 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
