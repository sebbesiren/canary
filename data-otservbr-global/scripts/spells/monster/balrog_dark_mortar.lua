local spell = Spell("instant")

local combatConfig = {
	noticeDelay = 850,
	boomDelay = 1600,
	standStill = true,
	message = "Balrog Dark Mortar!!!",
	numberOfCasts = 6,
	areas = {
		{
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 3, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0 },
		},
		{
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
			{ 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
		},
	},
	combatRotations = {},
	noticeEffect = CONST_ME_HITAREA,
	noticeType = COMBAT_PHYSICALDAMAGE,
	boomEffect = CONST_ME_MORTAREA,
	boomType = COMBAT_DEATHDAMAGE,
}

for _, area in ipairs(combatConfig.areas) do
	noticeCombat = Combat()
	boomCombat = Combat()

	function onNoticeTargetTile(creature, pos)
		local tile = Tile(position)
		local creatures = tile:getCreatures()
		if creatures and #creatures > 0 then
			for _, c in pairs(creatures) do
				local player = Player(c)
				if player then
					local multiplier = 1
					local voc = player:getVocation():getBaseId()
					if voc == VOCATION.BASE_ID.SORCERER or voc == VOCATION.BASE_ID.DRUID then
						multiplier = 3
					elseif voc == VOCATION.BASE_ID.PALADIN then
						multiplier = 2
					elseif voc == VOCATION.BASE_ID.KNIGHT then
						multiplier = 1
					end

					local min = player:getMaxHealth() * 0.02 * multiplier
					local max = player:getMaxHealth() * 0.06 * multiplier
					doTargetCombatHealth(creature, player, combatConfig.noticeType, -min, -max, CONST_ME_NONE)
				end
			end
		end

		position:sendMagicEffect(combatConfig.noticeEffect)
		return true
	end

	function onBoomTargetTile(creature, pos)
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
						multiplier = 1.5
					elseif voc == VOCATION.BASE_ID.KNIGHT then
						multiplier = 1
					end

					local min = player:getMaxHealth() * 0.35 * multiplier
					local max = player:getMaxHealth() * 0.45 * multiplier
					doTargetCombatHealth(creature, player, combatConfig.boomType, -min, -max, CONST_ME_NONE)
				end
			end
		end

		position:sendMagicEffect(combatConfig.boomEffect)
		return true
	end

	noticeCombat:setArea(createCombatArea(area))
	boomCombat:setArea(createCombatArea(area))

	noticeCombat:setCallback(CALLBACK_PARAM_TARGETTILE, "onNoticeTargetTile")
	boomCombat:setCallback(CALLBACK_PARAM_TARGETTILE, "onBoomTargetTile")

	table.insert(combatConfig.combatRotations, { noticeCombat, boomCombat })
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

	if combatConfig.standStill then
		creatureSpeed = creature:getBaseSpeed()
		doChangeSpeed(cid, -creatureSpeed)
	else
		creatureSpeed = 0
	end

	if combatConfig.message then
		creature:say(combatConfig.message, TALKTYPE_MONSTER_SAY)
	end

	local currentDelay = 0
	for _ = 1, combatConfig.numberOfCasts do
		randomCombatRotation = combatConfig.combatRotations[math.random(#combatConfig.combatRotations)]
		for i = 1, #randomCombatRotation do
			if i == 1 then
				delay = combatConfig.boomDelay
			else
				delay = combatConfig.noticeDelay
			end

			combat = randomCombatRotation[i]
			addEvent(delayedCastSpell, currentDelay, combat, cid, var)
			currentDelay = currentDelay + delay
		end
	end

	if creatureSpeed > 0 then
		addEvent(doChangeSpeed, currentDelay, cid, creatureSpeed)
	end

	return true
end

spell:name("Balrog Dark Mortar")
spell:words("###balrog_dark_mortar")
spell:needDirection(false)
spell:blockWalls(false)
spell:isAggressive(true)
spell:needLearn(true)
spell:register()
