local config = {
	items = {
		{ id = 35290, charges = 34400, buy = 24000000 },
		{ id = 35285, charges = 34400, buy = 24000000 },
		{ id = 35287, charges = 34400, buy = 24000000 },
		{ id = 35289, charges = 34400, buy = 24000000 },
		{ id = 35288, charges = 34400, buy = 24000000 },
		{ id = 35286, charges = 34400, buy = 24000000 },
		{ id = 44067, charges = 34400, buy = 24000000 },
	},
}

local function sendShopModel(player)
	local window = ModalWindow({
		title = "Custom shop",
		message = "Which item do you want to buy?",
	})
	for _, it in pairs(config.items) do
		local iType = ItemType(it.id)
		if iType then

			local name = iType:getName() .. " x " .. it.charges .. " (" .. it.buy .. "g)"
			window:addChoice(name, function(player, button, choice)
				if button.name ~= "Select" then
					return true
				end

				local inbox = player:getStoreInbox()
				local inboxItems = inbox:getItems()

				local hasCap = inbox and #inboxItems < inbox:getMaxCapacity() and player:getFreeCapacity() >= iType:getWeight()
				if not hasCap then
					return player:sendTextMessage(MESSAGE_LOOK, "You need to have capacity and empty slots to receive.")
				end

				local hasFunds = it.buy < player:getMoney() + player:getBankBalance()
				if not hasFunds then
					return player:sendTextMessage(MESSAGE_LOOK, "You dont have enough money.")
				end

				local item = player:addItem(it.id, 1)
				if not item then
					return player:sendTextMessage(MESSAGE_LOOK, "You need to have capacity and empty slots to receive.")
				end
				if it.charges then
					item:setAttribute(ITEM_ATTRIBUTE_CHARGES, it.charges)
				end
				player:removeMoneyBank(it.buy)
				return player:sendTextMessage(MESSAGE_LOOK, "Purchased: " .. choice.text)
			end)
		end
	end
	window:addButton("Select")
	window:addButton("Close")
	window:setDefaultEnterButton(0)
	window:setDefaultEscapeButton(1)
	window:sendToPlayer(player)
end

local shop = TalkAction("!shop")
function shop.onSay(player, words, param)
	sendShopModel(player)
	return true
end

shop:separator(" ")
shop:groupType("normal")
shop:register()
