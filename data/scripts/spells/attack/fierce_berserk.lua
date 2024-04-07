local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local strongImpactItemIds = {
	43864, 43866, 43868, 43870, 43872, 43874
}
local fierceImpactItemIds = {
	43865, 43867, 43869, 43871, 43873, 43875
}
local critDamageItemIds = {
	43876
}

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()

	local min = (level / 5) + (skill + 2 * attack) * 1.1
	local max = (level / 5) + (skill + 2 * attack) * 3

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

	return -min * 1.1 * multiplier, -max * 1.1 * multiplier -- TODO : Use New Real Formula instead of an %
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(105)
spell:name("Fierce Berserk")
spell:words("exori gran")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(90)
spell:mana(340)
spell:isPremium(true)
spell:needWeapon(true)
spell:cooldown(6 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()
