DBBQ.suits.dbbq_grit = {
	frames = {0, 0, 1, 0, 0, 0, 2, 3, 4, 4, 4, 4, 3, 4, 4, 4, 4, 4, 3, 2, 2, 5, 2, 2, 5, 2, 5, 1, 0, 0, 0, 0, 1, 5, 1},
	frame = 1,
	timer = 0,
	delay = 0.13
}

SMODS.Suit {
	key = "grit",
	card_key = "GRIT",
	pos = {y = 0},
	ui_pos = {x = 0, y = 0},
	lc_atlas = "dbbq_suits",
	hc_atlas = "dbbq_suits",
	lc_ui_atlas = "dbbq_suit_ui",
	hc_ui_atlas = "dbbq_suit_ui",
	lc_colour = HEX("af2e20"),
	hc_colour = HEX("af2e20"),

	in_pool = function(self, args)
		return G.GAME.dbbq_spawn_custom_ranks
	end
}

local old_scc = SMODS.calculate_context
function SMODS.calculate_context(context, return_table, no_resolve)
	local ret = old_scc(context, return_table, no_resolve)

	if context.destroy_card and context.cardarea == G.play and context.destroy_card.base.suit == "dbbq_grit" and not SMODS.has_no_suit(context.destroy_card) and not context.destroy_card.debuff then
		for _, card in ipairs(context.scoring_hand) do
			if card.base.suit == "dbbq_grit" and not SMODS.has_no_suit(card) then
				if card == context.destroy_card then
					return {remove = true}
				else
					return ret
				end
			end
		end
	end

	return return_table or ret
end
