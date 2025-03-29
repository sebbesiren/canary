local config = {
	Rarity = {
		Uncommon = { Affixes = 1 },
		Rare = { Affixes = 2 },
		Epic = { Affixes = 3 },
	},

	RevealChance = {
		Uncommon = 55,
		Rare = 30,
		Epic = 15,
	},

	AffixQualityChance = {
		Weak = 55,
		Strong = 30,
		Powerful = 15,
	},

	Affixes = {
		Armor = {
			Health = { Weak = 1, Strong = 2, Powerful = 4 },
			Mana = { Weak = 1, Strong = 2, Powerful = 4 },
			AllResist = { Weak = 1, Strong = 2, Powerful = 4 },
			Vampirism = { Weak = 2, Strong = 4, Powerful = 8 },
			PhysResist = { Weak = 1, Strong = 2, Powerful = 4 },
			Charm = { Weak = 5, Strong = 10, Powerful = 15 },
		},
		Head = {
			Health = { Weak = 1, Strong = 2, Powerful = 4 },
			Mana = { Weak = 1, Strong = 2, Powerful = 4 },
			Skills = { Weak = 1, Strong = 2, Powerful = 3 },
			Void = { Weak = 1, Strong = 2, Powerful = 4 },
			PhysResist = { Weak = 1, Strong = 2, Powerful = 4 },
			Charm = { Weak = 5, Strong = 10, Powerful = 15 },
		},
		Legs = {
			Health = { Weak = 1, Strong = 2, Powerful = 4 },
			Mana = { Weak = 1, Strong = 2, Powerful = 4 },
			AllResist = { Weak = 1, Strong = 2, Powerful = 4 },
			PhysResist = { Weak = 1, Strong = 2, Powerful = 4 },
			Charm = { Weak = 5, Strong = 10, Powerful = 15 },
		},
		Feet = {
			Mana = { Weak = 1, Strong = 2, Powerful = 4 },
			PhysResist = { Weak = 1, Strong = 2, Powerful = 4 },
			Charm = { Weak = 5, Strong = 10, Powerful = 15 },
		},
		Weapon = {
			CritChance = { Weak = 2, Strong = 4, Powerful = 8 },
			CritDmg = { Weak = 5, Strong = 10, Powerful = 20 },
			Skills = { Weak = 1, Strong = 2, Powerful = 3 },
			Vampirism = { Weak = 2, Strong = 4, Powerful = 8 },
			Void = { Weak = 1, Strong = 2, Powerful = 4 },
			Atk = { Weak = 1, Strong = 3, Powerful = 6 },
		},
	},
}

