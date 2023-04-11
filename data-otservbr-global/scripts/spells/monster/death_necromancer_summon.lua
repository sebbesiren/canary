local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLCLOUDS)

local area = createCombatArea(AREA_CIRCLE2X2)
combat:setArea(area)

local spell = Spell("instant")

local necromancerSummons = {
	"Frazzlemaw",
	"Choking Fear"
}

function spell.onCastSpell(creature, var)
	creature:say("RISE MY SERVANT! RISE!!", TALKTYPE_MONSTER_SAY)

	Game.createMonster(necromancerSummons[math.random(#necromancerSummons)], creature:getPosition(), true, true)
	return combat:execute(creature, var)
end

spell:name("Death Necromancer Summon")
spell:words("###death_necromancer_summon")
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
