local zone = Zone("edron.orshabaal")
zone:addArea(Position(33118, 31699, 7), Position(33119, 31700, 7))

local raid = Raid("edron.orshabaal", {
	zone = zone,
	allowedDays = { "Friday" },
	minActivePlayers = 0,
	initialChance = 15,
	targetChancePerDay = 15,
	maxChancePerCheck = 15,
	maxChecksPerDay = 1,
	minGapBetween = "672h",
})


raid:addBroadcast("Orshabaal's minions are working on his return to the World. LEAVE Edron at once, mortals."):autoAdvance("5s")
raid:addBroadcast("Orshabaal is about to make his way into the mortal realm. Run for your lives!"):autoAdvance("20s")
raid:addBroadcast("Orshabaal has been summoned from hell to plague the lands of mortals once again."):autoAdvance("60s")

raid
	:addSpawnMonsters({
		{
			name = "Orshabaal",
			amount = 1,
		},
	})

raid:register()
