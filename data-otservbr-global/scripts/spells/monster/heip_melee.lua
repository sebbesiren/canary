local spell = Spell("instant")

local areas = {
	{
		{ 0, 1, 1, 1, 1, 1, 0 },
		{ 0, 0, 1, 1, 1, 0, 0 },
		{ 0, 0, 1, 1, 1, 0, 0 },
		{ 0, 0, 0, 3, 0, 0, 0 },
	},
	{
		{ 0, 0, 0, 1, 0, 0, 0 },
		{ 0, 0, 1, 1, 1, 0, 0 },
		{ 0, 1, 1, 3, 1, 1, 0 },
		{ 0, 0, 1, 1, 1, 0, 0 },
		{ 0, 0, 0, 1, 0, 0, 0 },
	},
	{
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 0, 1, 1, 1, 1, 3, 1, 1, 1, 1, 0 },
	},
}
local combats = {}

for _, area in ipairs(areas) do
	local combat = Combat()

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
						multiplier = 2.5
					elseif voc == VOCATION.BASE_ID.PALADIN then
						multiplier = 2
					elseif voc == VOCATION.BASE_ID.KNIGHT then
						multiplier = 1
					end

					local min = player:getMaxHealth() * 0.2 * multiplier
					local max = player:getMaxHealth() * 0.4 * multiplier

					doTargetCombatHealth(creature, player, COMBAT_PHYSICALDAMAGE, -min, -max, CONST_ME_NONE)
				end
			end
		end

		position:sendMagicEffect(CONST_ME_DRAWBLOOD)
		return true
	end

	combat:setArea(createCombatArea(area))
	combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

	table.insert(combats, combat)
end

function spell.onCastSpell(creature, var)
	local combat = combats[math.random(#combats)]
	return combat:execute(creature, var)
end

spell:name("Heip Melee")
spell:words("###heip_melee")
spell:needTarget(true)
spell:blockWalls(false)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
