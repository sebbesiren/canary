-- Usage talkaction: "!hazardboss on" or "!hazardboss off"
local hazardboss = TalkAction("!hazardboss")

function hazardboss.onSay(player, words, param)
	logger.debug("!hazardboss executed")

	if param == "" then
		player:sendCancelMessage("Please specify the parameter: 'on' to activate or 'off' to deactivate.")
		return true
	end

	if param == "on" then
		player:kv():set("hazard-boss-deactivated", false)
		player:sendTextMessage(MESSAGE_LOOK, "You have activated hazard boss spawn.")
	elseif param == "off" then
		player:kv():set("hazard-boss-deactivated", true)
		player:sendTextMessage(MESSAGE_LOOK, "You have deactivated hazard boss spawn.")
	end
	return true
end

hazardboss:separator(" ")
hazardboss:groupType("normal")
hazardboss:register()
