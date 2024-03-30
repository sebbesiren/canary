local spell = Spell("instant")

local area = {
	--{
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	--	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	--}
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 3, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
}
local combat = {
	notify = Combat(),
	combat = Combat(),
}
function notifyOnTargetTile(creature, position)
	position:sendMagicEffect(CONST_ME_HITAREA)
	return true
end

function onTargetTile(creature, position)
	local tile = Tile(position)
	local creatures = tile:getCreatures()
	if creatures and #creatures > 0 then
		for _, c in pairs(creatures) do
			local player = Player(c)
			if player then
				local multiplier = 1
				local voc = player:getVocation():getBaseId()
				if voc == VOCATION.BASE_ID.SORCERER or voc == VOCATION.BASE_ID.DRUID then
					multiplier = 2
				elseif voc == VOCATION.BASE_ID.PALADIN then
					multiplier = 1
				elseif voc == VOCATION.BASE_ID.KNIGHT then
					multiplier = 1
				end

				local min = player:getMaxHealth() * 0.05 * multiplier
				local max = player:getMaxHealth() * 0.2 * multiplier
				doTargetCombatHealth(creature, player, COMBAT_DEATHDAMAGE, -min, -max, CONST_ME_NONE)
			end
		end
	end
	position:sendMagicEffect(CONST_ME_MORTAREA)
	return true
end

combat.combat:setArea(createCombatArea(area))
combat.notify:setArea(createCombatArea(area))

combat.combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combat.notify:setCallback(CALLBACK_PARAM_TARGETTILE, "notifyOnTargetTile")

local function delayedCastSpell(c, cid, var)
	local creature = Creature(cid)

	if not creature then
		return true
	end

	return c:execute(creature, var)
end

function spell.onCastSpell(creature, var)
	local cid = creature:getId()

	local xPos = math.floor(var.pos.x + 0.5 + math.random(-6, 6))
	local yPos = math.floor(var.pos.y + 0.5 + math.random(-6, 6))
	var.pos = Position(xPos, yPos, var.pos.z)

	combat.notify:execute(creature, var)
	addEvent(delayedCastSpell, 1500, combat.combat, cid, var)
	return true
end

spell:name("Small Mortar")
spell:words("###small_mortar")
spell:needDirection(false)
spell:blockWalls(false)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