function generateItemAffixes(slot)
	local roll = math.random(1, 100)
	local rarity = "Common"
	local affixCount = 0

	if roll <= config.RevealChance.Epic then
		rarity = "Epic"
		affixCount = config.Rarity.Epic.Affixes
	elseif roll <= config.RevealChance.Rare + config.RevealChance.Epic then
		rarity = "Rare"
		affixCount = config.Rarity.Rare.Affixes
	else
		rarity = "Uncommon"
		affixCount = config.Rarity.Uncommon.Affixes
	end

	local availableAffixes = config.Affixes[slot]
	local affixKeys = {}
	for key in pairs(availableAffixes) do
		table.insert(affixKeys, key)
	end

	local selectedAffixes = {}
	local usedAffixes = {}
	local maxAffixes = math.min(affixCount, #affixKeys)

	for i = 1, maxAffixes do
		local qualityRoll = math.random(1, 100)
		local quality = "Weak"
		if qualityRoll <= config.AffixQualityChance.Powerful then
			quality = "Powerful"
		elseif qualityRoll <= config.AffixQualityChance.Strong + config.AffixQualityChance.Powerful then
			quality = "Strong"
		end

		local affix
		repeat
			affix = affixKeys[math.random(1, #affixKeys)]
		until not usedAffixes[affix]

		usedAffixes[affix] = true

		table.insert(selectedAffixes, {
			name = affix,
			quality = quality,
			value = availableAffixes[affix][quality],
		})
	end

	return {
		rarity = rarity,
		affixes = selectedAffixes,
	}
end

function generateAffixDescription(affixResult)
	local affixStrings = {}
	for _, affix in ipairs(affixResult.affixes) do
		local affixStr = string.format("%s %s", affix.quality, affix.name)
		table.insert(affixStrings, affixStr)
	end

	local affixList = table.concat(affixStrings, ", ")
	return string.format("%s (%d): %s", affixResult.rarity, #affixResult.affixes, affixList)
end

function getAffixesFromDescription(item)
	local description = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)

	if description == "" then
		return {}
	end

	local affixList = description:match("^.-:%s*(.+)$")
	if not affixList then
		return {}
	end

	local affixes = {}
	for affixStr in affixList:gmatch("[^,]+") do
		affixStr = affixStr:match("^%s*(.-)%s*$")
		local quality, name = affixStr:match("^(%w+)%s+(%w+)$")
		if quality and name then
			table.insert(affixes, {
				quality = quality,
				name = name,
			})
		end
	end

	return affixes
end

function setAffixConditions(condition, affixes, slot)
	for _, affix in ipairs(affixes) do
		local affixName = affix.name
		if not config.Affixes[slot][affixName] then
			goto continue
		end

		local value = config.Affixes[slot][affixName][affix.quality]

		if affixName == "Health" then
			condition:setParameter(CONDITION_PARAM_STAT_MAXHITPOINTSPERCENT, 100 + value)
		elseif affixName == "Mana" then
			condition:setParameter(CONDITION_PARAM_STAT_MAXMANAPOINTSPERCENT, 100 + value)
		elseif affixName == "AllResist" then
			condition:setParameter(CONDITION_PARAM_ABSORB_FIREPERCENT, value)
			condition:setParameter(CONDITION_PARAM_ABSORB_ICEPERCENT, value)
			condition:setParameter(CONDITION_PARAM_ABSORB_EARTHPERCENT, value)
			condition:setParameter(CONDITION_PARAM_ABSORB_ENERGYPERCENT, value)
			condition:setParameter(CONDITION_PARAM_ABSORB_HOLYPERCENT, value)
			condition:setParameter(CONDITION_PARAM_ABSORB_DEATHPERCENT, value)
		elseif affixName == "Vampirism" then
			condition:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_AMOUNT, value * 100)
			condition:setParameter(CONDITION_PARAM_SKILL_LIFE_LEECH_CHANCE, 10000)
		elseif affixName == "PhysResist" then
			condition:setParameter(CONDITION_PARAM_ABSORB_PHYSICALPERCENT, value)
		elseif affixName == "Charm" then
			condition:setParameter(CONDITION_PARAM_CHARM_CHANCE_MODIFIER, value)
		elseif affixName == "Skills" then
			condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, value)
			condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, value)
			condition:setParameter(CONDITION_PARAM_SKILL_FIST, value)
			condition:setParameter(CONDITION_PARAM_SKILL_CLUB, value)
			condition:setParameter(CONDITION_PARAM_SKILL_SWORD, value)
			condition:setParameter(CONDITION_PARAM_SKILL_AXE, value)
			condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, value)
		elseif affixName == "Void" then
			condition:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, value * 100)
			condition:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 10000)
		elseif affixName == "CritChance" then
			condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, value * 100)
		elseif affixName == "CritDmg" then
			condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, value * 100)
		elseif affixName == "Atk" then
			condition:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, 100 + value)
		end
		::continue::
	end
end

function getSlotName(item)
	if not item then
		return nil
	end

	local itemType = ItemType(item:getName())
	if not itemType then
		return nil
	end

	local type = itemType:getType()

	local typeMap = {
		[ITEM_TYPE_HELMET] = "Head",
		[ITEM_TYPE_ARMOR] = "Armor",
		[ITEM_TYPE_LEGS] = "Legs",
		[ITEM_TYPE_BOOTS] = "Feet",
		[ITEM_TYPE_AXE] = "Weapon",
		[ITEM_TYPE_CLUB] = "Weapon",
		[ITEM_TYPE_DISTANCE] = "Weapon",
		[ITEM_TYPE_SWORD] = "Weapon",
		[ITEM_TYPE_WAND] = "Weapon",
		[ITEM_TYPE_SHIELD] = "OffHand",
		[25] = "OffHand",
		[ITEM_TYPE_AMULET] = "Neck",
		[ITEM_TYPE_RING] = "Ring",
		[ITEM_TYPE_CONTAINER] = "Backpack",
	}

	local slotName = typeMap[type]
	return slotName or "Unknown"
end

function Monster:generateEnchantmentHammerLoot(playerLoot)
	local mType = self:getType()

	local is_archfoe = (mType:bossRace() or ""):lower() == "archfoe"
	if not is_archfoe then
		return playerLoot
	end

	local roll = math.random(1, 100000)
	if roll < 30000 then
		local itemType = ItemType(673)
		playerLoot[itemType:getId()] = { count = 1 }
	end
	return playerLoot
end
