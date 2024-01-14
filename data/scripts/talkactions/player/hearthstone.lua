-- Usage talkaction: "!hearthstone"
local hearthstone = TalkAction("!hearthstone")

function hearthstone.onSay(player, words, param)
	logger.debug("!hearthstone executed")

	local cooldown = 60 * 60 -- 1h
	local nextAvailable = (player:kv():get("hearthstone") or 0) + cooldown
	local currentTimeSeconds = os.time()

	if nextAvailable > currentTimeSeconds then
		local remainingMinutes = math.ceil((nextAvailable - currentTimeSeconds) / 60)

		player:sendTextMessage(MESSAGE_LOOK, "Hearthstone on cooldown for " .. remainingMinutes .. " minutes.")
		return true
	end

	local pcallOk, pcallError = pcall(function()
		GameStore.processTempleTeleportPurchase(player)
	end)

	if pcallOk then
		player:kv():set("hearthstone", currentTimeSeconds)
	else
		player:sendTextMessage(MESSAGE_LOOK, "Unable to use hearthstone in combat or when pz locked...")
	end
	return true
end

hearthstone:separator(" ")
hearthstone:groupType("normal")
hearthstone:register()
