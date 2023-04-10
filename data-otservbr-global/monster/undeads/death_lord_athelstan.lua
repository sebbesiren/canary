local mType = Game.createMonsterType("Death Lord Athelstan")
local monster = {}

athelstanConfig = {
	Storage = {
		Life = 1,
	},
	AmountLife = 3,
	Monster = {
		"Death Knight",
		"Death Paladin"
	},
}

monster.description = "Death Lord Athelstan"
monster.outfit = {
	lookType = 1072,
	lookHead = 95,
	lookBody = 114,
	lookLegs = 115,
	lookFeet = 132,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 100000
monster.maxHealth = monster.health
monster.experience = monster.health * 8 * athelstanConfig.AmountLife
monster.race = "blood"
monster.corpse = 28625
monster.speed = 115
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.bosstiary = {
	bossRaceId = 1576,
	bossRace = RARITY_ARCHFOE,
	storageCooldown = Storage.TheSecretLibrary.TheOrderOfTheFalcon.OberonTimer
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
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 70,
	targetDistance = 1,
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
}

monster.loot = {
	{ id = 3039, chance = 2220, maxCount = 20 }, -- red gem
	{ name = "crystal coin", chance = 100000, minCount = 10, maxCount = 60 },
	{ name = "falcon battleaxe", chance = 500, maxCount = 1 },
	{ name = "falcon longsword", chance = 500, maxCount = 1 },
	{ name = "falcon mace", chance = 500, maxCount = 1 },
	{ name = "grant of arms", chance = 500, maxCount = 1 },
	{ name = "falcon bow", chance = 350, maxCount = 1 },
	{ name = "falcon circlet", chance = 350, maxCount = 1 },
	{ name = "falcon coif", chance = 350, maxCount = 1 },
	{ name = "falcon rod", chance = 350, maxCount = 1 },
	{ name = "falcon wand", chance = 350, maxCount = 1 },
	{ name = "falcon shield", chance = 200, maxCount = 1 },
	{ name = "falcon greaves", chance = 200, maxCount = 1 },
	{ name = "falcon plate", chance = 200, maxCount = 1 },

	{ name = "naga wand", chance = 200},
	{ name = "naga sword", chance = 200},
	{ name = "naga rod", chance = 200},
	{ name = "naga quiver", chance = 200},
	{ name = "naga club", chance = 200},
	{ name = "naga crossbow", chance = 200},
	{ name = "dawnfire sherwani", chance = 200},
	{ name = "dawnfire pantaloons", chance = 200},
	{ name = "midnight sarong", chance = 200},
	{ name = "midnight tunic", chance = 200},
	{ name = "feverbloom boots", chance = 200},
	{ id = 39234, chance = 200}, -- enchanted turtle amulet
	{ name = "frostflower boots", chance = 200},
	{id = 5903, chance = 100, unique = true}, -- ferumbras' hat

	{ id = 20062, chance = 2000, maxCount = 14 }, -- cluster of solace
	{ name = "gold token", chance = 5000 },
	{ name = "silver token", chance = 5000 },
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -1200 },
	{ name = "combat", interval = 6000, chance = 80, type = COMBAT_HOLYDAMAGE, minDamage = -1000, maxDamage = -2250, length = 8, spread = 3, effect = CONST_ME_HOLYAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_EARTHDAMAGE, minDamage = -820, maxDamage = -1450, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "combat", interval = 2000, chance = 20, type = COMBAT_DEATHDAMAGE, minDamage = -860, maxDamage = -1500, range = 7, shootEffect = CONST_ANI_SUDDENDEATH, effect = CONST_ME_MORTAREA, target = false },
	{ name = "Shotgun", interval = 2000, chance = 10, minDamage = -860, maxDamage = -1500, target = false },
	{ name = "Holy Bomb Slash", interval = 2000, chance = 20, minDamage = -820, maxDamage = -1450, target = false },
	{ name = "Rotating Wheel", interval = 60000, chance = 50, target = false },
}

monster.defenses = {
	defense = 60,
	armor = 82,
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -5 },
	{ type = COMBAT_EARTHDAMAGE, percent = 5 },
	{ type = COMBAT_FIREDAMAGE, percent = -5 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = -25 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 }
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = true },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false }
}

mType.onThink = function(monster, interval)
	local currentLives = monster:getStorageValue(athelstanConfig.Storage.Life)
	if currentLives == 0 then
		return
	end
	local percentageHealth = (monster:getHealth() * 100) / monster:getMaxHealth()
	if percentageHealth <= 20 then
		monster:setStorageValue(athelstanConfig.Storage.Life, currentLives - 1)
		monster:addHealth(monster:getMaxHealth())
		Game.createMonster(athelstanConfig.Monster[math.random(#athelstanConfig.Monster)], monster:getPosition(), true, true)
	end
end

mType.onAppear = function(monster, creature)
	if monster:getId() == creature:getId() then
		monster:setStorageValue(athelstanConfig.Storage.Life, athelstanConfig.AmountLife)
	end
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
