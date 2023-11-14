local hazard = Hazard.new({
	name = "hazard.prison",
	from = Position(33500, 32325, 10),
	to = Position(33630, 32440, 8),
	maxLevel = 20,
	storageMax = nil,
	storageCurrent = nil,

	crit = true,
	dodge = true,
	damageBoost = true,
})

hazard:register()

local prisonKill = CreatureEvent("PrisonKill")
