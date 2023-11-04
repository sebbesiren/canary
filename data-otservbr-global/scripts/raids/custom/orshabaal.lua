local zone = Zone("edron.orshabaal")
zone:addArea(Position(33118, 31699, 7), Position(33119, 31700, 7))

local raid = Raid("edron.orshabaal", {
	zone = zone,
	allowedDays = { "Friday" },
	minActivePlayers = 0,
	targetChancePerDay = 25,
	maxChancePerCheck = 100,
	minGapBetween = "672h",
})

raid:addBroadcast("Orshabaal's minions are working on his return to the World. LEAVE Edron at once, mortals.", WEBHOOK_COLOR_RAID, "Incoming Boss!"):autoAdvance("5s")
raid:addBroadcast("Orshabaal is about to make his way into the mortal realm. Run for your lives!", WEBHOOK_COLOR_RAID, "Incoming Boss!"):autoAdvance("20s")
raid:addBroadcast("Orshabaal has been summoned from hell to plague the lands of mortals once again.", WEBHOOK_COLOR_RAID, "Incoming Boss!"):autoAdvance("60s")

raid
	:addSpawnMonsters({
		{
			name = "Orshabaal",
			amount = 1,
		},
	})
	:autoAdvance("12h")

raid:register()
