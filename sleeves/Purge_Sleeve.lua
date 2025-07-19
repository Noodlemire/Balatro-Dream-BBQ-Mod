CardSleeves.Sleeve {
	key = "purge",
	atlas = "dbbq_sleeves",
	pos = {x = 0, y = 0},
	loc_vars = function(self)
		if self.get_current_deck_key() == "b_dbbq_purge" then
			return {key = self.key.."_double"}
		else
			--return {key = self.key}
		end
	end,
	calculate = DBBQ.purge_calc
}
