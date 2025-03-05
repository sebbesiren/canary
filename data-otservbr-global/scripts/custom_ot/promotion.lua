local config = {
	[8] = { -- Elite knight
		toVoc = 20,
		level = 500,
		bonusPercentage = 10,
		base = "knight",
	},
	[20] = { -- Heroic knight
		toVoc = 21,
		level = 1000,
		bonusPercentage = 25,
		base = "knight",
	},
	[7] = { -- Royal paladin
		toVoc = 22,
		level = 500,
		bonusPercentage = 10,
		base = "paladin",
	},
	[22] = { -- heroic paladin
		toVoc = 23,
		level = 1000,
		bonusPercentage = 25,
		base = "paladin",
	},
	[6] = { -- elder druid
		toVoc = 24,
		level = 500,
		bonusPercentage = 10,
		base = "mage",
	},
	[24] = { -- heroic druid
		toVoc = 25,
		level = 1000,
		bonusPercentage = 25,
		base = "mage",
	},
	[5] = { -- Master Sorcerer
		toVoc = 26,
		level = 500,
		bonusPercentage = 10,
		base = "mage",
	},
	[26] = { -- Heroic sorcerer
		toVoc = 27,
		level = 1000,
		bonusPercentage = 25,
		base = "mage",
	},
}

local bases = {
	["knight"] = {
		health = 185,
		mana = 50,
	},
	["paladin"] = {
		health = 185,
		mana = 90,
	},
	["mage"] = {
		health = 185,
		mana = 90,
	},
}

CustomPromotion = {}
__Functions = {
	getPromotionStatus = function(self, player)
		local data = self:_getPromotionData(player)
		if not data then
			return {
				available = false,
				message = "No promotions available.",
			}
		end

		local playerLevel = player:getLevel()
		if playerLevel < data.level then
			return {
				available = false,
				message = "Your level is too low. Come back once you are level " .. data.level .. ".",
			}
		end

		return {
			available = true,
			message = "Promotion will give you a " .. data.bonusPercentage .. "% bonus to offensive and defensive abilities. You will be reset to level 8 in the process. Any level above " .. data.level .. " will be added after the reset. Do you want me to promote you?",
		}
	end,
	promotePlayer = function(self, player)
		local data = self:_getPromotionData(player)
		local status = self:getPromotionStatus(player)
		if not data or status.available == false then
			return false
		end

		local additionalLevels = player:getLevel() - data.level
		self:_resolvePromotion(player, data, additionalLevels)

		return true
	end,
	ensure_bonuses = function(self, player)
		local currentVocationId = player:getVocation():getId()

		for _, data in pairs(config) do
			if data.toVoc == currentVocationId then
				player:kv():scoped("custom-promotion"):set("low-level-bonus-exp", data.level)
				player:kv():scoped("custom-promotion"):set("bonus-damage", data.bonusPercentage)
				return true
			end
		end
	end,
	_getPromotionData = function(self, player)
		local currentVocationId = player:getVocation():getId()
		return config[currentVocationId]
	end,
	_resolvePromotion = function(self, player, data, additionalLevels)
		local base = bases[data.base]
		if not base then
			return false
		end
		player:setVocation(data.toVoc)

		local baseLevel = 8
		player:setLevel(baseLevel)
		self:_addExp(player, additionalLevels)
		local newLevel = player:getLevel()

		local baseHealth = math.ceil(base.health * (100 + data.bonusPercentage) / 100)
		local baseMana = math.ceil(base.mana * (100 + data.bonusPercentage) / 100)
		local baseCap = math.ceil(47000 * (100 + data.bonusPercentage) / 100)

		player:setMaxHealth(baseHealth + (newLevel - baseLevel) * player:getVocation():getHealthGain())
		player:setMaxMana(baseMana + (newLevel - baseLevel) * player:getVocation():getManaGain())
		player:setCapacity(baseCap + (newLevel - baseLevel) * player:getVocation():getCapacityGain())

		player:kv():scoped("custom-promotion"):set("low-level-bonus-exp", data.level)
		player:kv():scoped("custom-promotion"):set("bonus-damage", data.bonusPercentage)
		player:save()
		player:reloadData()
		return true
	end,
	_addExp = function(self, player, additionalLevels)
		if additionalLevels <= 0 then
			return false
		end
		local newLevel = player:getLevel() + additionalLevels
		local expToAdd = Game.getExperienceForLevel(newLevel) - player:getExperience()

		player:addExperience(expToAdd, false)
		return true
	end,
}
CustomPromotion = setmetatable(CustomPromotion, { __index = __Functions })

local customPromotionLogin = CreatureEvent("CustomPromotionLogin")
function customPromotionLogin.onLogin(player)
	CustomPromotion:ensure_bonuses(player)
	return true
end

customPromotionLogin:register()
