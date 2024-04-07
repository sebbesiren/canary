local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLPLANTS)
combat:setArea(createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5))

local strongImpactItemIds = {
	43885,
}
local fierceImpactItemIds = {
	43886,
}
local critDamageItemIds = {
	43887,
}

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 3.5)
	local max = (level / 5) + (maglevel * 7)

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

spell:group("attack")
spell:id(120)
spell:name("Terra Wave")
spell:words("exevo tera hur")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_TERRA_WAVE)
spell:level(38)
spell:mana(170)
spell:isPremium(true)
spell:needDirection(true)
spell:cooldown(4 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()
