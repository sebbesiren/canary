local config = {
	AffixQualityChance = {
		Weak = 60,
		Strong = 30,
		Powerful = 7,
		Legendary = 2,
		Godly = 1
	},
	AffixesPerSlot = {
		Armor = {
			"Health",
			"Mana",
			"AllResist",
			"Vampirism",
			"PhysResist",
			"Charm",
		},
		Head = {
			"Health",
			"Mana",
			"Skills",
			"Void",
			"PhysResist",
			"Charm",
		},
		Legs = {
			"Health",
			"Mana",
			"AllResist",
			"PhysResist",
			"Charm",
			"HealReceived",
		},
		Feet = {
			"Health",
			"Mana",
			"PhysResist",
			"Charm",
			"HealReceived",
		},
		Weapon = {
			"CritChance",
			"CritDmg",
			"Skills",
			"Vampirism",
			"Void",
			"Atk",
		},
	},
	Affixes = {
		Health = { Weak = 1, Strong = 2, Powerful = 4, Legendary = 8, Godly = 12 },
		Mana = { Weak = 1, Strong = 2, Powerful = 4, Legendary = 8, Godly = 12 },
		AllResist = { Weak = 1, Strong = 2, Powerful = 4, Legendary = 6, Godly = 8 },
		Vampirism = { Weak = 2, Strong = 4, Powerful = 8, Legendary = 12, Godly = 16 },
		PhysResist = { Weak = 1, Strong = 2, Powerful = 4, Legendary = 6, Godly = 8 },
		Charm = { Weak = 4, Strong = 8, Powerful = 12, Legendary = 16, Godly = 20 },
		Skills = { Weak = 1, Strong = 2, Powerful = 4, Legendary = 8, Godly = 12 },
		Void = { Weak = 1, Strong = 2, Powerful = 4, Legendary = 8, Godly = 12 },
		HealReceived = { Weak = 1, Strong = 2, Powerful = 4, Legendary = 8, Godly = 12 },
		CritChance = { Weak = 2, Strong = 4, Powerful = 8, Legendary = 12, Godly = 16 },
		CritDmg = { Weak = 5, Strong = 10, Powerful = 20, Legendary = 30, Godly = 40 },
		Atk = { Weak = 2, Strong = 4, Powerful = 8, Legendary = 12, Godly = 16 },
	},
}

