local internalNpcName = "Tharion the Soulforger"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100000
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 278,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "promot") or MsgContains(message, "remade") then
		local promotionStatus = CustomPromotion:getPromotionStatus(player)
		if promotionStatus.available then
			npcHandler:setTopic(playerId, 1)
		end
		npcHandler:say(promotionStatus.message, npc, creature)
	elseif npcHandler:getTopic(playerId) == 1 then
		if MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 1 then
			if CustomPromotion:promotePlayer(player) then
				local vocationName = player:getVocation():getName()
				player:say("The hammer falls, and the forge roars! Thy soul is tempered anew, " .. vocationName .. ". Rise, forged in fire and might-none shall break thee now!", TALKTYPE_MONSTER_SAY)
			end
			npcHandler:unGreet(npc, creature)
		elseif MsgContains(message, "no") then
			npcHandler:say("So be it. The forge cools for now, but its embers never die. Crawl back when thy soul's ready to face its destiny-or don't. The weak forge naught but dust.", npc, creature)
			npcHandler:unGreet(npc, creature)
		else
			npcHandler:say("Spare me thy prattle. I wield the hammer o' souls, not idle tongues. Speak o' thy trial, thy worth, or begone-the forge heeds no trifles.", npc, creature)
		end
	else
		npcHandler:say("Spare me thy prattle. I wield the hammer o' souls, not idle tongues. Speak o' thy trial, thy worth, or begone-the forge heeds no trifles.", npc, creature)
	end

	return true
end

npcHandler:setMessage(MESSAGE_WALKAWAY, "So be it. The forge cools for now, but its embers never die. Crawl back when thy soul's ready to face its destiny-or don't. The weak forge naught but dust.")
npcHandler:setMessage(MESSAGE_FAREWELL, "So be it. The forge cools for now, but its embers never die. Crawl back when thy soul's ready to face its destiny-or don't. The weak forge naught but dust.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hail, wanderer. I am Tharion the Soulforger, keeper o' the Forge. The fires burn hot, and the anvil waits-hast thou the mettle to be {remade}, or art thou just another spark to fade?")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
