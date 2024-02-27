-- Usage talkaction: "!forge opens the forge"
local forge = TalkAction("!forge")

function forge.onSay(player, words, param)
	logger.debug("!forge executed")

	player:openForge()

	return true
end

forge:separator(" ")
forge:groupType("normal")
forge:register()
