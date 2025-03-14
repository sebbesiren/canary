-- Usage talkaction: "!hazardpod on" or "!hazardpod off"
local hazardpod = TalkAction("!hazardpod")

function hazardpod.onSay(player, words, param)
	logger.debug("!hazardpod executed")

	if param == "" then
		player:sendCancelMessage("Please specify the parameter: 'on' to activate or 'off' to deactivate.")
		return true
	end

	if param == "on" then
		player:kv():set("hazard-pod-active", true)
		player:sendTextMessage(MESSAGE_LOOK, "You have activated hazard pods.")
	elseif param == "off" then
		player:kv():set("hazard-pod-active", false)
		player:sendTextMessage(MESSAGE_LOOK, "You have deactivated hazard pods.")
	end
	return true
end

hazardpod:separator(" ")
hazardpod:groupType("normal")
hazardpod:register()
