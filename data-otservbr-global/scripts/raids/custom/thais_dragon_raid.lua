local zone = Zone("thais.dragon_raid")
zone:addArea(Position(32441, 32208, 7), Position(32468, 32229, 7))

local raid = Raid("thais.dragon_raidn", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 1,
	targetChancePerDay = 5,
	maxChancePerCheck = 5,
	minGapBetween = "48h",
})

raid:addBroadcast("Dragon have been sighted east of Thais..."):autoAdvance("5m")
raid:addBroadcast("The dragon has launched an attack! Heroes are needed "):autoAdvance("5s")

raid
	:addSpawnMonsters({
		{
			name = "Dragon",
			amount = 20,
		},
		{
			name = "Dragon Lord",
			amount = 15,
		},
		{
			name = "Dragonling",
			amount = 5,
		},
		{
			name = "Dragolisk",
			amount = 5,
		},
		{
			name = "Mega Dragon",
			amount = 5,
		},
		{
			name = "Wardragon",
			amount = 5,
		},
	})
	:autoAdvance("12h")

raid:register()
