local mType = Game.createMonsterType("Orc Pyromancer")
local monster = {}

monster.health = 6000
monster.maxHealth = monster.health

monster.description = "an Orc Pyromancer"
monster.experience = monster.health * 1.5
monster.outfit = {
	lookType = 6,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}
monster.Bestiary = {
	class = "Humanoid",
	race = BESTY_RACE_HUMANOID,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Orc Main Fortress."
}

monster.race = "blood"
monster.corpse = 5978
monster.speed = 90
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = false,
	canPushCreatures = false,
	staticAttackChance = 90,
	targetDistance = 5,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "BURN TO ASHES!!!", yell = false }
}

monster.loot = {
	{ name = "platinum coin", chance = 100000, minCount = 10, maxCount = 80 },
	{ id = 20089, chance = 200 }, -- umbral spellbook
	{ id = 16114, chance = 200 }, -- prismatic ring
	{ id = 16129, chance = 200 }, -- major crystalline token
}

monster.attacks = {
	{ name = "combat", interval = 2000, chance = 100, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -450, range = 5, radius = 1, shootEffect = CONST_ANI_FIRE, target = true },
	{ name = "combat", interval = 10000, chance = 100, type = COMBAT_FIREDAMAGE, minDamage = -500, maxDamage = -800, radius = 8, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = false },
	{ name = "condition", type = CONDITION_FIRE, interval = 8000, chance = 100, minDamage = -0, maxDamage = -100, range = 5, radius = 4, target = true },
}

monster.defenses = {
	defense = 50,
	armor = 50,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 20 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 10 },
	{ type = COMBAT_DEATHDAMAGE, percent = -10 }
}

monster.immunities = {
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = true }
}

mType:register(monster)
