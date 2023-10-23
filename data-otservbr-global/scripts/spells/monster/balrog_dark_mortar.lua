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

local vocation = {
	VOCATION.BASE_ID.SORCERER,
	VOCATION.BASE_ID.DRUID,
	VOCATION.BASE_ID.PALADIN,
	VOCATION.BASE_ID.KNIGHT,
}

for _, area in ipairs(combatConfig.areas) do
	noticeCombat = Combat()
	boomCombat = Combat()

	function onNoticeTargetTile(creature, pos)
		local creatureTable = {}
		local n, i = Tile({ x = pos.x, y = pos.y, z = pos.z }).creatures, 1
		if n ~= 0 then
			local v = getThingfromPos({ x = pos.x, y = pos.y, z = pos.z, stackpos = i }).uid
			while v ~= 0 do
				if isCreature(v) == true then
					table.insert(creatureTable, v)
					if n == #creatureTable then
						break
					end
				end
				i = i + 1
				v = getThingfromPos({ x = pos.x, y = pos.y, z = pos.z, stackpos = i }).uid
			end
		end
		if #creatureTable ~= nil and #creatureTable > 0 then
			for r = 1, #creatureTable do
				if creatureTable[r] ~= creature then
					local min = 1000
					local max = 1000
					local player = Player(creatureTable[r])

					if isPlayer(creatureTable[r]) == true and table.contains(vocation, player:getVocation():getBaseId()) then
						doTargetCombatHealth(creature, creatureTable[r], combatConfig.noticeType, -min, -max, CONST_ME_NONE)
					elseif isMonster(creatureTable[r]) == true then
						doTargetCombatHealth(creature, creatureTable[r], combatConfig.noticeType, -min, -max, CONST_ME_NONE)
					end
				end
			end
		end
		pos:sendMagicEffect(combatConfig.noticeEffect)
		return true
	end

	function onBoomTargetTile(creature, pos)
		local creatureTable = {}
		local n, i = Tile({ x = pos.x, y = pos.y, z = pos.z }).creatures, 1
		if n ~= 0 then
			local v = getThingfromPos({ x = pos.x, y = pos.y, z = pos.z, stackpos = i }).uid
			while v ~= 0 do
				if isCreature(v) == true then
					table.insert(creatureTable, v)
					if n == #creatureTable then
						break
					end
				end
				i = i + 1
				v = getThingfromPos({ x = pos.x, y = pos.y, z = pos.z, stackpos = i }).uid
			end
		end
		if #creatureTable ~= nil and #creatureTable > 0 then
			for r = 1, #creatureTable do
				if creatureTable[r] ~= creature then
					local min = 3200
					local max = 3200
					local player = Player(creatureTable[r])

					if isPlayer(creatureTable[r]) == true and table.contains(vocation, player:getVocation():getBaseId()) then
						doTargetCombatHealth(creature, creatureTable[r], combatConfig.boomType, -min, -max, CONST_ME_NONE)
					elseif isMonster(creatureTable[r]) == true then
						doTargetCombatHealth(creature, creatureTable[r], combatConfig.boomType, -min, -max, CONST_ME_NONE)
					end
				end
			end
		end
		pos:sendMagicEffect(combatConfig.boomEffect)
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
		creature:say(combatConfig.message, TALKTYPE_ORANGE_2)
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
