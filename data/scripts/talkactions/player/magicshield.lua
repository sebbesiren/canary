-- Usage talkaction: "!refill will refill all your amulets and rings for silver tokens"
local magicshield = TalkAction("!magicshield")

local silverTokenID = 22516

function magicshield.onSay(player, words, param)
	logger.debug("!magicshield executed")
	local silverTokensCount = player:getItemCount(silverTokenID)
	local allowedVocations = {
		VOCATION.BASE_ID.SORCERER,
		VOCATION.BASE_ID.DRUID,
	}

	if not table.contains(allowedVocations, player:getVocation():getBaseId()) then
		player:sendTextMessage(MESSAGE_LOOK, "Only Druid and Sorcerers can use this talkaction")
		return true
	end

	local timeNextUse = player:kv():get("magic-shield-talkaction") or 0
	if os.time() < timeNextUse then
		return true -- on cooldown
	end
	if silverTokensCount < 1 then
		player:sendTextMessage(MESSAGE_LOOK, "You lack silver tokens.")
		return true
	end

	player:kv():set("magic-shield-talkaction", os.time() + 2)
	player:removeItem(silverTokenID, 1)
	local condition = Condition(CONDITION_MANASHIELD)
	condition:setParameter(CONDITION_PARAM_TICKS, 60000)
	condition:setParameter(CONDITION_PARAM_MANASHIELD, math.min(player:getMaxMana(), 300 + 7.6 * player:getLevel() + 7 * player:getMagicLevel()))
	player:addCondition(condition)

	return true
end

magicshield:separator(" ")
magicshield:groupType("normal")
magicshield:register()
