local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLCLOUDS)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DEATH)

local condition = Condition(CONDITION_CURSED)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)

local damage = 45
condition:addDamage(1, 6000, -damage)
for j = 1, 18 do
	damage = damage * 1.2
	condition:addDamage(1, 6000, -damage)
end
condition:addDamage(1, 6000, -damage*2.2)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(139)
spell:name("Curse")
spell:words("utori mort")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_CURSE)
spell:level(75)
spell:mana(30)
spell:isAggressive(true)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
