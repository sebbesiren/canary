local internalNpcName = "Hazard Guide"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

local hazards = {
	{ name = "Prison", hazard = Hazard.getByName("hazard.prison") },
	{ name = "Asura Mirror", hazard = Hazard.getByName("hazard.asura-mirror")},
	{ name = "Edron Hero Cave", hazard = Hazard.getByName("hazard.edron-hero-cave") },
	{ name = "Banuta", hazard = Hazard.getByName("hazard.banuta") },
}
local hazardKeys = ""
for index, value in ipairs(hazards) do
	hazardKeys = hazardKeys .. "{" .. value.name .. "}"

	if index < #hazards then
		hazardKeys = hazardKeys .. ", "
	end
end
local baseMessage = "Which hazard level do you wish to modify? (" .. hazardKeys .. ")"
local selectedHazard = nil

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 493,
	lookHead = 110,
	lookBody = 65,
	lookLegs = 110,
	lookFeet = 110,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = " I'll have to write that idea down." },
	{ text = "So many ideas, so little time" },
	{ text = "Muhahaha!" },
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

	if npcHandler:getTopic(playerId) == 0 then
		for _, value in ipairs(hazards) do
			if value.name == message then
				selectedHazard = value.hazard
			end
		end

		if selectedHazard then
			local current = selectedHazard:getPlayerCurrentLevel(player)
			local maximum = selectedHazard:getPlayerMaxLevel(player)
			npcHandler:say("I can change your hazard level to spice up your hunt. Your current level is set to " .. current .. ". Lowest is { 0 } and your maximum unlocked level is {" .. maximum .. "}. What level would you like to hunt in?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
		return true
	end

	if npcHandler:getTopic(playerId) == 1 then
		local desiredLevel = getMoneyCount(message)
		if desiredLevel == -1 and message == "0" then
			desiredLevel = 0
		end
		logger.info(desiredLevel)
		if desiredLevel < 0 then
			npcHandler:say("I'm sorry, I don't understand. What hazard level would you like to set?", npc, creature)
			return true
		end
		if selectedHazard:setPlayerCurrentLevel(player, desiredLevel) then
			npcHandler:say("Your hazard level has been set to " .. desiredLevel .. ". Good luck!", npc, creature)
			selectedHazard = nil
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say("You can't set your hazard level higher than your maximum unlocked level.", npc, creature)
		end
	end
	return true
end

keywordHandler:addGreetKeyword({ "hi" }, { npcHandler = npcHandler, text = baseMessage })
keywordHandler:addAliasKeyword({ "hello" })

npcHandler:setMessage(MESSAGE_GREET, baseMessage)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
