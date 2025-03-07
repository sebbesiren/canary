local zone = Zone("death_knights.athelstan")
zone:addArea(Position(6294, 5899, 5), Position(6303, 5905, 5))

local raid = Raid("death_knights.athelstan", {
	zone = zone,
	allowedDays = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
	minActivePlayers = 0,
	targetChancePerDay = 33,
	maxChancePerCheck = 100,
	minGapBetween = "60h",
})

raid:addBroadcast("A twisting energy is emitting from the fortress of death."):autoAdvance("10m")
raid:addBroadcast("Death Lord Athelstan has returned."):autoAdvance("5s")

raid
	:addSpawnMonsters({
		{
			name = "Death Knight",
			amount = 3,
		},
		{
			name = "Death Paladin",
			amount = 3,
		},
		{
			name = "Death Necromancer",
			amount = 1,
		},
		{
			name = "Death Lord Athelstan",
			amount = 1,
		},
	})
	:autoAdvance("12h")

raid:register()
