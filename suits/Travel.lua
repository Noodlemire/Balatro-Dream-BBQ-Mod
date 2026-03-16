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

local old_scc = SMODS.calculate_context
function SMODS.calculate_context(context, return_table, no_resolve)
	local ret = old_scc(context, return_table, no_resolve)

	if context.after then
		local travels = 0
		for _, card in ipairs(context.scoring_hand) do
			if not SMODS.has_no_suit(card) and not card.debuff and not card.getting_sliced and card.base.suit == "dbbq_travel" then
				travels = travels + 1
			end
		end
		for i = 1, travels do
			for _, card in ipairs(context.scoring_hand) do
				if not card.debuff then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.5,
						func = function()
							SMODS.modify_rank(card, 1)
							play_sound("tarot1")
							card:juice_up()
							return true
						end,
					}))
				end
			end
		end
	end

	return return_table or ret
end

--[[local old_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
	if self == G.discard and not SMODS.has_no_suit(card) and not card.debuff and card.base and card.base.suit == "dbbq_travel" then
		return old_emplace(G.deck, card, location, stay_flipped)
	else
		return old_emplace(self, card, location, stay_flipped)
	end
end--]]
