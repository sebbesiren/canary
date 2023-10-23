local combatBounce = Combat()
combatBounce:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatBounce:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
--combatBounce:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combatBounce:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)

local combatCast = Combat()
combatCast:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
function onTargetCreature(creature, target)
	local effect = CONST_ANI_WHIRLWINDAXE

	local casterPosition = creature:getPosition()
	local targetPosition = target:getPosition()

	local targetId = target:getId()
	local var = {}
	var.instantName = "Executioner's Throw"
	var.runeName = ""
	var.type = 1 -- VARIANT_NUMBER
	var.number = targetId

	combatBounce:execute(creature, var)
	casterPosition:sendDistanceEffect(targetPosition, effect)

	local spectators = Game.getSpectators(casterPosition, false, false, 10, 10, 10, 10)
	for _, spectator in ipairs(spectators) do
		if spectator and spectator:getId() ~= targetId and spectator:isPlayer() then
			var.number = spectator:getId()
			local spectatorPosition = spectator:getPosition()
			if combatBounce:execute(creature, var) then
				casterPosition:sendDistanceEffect(spectatorPosition, effect)
				casterPosition = spectatorPosition
			end
		end
	end

	return true
end

combatCast:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combatCast:execute(creature, var)
end

spell:group("attack")
spell:name("Athelstan Axe Throw")
spell:words("###athelstan_axe_throw")
spell:range(5)
spell:needTarget(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
