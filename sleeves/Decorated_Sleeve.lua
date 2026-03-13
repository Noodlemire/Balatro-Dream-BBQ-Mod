CardSleeves.Sleeve {
	key = "deco",
	atlas = "dbbq_sleeves",
	pos = {x = 1, y = 0},
	loc_vars = function(self)
		if self.get_current_deck_key() == "b_dbbq_deco" then
			return {key = self.key.."_double"}
		end
	end,
	apply = function(self, sleeve)
		DBBQ.deco_prune_deck(self.get_current_deck_key() ~= "b_dbbq_deco")
	end
}
