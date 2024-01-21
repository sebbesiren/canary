-- Usage talkaction: "!itemexchange offerItem, desiredItem, tributes <optional>"
local itemexchange = TalkAction("!itemexchange")

local itemTiers = {
	["t0"] = {
		items = {
			{ itemName = "umbral blade", clientId = 20065 },
			{ itemName = "umbral slayer", clientId = 20068 },
			{ itemName = "umbral axe", clientId = 20071 },
			{ itemName = "umbral chopper", clientId = 20074 },
			{ itemName = "umbral mace", clientId = 20077 },
			{ itemName = "umbral hammer", clientId = 20080 },
			{ itemName = "umbral bow", clientId = 20083 },
			{ itemName = "umbral crossbow", clientId = 20086 },
			{ itemName = "umbral spellbook", clientId = 20089 },
		},
		tributeCostPer10 = 100000
	},
	["t1"] = {
		items = {
			{ itemName = "exotic amulet", clientId = 35523 },
			{ itemName = "throwing axe", clientId = 35515 },
			{ itemName = "bast legs", clientId = 35517 },
			{ itemName = "exotic legs", clientId = 35516 },
			{ itemName = "jungle bow", clientId = 35518 },
			{ itemName = "jungle quiver", clientId = 35524 },
			{ itemName = "jungle flail", clientId = 35514 },
			{ itemName = "jungle rod", clientId = 35521 },
			{ itemName = "jungle wand", clientId = 35522 },
			{ itemName = "makeshift boots", clientId = 35519 },
			{ itemName = "make-do boots", clientId = 35520 },
			{ itemName = "gnome helmet", clientId = 27647 },
			{ itemName = "gnome armor", clientId = 27648 },
			{ itemName = "gnome legs", clientId = 27649 },
			{ itemName = "gnome shield", clientId = 27650 },
			{ itemName = "gnome sword", clientId = 27651 },
			{ itemName = "winged boots", clientId = 31617 },
			{ itemName = "tagralt blade", clientId = 31614 },
			{ itemName = "enchanted theurgic amulet", clientId = 30403 },
		},
		tributeCostPer10 = 500000
	},
	["t2"] = {
		items = {
			{ itemName = "cobra crossbow", clientId = 30393 },
			{ itemName = "cobra boots", clientId = 30394 },
			{ itemName = "cobra club", clientId = 30395 },
			{ itemName = "cobra axe", clientId = 30396 },
			{ itemName = "cobra hood", clientId = 30397 },
			{ itemName = "cobra sword", clientId = 30398 },
			{ itemName = "cobra wand", clientId = 30399 },
			{ itemName = "cobra rod", clientId = 30400 },
			{ itemName = "lion longbow", clientId = 34150 },
			{ itemName = "lion rod", clientId = 34151 },
			{ itemName = "lion wand", clientId = 34152 },
			{ itemName = "lion spellbook", clientId = 34153 },
			{ itemName = "lion shield", clientId = 34154 },
			{ itemName = "lion longsword", clientId = 34155 },
			{ itemName = "lion spangenhelm", clientId = 34156 },
			{ itemName = "lion plate", clientId = 34157 },
			{ itemName = "lion amulet", clientId = 34158 },
			{ itemName = "eldritch breeches", clientId = 36667 },
			{ itemName = "eldritch cowl", clientId = 36670 },
			{ itemName = "eldritch hood", clientId = 36671 },
			{ itemName = "eldritch bow", clientId = 36664 },
			{ itemName = "eldritch quiver", clientId = 36666 },
			{ itemName = "eldritch claymore", clientId = 36657 },
			{ itemName = "eldritch greataxe", clientId = 36661 },
			{ itemName = "eldritch warmace", clientId = 36659 },
			{ itemName = "eldritch shield", clientId = 36656 },
			{ itemName = "eldritch cuirass", clientId = 36663 },
			{ itemName = "eldritch folio", clientId = 36672 },
			{ itemName = "eldritch tome", clientId = 36673 },
			{ itemName = "eldritch rod", clientId = 36674 },
			{ itemName = "eldritch wand", clientId = 36668 },
			{ itemName = "gilded eldritch claymore", clientId = 36658 },
			{ itemName = "gilded eldritch greataxe", clientId = 36662 },
			{ itemName = "gilded eldritch warmace", clientId = 36660 },
			{ itemName = "gilded eldritch wand", clientId = 36669 },
			{ itemName = "gilded eldritch rod", clientId = 36675 },
			{ itemName = "gilded eldritch bow", clientId = 36665 },
		},
		tributeCostPer10 = 1000000
	},
	["t3"] = {
		items = {
			{ itemName = "falcon circlet", clientId = 28714 },
			{ itemName = "falcon coif", clientId = 28715 },
			{ itemName = "falcon rod", clientId = 28716 },
			{ itemName = "falcon wand", clientId = 28717 },
			{ itemName = "falcon bow", clientId = 28718 },
			{ itemName = "falcon plate", clientId = 28719 },
			{ itemName = "falcon greaves", clientId = 28720 },
			{ itemName = "falcon shield", clientId = 28721 },
			{ itemName = "falcon longsword", clientId = 28723 },
			{ itemName = "falcon battleaxe", clientId = 28724 },
			{ itemName = "falcon mace", clientId = 28725 },
			{ itemName = "naga sword", clientId = 39155 },
			{ itemName = "naga axe", clientId = 39156 },
			{ itemName = "naga club", clientId = 39157 },
			{ itemName = "naga crossbow", clientId = 39159 },
			{ itemName = "naga quiver", clientId = 39160 },
			{ itemName = "naga wand", clientId = 39162 },
			{ itemName = "naga rod", clientId = 39163 },
			{ itemName = "frostflower boots", clientId = 39158 },
			{ itemName = "feverbloom boots", clientId = 39161 },
			{ itemName = "dawnfire sherwani", clientId = 39164 },
			{ itemName = "midnight tunic", clientId = 39165 },
			{ itemName = "dawnfire pantaloons", clientId = 39166 },
			{ itemName = "midnight sarong", clientId = 39167 },
			{ itemName = "enchanted turtle amulet", clientId = 39234 },
		},
		tributeCostPer10 = 1500000
	},
	["t4"] = {
		items = {
			{ itemName = "arboreal crown", clientId = 39153 },
			{ itemName = "arboreal tome", clientId = 39154 },
			{ itemName = "charged arboreal ring", clientId = 39187 },
			{ itemName = "arboreal ring", clientId = 39188 },
			{ itemName = "arcanomancer regalia", clientId = 39151 },
			{ itemName = "arcanomancer folio", clientId = 39152 },
			{ itemName = "charged arcanomancer sigil", clientId = 39184 },
			{ itemName = "arcanomancer sigil", clientId = 39185 },
			{ itemName = "alicorn headguard", clientId = 39149 },
			{ itemName = "alicorn quiver", clientId = 39150 },
			{ itemName = "charged alicorn ring", clientId = 39181 },
			{ itemName = "alicorn ring", clientId = 39182 },
			{ itemName = "spiritthorn helmet", clientId = 39148 },
			{ itemName = "spiritthorn armor", clientId = 39147 },
			{ itemName = "charged spiritthorn ring", clientId = 39178 },
			{ itemName = "spiritthorn ring", clientId = 39179 },

		},
		tributeCostPer10 = 3000000
	},
	["t5"] = {
		items = {
			{ itemName = "soulbastion", clientId = 34099 },
			{ itemName = "soulbleeder", clientId = 34088 },
			{ itemName = "soulcrusher", clientId = 34086 },
			{ itemName = "soulcutter", clientId = 34082 },
			{ itemName = "soulshredder", clientId = 34083 },
			{ itemName = "soulbiter", clientId = 34084 },
			{ itemName = "souleater", clientId = 34085 },
			{ itemName = "soulhexer", clientId = 34091 },
			{ itemName = "soultainter", clientId = 34090 },
			{ itemName = "soulpiercer", clientId = 34089 },
			{ itemName = "soulshanks", clientId = 34092 },
			{ itemName = "soulstrider", clientId = 34093 },
			{ itemName = "soulshroud", clientId = 34096 },
			{ itemName = "soulmantle", clientId = 34095 },
			{ itemName = "soulshell", clientId = 34094 },
			{ itemName = "pair of soulwalkers", clientId = 34097 },
			{ itemName = "pair of soulstalkers", clientId = 34098 },
		},
		tributeCostPer10 = 5000000
	},
}

