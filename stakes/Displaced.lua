SMODS.Stake {
	key = "displaced",
	applied_stakes = {"dbbq_mean"},
	above_stake = "dbbq_mean",
	atlas = "dbbq_stakes",
	pos = {x = 2, y = 1},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 2, y = 2},
	colour = HEX("99bccf"),
	modifiers = function()
		G.GAME.modifiers.enable_dbbq_toll = true
	end
}

SMODS.Sticker {
	key = "toll",
	atlas = "dbbq_stickers",
	pos = {x = 2, y = 0},
	default_compat = true,
	sets = {Joker = true},
	rate = 0.3,
	needs_enable_flag = true,
	badge_colour = HEX("582508"),
	should_apply = function(self, joker, center, area, bypass_roll)
		if area == G.jokers then return false end
		return SMODS.Sticker.should_apply(self, joker, center, area, bypass_roll)
	end,
	apply = function(self, joker, val)
		SMODS.Sticker.apply(self, joker, val)
		if joker.added_to_deck then
			local num = val and -1 or 1
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + num
			ease_hands_played(num)
		end
	end,
	dbbq_add_or_remove = function(self, joker, val)
		local num = val and -1 or 1
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + num
		ease_hands_played(num)
	end
}

table.insert(DBBQ.calculates, function(context)
	if (context.card_added or context.joker_type_destroyed or context.selling_card) and context.card.ability.dbbq_toll then
		SMODS.Stickers.dbbq_toll:dbbq_add_or_remove(context.card, context.card_added or false)
	end
end)
