local zone = Zone("thais.demon")
zone:addArea(Position(32310, 32293, 7), Position(32346, 32306, 7))

local raid = Raid("thais.demon", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 1,
	targetChancePerDay = 5,
	maxChancePerCheck = 10,
	minGapBetween = "48h",
})

raid:addBroadcast("Demons are launching an attack on Thais from the south..."):autoAdvance("5m")
raid:addBroadcast("The demons rise from the deepest parts of hell."):autoAdvance("5s")

raid
	:addSpawnMonsters({
		{
			name = "Demon",
			amount = 40,
		},
	})
	:autoAdvance("12h")

raid:register()
