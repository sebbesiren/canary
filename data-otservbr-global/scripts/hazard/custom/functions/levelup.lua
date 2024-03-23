function attemptLevelUpPlayer(hazard, player, hazardLevelOfKilledCreature)
	if hazard:getPlayerMaxLevel(player) == hazardLevelOfKilledCreature then
		hazard:levelUp(player)
		if hazard:setPlayerCurrentLevel(player, hazardLevelOfKilledCreature + 1) then
			player:sendTextMessage(MESSAGE_LOOK, "Hazard level set to " .. hazardLevelOfKilledCreature + 1)
		end
	end
end
