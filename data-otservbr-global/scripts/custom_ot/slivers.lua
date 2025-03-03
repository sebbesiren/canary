local sliversItem = Action()

function sliversItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local dustToAdd = 20
	if player:getForgeDusts() + dustToAdd > player:getForgeDustLevel() then
		return true
	end

	item:remove(1)
	player:addForgeDusts(dustToAdd)
	return true
end

sliversItem:id(37109)
sliversItem:register()
