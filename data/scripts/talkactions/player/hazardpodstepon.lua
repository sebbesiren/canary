-- Usage talkaction: "!hazardboss on" or "!hazardboss off"
local hazardpodstepon = TalkAction("!hazardpodstepon")

function hazardpodstepon.onSay(player, words, param)
	logger.debug("!hazardpodstepon executed")

	if param == "" then
		player:sendCancelMessage("Please specify the parameter: 'on' to activate or 'off' to deactivate.")
		return true
	end

	if param == "on" then
		player:kv():set("hazard-pod-step-on-active", true)
		player:sendTextMessage(MESSAGE_LOOK, "Stepping on hazard pod will remove them.")
	elseif param == "off" then
		player:kv():set("hazard-pod-step-on-active", false)
		player:sendTextMessage(MESSAGE_LOOK, "Stepping on hazard pods will not remove them.")
	end
	return true
end

hazardpodstepon:separator(" ")
hazardpodstepon:groupType("normal")
hazardpodstepon:register()
