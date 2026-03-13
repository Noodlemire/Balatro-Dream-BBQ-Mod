DBBQ.suits.dbbq_travel = {
	frames = {6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
	frame = 1,
	timer = 0,
	delay = 0.13
}

SMODS.Suit {
	key = "travel",
	card_key = "TRAVEL",
	pos = {y = 6},
	ui_pos = {x = 1, y = 0},
	lc_atlas = "dbbq_suits",
	hc_atlas = "dbbq_suits",
	lc_ui_atlas = "dbbq_suit_ui",
	hc_ui_atlas = "dbbq_suit_ui",
	lc_colour = HEX("264923"),
	hc_colour = HEX("264923"),

	in_pool = function(self, args)
		return G.GAME.dbbq_spawn_custom_ranks
	end
}

local old_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
	if self == G.discard and not SMODS.has_no_suit(card) and not card.debuff and card.base and card.base.suit == "dbbq_travel" then
		return old_emplace(G.deck, card, location, stay_flipped)
	else
		return old_emplace(self, card, location, stay_flipped)
	end
end
