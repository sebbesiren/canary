local zone = Zone("lightbearer.lightbearer_event")
zone:addArea(Position(1102, 953, 7), Position(1118, 970, 7))

local raid = Raid("lightbearer.lightbearer_event", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 1,
	initialChance = 0.08,
	targetChancePerDay = 0.04,
	maxChancePerCheck = 0.8,
	minGapBetween = "24h",
})

raid:addBroadcast("Lightbearer creatures are spawning in Boss Arena in 10 minutes!"):autoAdvance("10m")
raid:addBroadcast("Lightbearer creatures has spawned in Boss Arena."):autoAdvance("5s")

raid
	:addSpawnMonsters({
		{
			name = "Bane Of Light",
			amount = 4,
		},
		{
			name = "Midnight Spawn",
			amount = 4,
		},
		{
			name = "Herald of Gloom",
			amount = 4,
		},
		{
			name = "Duskbringer",
			amount = 4,
		},
		{
			name = "Acolyte of Darkness",
			amount = 4,
		},
		{
			name = "Herald of Gloom",
			amount = 4,
		},
		{
			name = "Shadow Hound",
			amount = 4,
		},
	})
	:autoAdvance("2h")

raid:register()