local function getItemAndTier(itemName)
	logger.debug("Looking for: " .. itemName)
	for tier, v in pairs(itemTiers) do
		for index, item in ipairs(v.items) do
			logger.debug("Comparing with " .. item.itemName)
			if item.itemName == itemName then
				logger.debug("Items Match!")
				return { tier = tier, item = item }
			end
		end
	end
	return nil
end

local function cancelMessage(player)
	player:sendTextMessage(MESSAGE_LOOK, "Invalid input. Example !itemexchange cobra wand, cobra rod, 5 for 100% conversion success from 2x cobra wands to 1x cobra rod")
	return true
end

local function getRandomItemFromTier(tier)
	local items = itemTiers[tier].items
	return items[math.random(#items)]
end

local function lstrip(s)
	return s:match("^%s*(.*)")
end

local function rstrip(s)
	return s:match("(.-)%s*$")
end

function itemexchange.onSay(player, words, param)
	logger.debug("!itemexchange executed")
	param = param:lower()
	local paramParts = param:split(",")
	if paramParts[1] == "list" then
		-- List all items per tier
		player:sendTextMessage(MESSAGE_LOOK, "Item exchange base success is 50%. Below is items per tier:")

		for tier, v in pairs(itemTiers) do
			local tiersItemString = ""
			for _, item in ipairs(v.items) do
				tiersItemString = tiersItemString .. item.itemName .. ", "
			end
			player:sendTextMessage(MESSAGE_LOOK, tier .. ": " .. tiersItemString)
		end

		return true
	end
	if paramParts[1] == "tributefees" then
		-- list tribute fee per tier
		for tier, v in pairs(itemTiers) do
			player:sendTextMessage(MESSAGE_LOOK, "Tribute fee for " .. tier .. " is " .. v.tributeCostPer10 .. " gold per 10% bonus success rate.")
		end
		return true
	end

	local offerItem = lstrip(rstrip(paramParts[1]))
	local desiredItem = lstrip(rstrip(paramParts[2]))
	local tributes = getMoneyCount(paramParts[3] or "0")

	if tributes < 0 or tributes == nil then
		tributes = 0
	elseif tributes > 5 then
		tributes = 5
	end

	if not offerItem or not desiredItem then
		return cancelMessage(player)
	end

	local offerItemAndTier = getItemAndTier(offerItem)
	local desiredItemAndTier = getItemAndTier(desiredItem)

	if offerItemAndTier == nil or desiredItemAndTier == nil then
		return player:sendTextMessage(MESSAGE_LOOK, "Unable to find offered or desired item")
	end
	if offerItemAndTier.tier ~= desiredItemAndTier.tier then
		return player:sendTextMessage(MESSAGE_LOOK, "Items of different tiers. Check list with '!itemexchange list'")
	end
	if offerItemAndTier.item.itemName == desiredItemAndTier.item.itemName then
		return player:sendTextMessage(MESSAGE_LOOK, "Offered and desired items are identical")
	end

	local offerItemCount = player:getItemCount(offerItemAndTier.item.clientId)
	if offerItemCount < 2 then
		return player:sendTextMessage(MESSAGE_LOOK, "Insufficient count of offered item. Must have 2.")
	end

	local tributeFeePrice = tributes * itemTiers[offerItemAndTier.tier].tributeCostPer10
	local playerBalance = player:getMoney() + player:getBankBalance()
	if playerBalance < tributeFeePrice then
		return player:sendTextMessage(MESSAGE_LOOK, "Insufficient funds. " .. "Must have " .. tributeFeePrice .. " gold.")
	end

	local successRate = 50 + tributes * 10
	local roll = math.random(1, 100)

	resultingItemId = desiredItemAndTier.item.clientId
	if roll > successRate then
		-- Failed
		player:sendTextMessage(MESSAGE_LOOK, "Failed!")

		resultingItemId = getRandomItemFromTier(offerItemAndTier.tier).clientId
	else
		player:sendTextMessage(MESSAGE_LOOK, "Success!")
	end

	player:removeItem(offerItemAndTier.item.clientId, 2)
	player:addItem(resultingItemId, 1)
	if tributeFeePrice > 0 then
		player:removeMoneyBank(tributeFeePrice)
	end
	return true
end

itemexchange:separator(" ")
itemexchange:groupType("normal")
itemexchange:register()
