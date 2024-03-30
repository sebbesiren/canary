local spell = Spell("instant")

local areas = {
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
	{
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 },
	},
	{
		{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
		{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
		{ 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0 },
		{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
	},
}
local combats = {}

for _, area in ipairs(areas) do
	local notify = Combat()
	local combat = Combat()

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
						multiplier = 2
					elseif voc == VOCATION.BASE_ID.KNIGHT then
						multiplier = 1
					end

					local min = player:getMaxHealth() * 0.4 * multiplier
					local max = player:getMaxHealth() * 0.8 * multiplier
					doTargetCombatHealth(creature, player, COMBAT_FIREDAMAGE, -min, -max, CONST_ME_NONE)
				end
			end
		end

		position:sendMagicEffect(CONST_ME_FIREAREA)
		return true
	end

	combat:setArea(createCombatArea(area))
	notify:setArea(createCombatArea(area))

	combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
	notify:setCallback(CALLBACK_PARAM_TARGETTILE, "notifyOnTargetTile")

	table.insert(combats, {
		notify = notify,
		combat = combat,
	})
end

local function delayedCastSpell(combat, cid, var)
	local creature = Creature(cid)

	if not creature then
		return true
	end

	return combat:execute(creature, positionToVariant(creature:getPosition()))
end

function spell.onCastSpell(creature, var)
	cid = creature:getId()

	local combat = combats[math.random(#combats)]
	combat.notify:execute(creature, var)
	addEvent(delayedCastSpell, 1500, combat.combat, cid, var)

	return true
end

spell:name("Cross Blast")
spell:words("###cross_blast")
spell:needDirection(false)
spell:blockWalls(false)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
