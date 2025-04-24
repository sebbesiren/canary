local bossEssenceItem = Action()

function bossEssenceItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local bossName = item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)

	if not bossName then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Item is invalid. Unable to find boss essence on item.")
	end

	if attemptStartUberBoss(bossName) then
		item:remove()
		player:teleportTo(Position(5078, 4801, 11))
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Boss arena not available. Try again later.")
	end
	return true
end

bossEssenceItem:id(5802)
bossEssenceItem:register()
