local zone = Zone("thais.lightbearer_event")
zone:addArea(Position(32441, 32208, 7), Position(32468, 32229, 7))

local raid = Raid("thais.lightbearer_event", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 1,
	targetChancePerDay = 3,
	maxChancePerCheck = 100,
	minGapBetween = "24h",
})

raid:addBroadcast("Creatures of the light are plotting an invasion of thais!"):autoAdvance("10m")
raid:addBroadcast("Creatures of the light are invading thais from the east."):autoAdvance("5s")

raid
	:addSpawnMonsters({
		{
			name = "Bane Of Light",
			amount = 8,
		},
		{
			name = "Midnight Spawn",
			amount = 8,
		},
		{
			name = "Herald of Gloom",
			amount = 8,
		},
		{
			name = "Duskbringer",
			amount = 8,
		},
		{
			name = "Acolyte of Darkness",
			amount = 8,
		},
		{
			name = "Herald of Gloom",
			amount = 8,
		},
		{
			name = "Shadow Hound",
			amount = 8,
		},
	})
	:autoAdvance("2h")

raid:register()
