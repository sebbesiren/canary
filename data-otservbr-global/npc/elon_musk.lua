local internalNpcName = "Elon Musk"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 150
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 1

npcConfig.outfit = {
	lookType = 128,
	lookHead = 58,
	lookBody = 68,
	lookLegs = 38,
	lookFeet = 114,
	lookAddons = 1,
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

npcConfig.shop = {
	-- Custom T0 - Umbral
	{ itemName = "umbral blade", clientId = 20065, sell = 50000 },
	{ itemName = "umbral slayer", clientId = 20068, sell = 50000 },
	{ itemName = "umbral axe", clientId = 20071, sell = 50000 },
	{ itemName = "umbral chopper", clientId = 20074, sell = 50000 },
	{ itemName = "umbral mace", clientId = 20077, sell = 50000 },
	{ itemName = "umbral hammer", clientId = 20080, sell = 50000 },
	{ itemName = "umbral bow", clientId = 20083, sell = 50000 },
	{ itemName = "umbral crossbow", clientId = 20086, sell = 50000 },
	{ itemName = "umbral spellbook", clientId = 20089, sell = 50000 },

	-- Custom T1 - Jungle, gnome, other
	{ itemName = "exotic amulet", clientId = 35523, sell = 250000 },
	{ itemName = "throwing axe", clientId = 35515, sell = 250000 },
	{ itemName = "bast legs", clientId = 35517, sell = 250000 },
	{ itemName = "exotic legs", clientId = 35516, sell = 250000 },
	{ itemName = "jungle bow", clientId = 35518, sell = 250000 },
	{ itemName = "jungle quiver", clientId = 35524, sell = 250000 },
	{ itemName = "jungle flail", clientId = 35514, sell = 250000 },
	{ itemName = "jungle rod", clientId = 35521, sell = 250000 },
	{ itemName = "jungle wand", clientId = 35522, sell = 250000 },
	{ itemName = "makeshift boots", clientId = 35519, sell = 250000 },
	{ itemName = "make-do boots", clientId = 35520, sell = 250000 },

	{ itemName = "gnome helmet", clientId = 27647, sell = 250000 },
	{ itemName = "gnome armor", clientId = 27648, sell = 250000 },
	{ itemName = "gnome legs", clientId = 27649, sell = 250000 },
	{ itemName = "gnome shield", clientId = 27650, sell = 250000 },
	{ itemName = "gnome sword", clientId = 27651, sell = 250000 },

	{ itemName = "winged boots", clientId = 31617, sell = 250000 },
	{ itemName = "tagralt blade", clientId = 31614, sell = 250000 },
	{ itemName = "enchanted theurgic amulet", clientId = 30403, sell = 250000 },

	-- Custom T2 - Cobra, Lion, Eldritch
	{ itemName = "cobra crossbow", clientId = 30393, sell = 500000 },
	{ itemName = "cobra boots", clientId = 30394, sell = 500000 },
	{ itemName = "cobra club", clientId = 30395, sell = 500000 },
	{ itemName = "cobra axe", clientId = 30396, sell = 500000 },
	{ itemName = "cobra hood", clientId = 30397, sell = 500000 },
	{ itemName = "cobra sword", clientId = 30398, sell = 500000 },
	{ itemName = "cobra wand", clientId = 30399, sell = 500000 },
	{ itemName = "cobra rod", clientId = 30400, sell = 500000 },

	{ itemName = "lion longbow", clientId = 34150, sell = 500000 },
	{ itemName = "lion rod", clientId = 34151, sell = 500000 },
	{ itemName = "lion wand", clientId = 34152, sell = 500000 },
	{ itemName = "lion spellbook", clientId = 34153, sell = 500000 },
	{ itemName = "lion shield", clientId = 34154, sell = 500000 },
	{ itemName = "lion longsword", clientId = 34155, sell = 500000 },
	{ itemName = "lion spangenhelm", clientId = 34156, sell = 500000 },
	{ itemName = "lion plate", clientId = 34157, sell = 500000 },
	{ itemName = "lion amulet", clientId = 34158, sell = 500000 },

	{ itemName = "eldritch breeches", clientId = 36667, sell = 500000 },
	{ itemName = "eldritch cowl", clientId = 36670, sell = 500000 },
	{ itemName = "eldritch hood", clientId = 36671, sell = 500000 },
	{ itemName = "eldritch bow", clientId = 36664, sell = 500000 },
	{ itemName = "eldritch quiver", clientId = 36666, sell = 500000 },
	{ itemName = "eldritch claymore", clientId = 36657, sell = 500000 },
	{ itemName = "eldritch greataxe", clientId = 36661, sell = 500000 },
	{ itemName = "eldritch warmace", clientId = 36659, sell = 500000 },
	{ itemName = "eldritch shield", clientId = 36656, sell = 500000 },
	{ itemName = "eldritch cuirass", clientId = 36663, sell = 500000 },
	{ itemName = "eldritch folio", clientId = 36672, sell = 500000 },
	{ itemName = "eldritch tome", clientId = 36673, sell = 500000 },
	{ itemName = "eldritch rod", clientId = 36674, sell = 500000 },
	{ itemName = "eldritch wand", clientId = 36668, sell = 500000 },
	{ itemName = "gilded eldritch claymore", clientId = 36658, sell = 500000 },
	{ itemName = "gilded eldritch greataxe", clientId = 36662, sell = 500000 },
	{ itemName = "gilded eldritch warmace", clientId = 36660, sell = 500000 },
	{ itemName = "gilded eldritch wand", clientId = 36669, sell = 500000 },
	{ itemName = "gilded eldritch rod", clientId = 36675, sell = 500000 },
	{ itemName = "gilded eldritch bow", clientId = 36665, sell = 500000 },

	-- Custom T3 - Naga, Falcon,
	{ itemName = "falcon circlet", clientId = 28714, sell = 750000 },
	{ itemName = "falcon coif", clientId = 28715, sell = 750000 },
	{ itemName = "falcon rod", clientId = 28716, sell = 750000 },
	{ itemName = "falcon wand", clientId = 28717, sell = 750000 },
	{ itemName = "falcon bow", clientId = 28718, sell = 750000 },
	{ itemName = "falcon plate", clientId = 28719, sell = 750000 },
	{ itemName = "falcon greaves", clientId = 28720, sell = 750000 },
	{ itemName = "falcon shield", clientId = 28721, sell = 750000 },
	{ itemName = "falcon longsword", clientId = 28723, sell = 750000 },
	{ itemName = "falcon battleaxe", clientId = 28724, sell = 750000 },
	{ itemName = "falcon mace", clientId = 28725, sell = 750000 },

	{ itemName = "naga sword", clientId = 39155, sell = 750000 },
	{ itemName = "naga axe", clientId = 39156, sell = 750000 },
	{ itemName = "naga club", clientId = 39157, sell = 750000 },
	{ itemName = "naga crossbow", clientId = 39159, sell = 750000 },
	{ itemName = "naga quiver", clientId = 39160, sell = 750000 },
	{ itemName = "naga wand", clientId = 39162, sell = 750000 },
	{ itemName = "naga rod", clientId = 39163, sell = 750000 },
	{ itemName = "frostflower boots", clientId = 39158, sell = 750000 },
	{ itemName = "feverbloom boots", clientId = 39161, sell = 750000 },
	{ itemName = "dawnfire sherwani", clientId = 39164, sell = 750000 },
	{ itemName = "midnight tunic", clientId = 39165, sell = 750000 },
	{ itemName = "dawnfire pantaloons", clientId = 39166, sell = 750000 },
	{ itemName = "midnight sarong", clientId = 39167, sell = 750000 },
	{ itemName = "enchanted turtle amulet", clientId = 39234, sell = 750000 },

	-- Custom T4 - Gnomprona,
	{ itemName = "primal bag", clientId = 39546, sell = 1000000 },
	{ itemName = "arboreal crown", clientId = 39153, sell = 1000000 },
	{ itemName = "arboreal tome", clientId = 39154, sell = 1000000 },
	{ itemName = "charged arboreal ring", clientId = 39187, sell = 1000000 },
	{ itemName = "arboreal ring", clientId = 39188, sell = 1000000 },
	{ itemName = "arcanomancer regalia", clientId = 39151, sell = 1000000 },
	{ itemName = "arcanomancer folio", clientId = 39152, sell = 1000000 },
	{ itemName = "charged arcanomancer sigil", clientId = 39184, sell = 1000000 },
	{ itemName = "arcanomancer sigil", clientId = 39185, sell = 1000000 },
	{ itemName = "alicorn headguard", clientId = 39149, sell = 1000000 },
	{ itemName = "alicorn quiver", clientId = 39150, sell = 1000000 },
	{ itemName = "charged alicorn ring", clientId = 39181, sell = 1000000 },
	{ itemName = "alicorn ring", clientId = 39182, sell = 1000000 },
	{ itemName = "spiritthorn helmet", clientId = 39148, sell = 1000000 },
	{ itemName = "spiritthorn armor", clientId = 39147, sell = 1000000 },
	{ itemName = "charged spiritthorn ring", clientId = 39178, sell = 1000000 },
	{ itemName = "spiritthorn ring", clientId = 39179, sell = 1000000 },

	-- Custom T5 Soul Wars
	{ itemName = "bag you desire", clientId = 34109, sell = 5000000 },
	{ itemName = "soulbastion", clientId = 34099, sell = 5000000 },
	{ itemName = "soulbleeder", clientId = 34088, sell = 5000000 },
	{ itemName = "soulcrusher", clientId = 34086, sell = 5000000 },
	{ itemName = "soulcutter", clientId = 34082, sell = 5000000 },
	{ itemName = "soulshredder", clientId = 34083, sell = 5000000 },
	{ itemName = "soulbiter", clientId = 34084, sell = 5000000 },
	{ itemName = "souleater", clientId = 34085, sell = 5000000 },
	{ itemName = "soulhexer", clientId = 34091, sell = 5000000 },
	{ itemName = "soultainter", clientId = 34090, sell = 5000000 },
	{ itemName = "soulpiercer", clientId = 34089, sell = 5000000 },
	{ itemName = "soulshanks", clientId = 34092, sell = 5000000 },
	{ itemName = "soulstrider", clientId = 34093, sell = 5000000 },
	{ itemName = "soulshroud", clientId = 34096, sell = 5000000 },
	{ itemName = "soulmantle", clientId = 34095, sell = 5000000 },
	{ itemName = "soulshell", clientId = 34094, sell = 5000000 },
	{ itemName = "pair of soulwalkers", clientId = 34097, sell = 5000000 },
	{ itemName = "pair of soulstalkers", clientId = 34098, sell = 5000000 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "name") then
		return npcHandler:say("Me Elon Musk.", npc, creature)
	elseif MsgContains(message, "job") then
		return npcHandler:say("I sell Teslas and can take you to space!", npc, creature)
	elseif MsgContains(message, "passage") then
		return npcHandler:say("Soso yana. <shakes his head>", npc, creature)
	end
	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Wroom wrooom goes the Tesla.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
