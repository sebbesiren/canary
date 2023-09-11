local loyaltySystem = {
	enable = configManager.getBoolean(LOYALTY_ENABLED),
	titles = {
		[1] = { name = "Scout of Mehra", points = 50 },
		[2] = { name = "Sentinel of Mehra", points = 100 },
		[3] = { name = "Steward of Mehra", points = 200 },
		[4] = { name = "Warden of Mehra", points = 400 },
		[5] = { name = "Squire of Mehra", points = 1000 },
		[6] = { name = "Warrior of Mehra", points = 2000 },
		[7] = { name = "Keeper of Mehra", points = 3000 },
		[8] = { name = "Guardian of Mehra", points = 4000 },
		[9] = { name = "Sage of Mehra", points = 5000 },
		[10] = { name = "Savant of Mehra", points = 6000 },
		[11] = { name = "Enlightened of Mehra", points = 7000 },
	},
	bonus = {
		{ minPoints = 360, percentage = 5 },
		{ minPoints = 720, percentage = 10 },
		{ minPoints = 1080, percentage = 15 },
		{ minPoints = 1440, percentage = 20 },
		{ minPoints = 1800, percentage = 25 },
		{ minPoints = 2160, percentage = 30 },
		{ minPoints = 2520, percentage = 35 },
		{ minPoints = 2880, percentage = 40 },
		{ minPoints = 3240, percentage = 45 },
		{ minPoints = 3600, percentage = 50 },
		{ minPoints = 3960, percentage = 55 },
		{ minPoints = 4320, percentage = 60 },
		{ minPoints = 4680, percentage = 65 },
		{ minPoints = 5040, percentage = 70 },
		{ minPoints = 5400, percentage = 75 },
		{ minPoints = 5760, percentage = 80 },
		{ minPoints = 6120, percentage = 85 },
		{ minPoints = 6480, percentage = 90 },
		{ minPoints = 6840, percentage = 95 },
		{ minPoints = 7200, percentage = 100 },
	},
	messageTemplate = "Due to your long-term loyalty to " .. SERVER_NAME .. " you currently benefit from a ${bonusPercentage}% bonus on all of your skills. (You have ${loyaltyPoints} loyalty points)",
}

function Player.initializeLoyaltySystem(self)
	if not loyaltySystem.enable then
		return true
	end

	local playerLoyaltyPoints = self:getLoyaltyPoints()

	-- Title
	local title = ""
	for _, titleTable in ipairs(loyaltySystem.titles) do
		if playerLoyaltyPoints >= titleTable.points then
			title = titleTable.name
		end
	end

	if title ~= "" then
		self:setLoyaltyTitle(title)
	end

	-- Bonus
	local playerBonusPercentage = 0
	for _, bonusTable in ipairs(loyaltySystem.bonus) do
		if playerLoyaltyPoints >= bonusTable.minPoints then
			playerBonusPercentage = bonusTable.percentage
		end
	end

	playerBonusPercentage = playerBonusPercentage * configManager.getFloat(configKeys.LOYALTY_BONUS_PERCENTAGE_MULTIPLIER)
	self:setLoyaltyBonus(playerBonusPercentage)

	if self:getLoyaltyBonus() ~= 0 then
		self:sendTextMessage(MESSAGE_STATUS, string.formatNamed(loyaltySystem.messageTemplate, { bonusPercentage = playerBonusPercentage, loyaltyPoints = playerLoyaltyPoints }))
	end

	return true
end