function generateAffix()
	local affixKeys = {}
	for key in pairs(config.Affixes) do
		table.insert(affixKeys, key)
	end

	local qualityRoll = math.random(1, 100)
	local quality = "Weak"
	if qualityRoll <= config.AffixQualityChance.Powerful then
		quality = "Powerful"
	elseif qualityRoll <= config.AffixQualityChance.Strong + config.AffixQualityChance.Powerful then
		quality = "Strong"
	end

	local affixName = affixKeys[math.random(1, #affixKeys)]

	return {
		name = affixName,
		quality = quality,
	}
end

function getPlayerStoredAffixes(player)
	local playerStoredAffixes = player:kv():scoped("runeweave"):get("stored-affixes") or {}

	-- ensure all keys exists
	for affixName in pairs(config.Affixes) do
		if not playerStoredAffixes[affixName] then
			playerStoredAffixes[affixName] = {}

			for qualityName in pairs(config.AffixQualityChance) do
				if not playerStoredAffixes[affixName][qualityName] then
					playerStoredAffixes[affixName][qualityName] = 0
				end
			end
		end
	end

	return playerStoredAffixes
end

function setPlayerStoredAffixes(player, playerStoredAffixes)
	player:kv():scoped("runeweave"):set("stored-affixes", playerStoredAffixes)
end

function addAffixToStore(player, affixName, quality)
	local playerStoredAffixes = getPlayerStoredAffixes(player)
	playerStoredAffixes[affixName][quality] = playerStoredAffixes[affixName][quality] + 1
	setPlayerStoredAffixes(player, playerStoredAffixes)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Enchantment " .. quality .. " " .. affixName .. " was added to your collection.")
end

function removeAffixFromStore(player, affixName, quality)
	local playerStoredAffixes = getPlayerStoredAffixes(player)
	playerStoredAffixes[affixName][quality] = playerStoredAffixes[affixName][quality] - 1
	setPlayerStoredAffixes(player, playerStoredAffixes)
end

function getAvailableEnchantAffixes(player, slot, excludeAffixes)
	availableAffixes = {
		-- name/quality/count
	}
	local playerStoredAffixes = getPlayerStoredAffixes(player)
	local slotAffixNames = config.AffixesPerSlot[slot]

	for _, affixName in ipairs(slotAffixNames) do
		if not table.contains(excludeAffixes, affixName) then
			for k, v in pairs(playerStoredAffixes[affixName]) do
				if v > 0 then
					table.insert(availableAffixes, { quality = k, name = affixName, count = v })
				end
			end
		end
	end

	return availableAffixes
end

function generateAffixDescription(affixes)
	local affixStrings = {}
	for _, affix in ipairs(affixes) do
		local affixStr = string.format("%s %s", affix.quality, affix.name)
		table.insert(affixStrings, affixStr)
	end

	return "Enchantments: " .. table.concat(affixStrings, ", ")
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

function setAffixConditions(player, condition, affixes)
	for _, affix in ipairs(affixes) do
		local affixName = affix.name

		if not config.Affixes[affixName] or not config.Affixes[affixName][affix.quality] then
			goto continue
		end

		local value = config.Affixes[affixName][affix.quality]

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
			local vocationName = Vocation(player:getVocation():getBaseId()):getName()
			if vocationName == "Sorcerer" or vocationName == "Druid" then
				condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, value)
			elseif vocationName == "Paladin" then
				condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, value)
			elseif vocationName == "Knight" then
				condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, value)
				condition:setParameter(CONDITION_PARAM_SKILL_CLUB, value)
				condition:setParameter(CONDITION_PARAM_SKILL_SWORD, value)
				condition:setParameter(CONDITION_PARAM_SKILL_AXE, value)
			end
		elseif affixName == "Void" then
			condition:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_AMOUNT, value * 100)
			condition:setParameter(CONDITION_PARAM_SKILL_MANA_LEECH_CHANCE, 10000)
		elseif affixName == "CritChance" then
			condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_CHANCE, value * 100)
		elseif affixName == "CritDmg" then
			condition:setParameter(CONDITION_PARAM_SKILL_CRITICAL_HIT_DAMAGE, value * 100)
		elseif affixName == "Atk" then
			condition:setParameter(CONDITION_PARAM_BUFF_DAMAGEDEALT, 100 + value)
		elseif affixName == "HealReceived" then
			condition:setParameter(CONDITION_PARAM_BUFF_HEALINGRECEIVED, 100 + value)
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

function Monster:generateEnchantmentScrollLoot(playerLoot)
	if playerLoot == nil then
		playerLoot = {}
	end

	local mType = self:getType()

	local chance = 100
	local count = 1
	local is_archfoe = (mType:bossRace() or ""):lower() == "archfoe"
	if is_archfoe then
		chance = 25000
	else
		local forgeClassification = self:getMonsterForgeClassification()
		if forgeClassification == FORGE_INFLUENCED_MONSTER then
			chance = 1000
		elseif forgeClassification == FORGE_FIENDISH_MONSTER then
			chance = 5000
		end
	end

	local roll = math.random(1, 100000)
	if roll < chance then
		local itemType = ItemType(28650)
		playerLoot[itemType:getId()] = { count = count }
	end
	return playerLoot
end

local lootCallback = EventCallback("MonsterOnDropRuneweaveEnchantment")
function lootCallback.monsterOnDropLoot(monster, corpse)
	if not monster or not corpse then
		return
	end
	local player = Player(corpse:getCorpseOwner())
	if not player or not player:canReceiveLoot() then
		return
	end
	corpse:addLoot(monster:generateEnchantmentScrollLoot())
end

lootCallback:register()
