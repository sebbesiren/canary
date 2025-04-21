local function newEnchantmentWindow(player, itemAffixes, item, slot, updateIndex)
	local excludeAffixNames = {}
	for i, affix in ipairs(itemAffixes) do
		if i ~= updateIndex then
			table.insert(excludeAffixNames, affix.name)
		end
	end
	local availableEnchantAffixes = getAvailableEnchantAffixes(player, slot, excludeAffixNames)

	if #availableAffixes == 0 then
		local window = ModalWindow({
			title = "Select enchantment",
			message = "No available enchantments",
		})
		window:addButton("Close")
		window:setDefaultEnterButton(0)
		window:setDefaultEscapeButton(1)
		window:sendToPlayer(player)
		return true
	end

	local window = ModalWindow({
		title = "Select enchantment",
		message = "Your available enchantments for the slot",
	})

	for _, availableAffix in ipairs(availableEnchantAffixes) do
		local enchantmentName = availableAffix.quality .. " " .. availableAffix.name .. " (" .. availableAffix.count .. ")"
		window:addChoice(enchantmentName, function(player, button, choice)
			if button.name == "Select" then
				if updateIndex == nil then
					table.insert(itemAffixes, availableAffix)
				else
					itemAffixes[updateIndex] = availableAffix
				end

				removeAffixFromStore(player, availableAffix.name, availableAffix.quality)

				local itemDescription = generateAffixDescription(itemAffixes)
				item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, itemDescription)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Enchantment performed! " .. itemDescription)
				resolveEquippedRuneweaveEnchantments(player)
			end
			return true
		end)
	end

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local function itemResolveEnchantmentSlotWindow(player, item, slot)
	local itemAffixes = getAffixesFromDescription(item)
	local showNew = #itemAffixes < 3

	local window = ModalWindow({
		title = item:getName(),
		message = "Select which enchantment slot you wish to update",
	})

	for i, affix in ipairs(itemAffixes) do
		local enchantmentName = "Replace: " .. affix.quality .. " " .. affix.name
		window:addChoice(enchantmentName, function(player, button, choice)
			if button.name == "Select" then
				newEnchantmentWindow(player, itemAffixes, item, slot, i)
			end
			return true
		end)
	end

	if showNew then
		window:addChoice("Add", function(player, button, choice)
			if button.name == "Select" then
				newEnchantmentWindow(player, itemAffixes, item, slot, nil)
			end
			return true
		end)
	end

	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local Reveal = Action()

function Reveal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local allowedSlots = { "Armor", "Head", "Legs", "Feet", "Weapon" }
	local slot = getSlotName(target)

	if not table.contains(allowedSlots, slot) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid item.")
		return true
	end

	itemResolveEnchantmentSlotWindow(player, target, slot)

	return true
end

Reveal:id(673)
Reveal:register()

local enchantmentScroll = Action()

function enchantmentScroll.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local affix = generateAffix()
	addAffixToStore(player, affix.name, affix.quality)
	item:remove(1)
	return true
end
enchantmentScroll:id(28650)
enchantmentScroll:register()

function resolveEquippedRuneweaveEnchantments(player)
	local config = {
		Armor = {
			Slot = CONST_SLOT_ARMOR,
			ConditionId = CONDITIONID_ARMOR,
			ConditionSubId = 900,
		},
		Head = {
			Slot = CONST_SLOT_HEAD,
			ConditionId = CONDITIONID_HEAD,
			ConditionSubId = 901,
		},
		Legs = {
			Slot = CONST_SLOT_LEGS,
			ConditionId = CONDITIONID_LEGS,
			ConditionSubId = 902,
		},
		Feet = {
			Slot = CONST_SLOT_FEET,
			ConditionId = CONDITIONID_FEET,
			ConditionSubId = 903,
		},
		Weapon = {
			Slot = CONST_SLOT_LEFT,
			ConditionId = CONDITIONID_LEFT,
			ConditionSubId = 904,
		},
	}

	for _, slotConfig in pairs(config) do
		player:removeCondition(CONDITION_ATTRIBUTES, slotConfig.ConditionId, slotConfig.ConditionSubId)

		local item = player:getSlotItem(slotConfig.Slot)
		if item then
			local affixes = getAffixesFromDescription(item)
			if #affixes > 0 then
				local condition = Condition(CONDITION_ATTRIBUTES, slotConfig.ConditionId)
				condition:setParameter(CONDITION_PARAM_SUBID, slotConfig.ConditionSubId)
				condition:setParameter(CONDITION_PARAM_TICKS, -1)
				setAffixConditions(player, condition, affixes)
				player:addCondition(condition)
			end
		end
	end
end

local login = CreatureEvent("RuneweaveEnchantments")
function login.onLogin(player)
	resolveEquippedRuneweaveEnchantments(player)
	return true
end
login:register()

local onInventoryUpdate = EventCallback("RuneweaveInventoryUpdate")
function onInventoryUpdate.playerOnInventoryUpdate(player, item, count, fromPos, toPos, fromCylinder, toCylinder)
	resolveEquippedRuneweaveEnchantments(player)
	return true
end
onInventoryUpdate:register()
