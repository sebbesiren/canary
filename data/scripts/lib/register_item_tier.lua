registerItemClassification = {}
setmetatable(registerItemClassification, {
	__call = function(self, itemClass, mask)
		for _, parse in pairs(self) do
			parse(itemClass, mask)
		end
	end,
})

ItemClassification.register = function(self, mask)
	return registerItemClassification(self, mask)
end

registerItemClassification.Upgrades = function(itemClassification, mask)
	if mask.Upgrades then
		for _, value in ipairs(mask.Upgrades) do
			if value.TierId then
				logger.debug("Registering tier {}, core {}, regular price {}, fusion price {}, transfer price {}", value.TierId, value.Core, value.RegularPrice, value.ConvergenceFusionPrice, value.ConvergenceTransferPrice)

				local regularPrice = math.ceil(value.RegularPrice / 2)
				local convergenceFusionPrice = regularPrice * 3
				local convergenceTransferPrice = convergenceFusionPrice * 2
				itemClassification:addTier(value.TierId, math.ceil(value.Core / 2), regularPrice, convergenceFusionPrice, convergenceTransferPrice)
			else
				logger.warn("[registerItemClassification.Upgrades] - Item classification failed on adquire TierID or Price attribute.")
			end
		end
	end
end
