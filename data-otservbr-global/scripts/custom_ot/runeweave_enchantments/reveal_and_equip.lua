local Reveal = Action()

function Reveal.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local allowedSlots = { "Armor", "Head", "Legs", "Feet", "Weapon" }
	local slot = getSlotName(target)

	if not table.contains(allowedSlots, slot) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid item.")
		return true
	end

	local itemAffixResult = generateItemAffixes(slot)
	local itemDescription = generateAffixDescription(itemAffixResult)
	target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, itemDescription)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Runeweave enchantments revealed! " .. itemDescription)

	item:remove()
	resolveEquippedRuneweaveEnchantments(player)
	return true
end

Reveal:id(673)
Reveal:register()

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

	for slotName, slotConfig in pairs(config) do
		player:removeCondition(CONDITION_ATTRIBUTES, slotConfig.ConditionId, slotConfig.ConditionSubId)

		local item = player:getSlotItem(slotConfig.Slot)
		if item then
			local affixes = getAffixesFromDescription(item)
			if #affixes > 0 then
				local condition = Condition(CONDITION_ATTRIBUTES, slotConfig.ConditionId)
				condition:setParameter(CONDITION_PARAM_SUBID, slotConfig.ConditionSubId)
				condition:setParameter(CONDITION_PARAM_TICKS, -1)
				setAffixConditions(player, condition, affixes, slotName)
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
