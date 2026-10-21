SMODS.Stake {
	key = "bbq",
	applied_stakes = {"dbbq_hunger"},
	above_stake = "dbbq_hunger",
	atlas = "dbbq_stakes",
	pos = {x = 4, y = 1},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 4, y = 2},
	colour = HEX("157516"),
	modifiers = function()
		G.GAME.modifiers.enable_dbbq_husk = true
	end
}

SMODS.Sticker {
	key = "husk",
	atlas = "dbbq_stickers",
	pos = {x = 3, y = 0},
	default_compat = true,
	sets = {Joker = true},
	rate = 0.3,
	needs_enable_flag = true,
	badge_colour = HEX("157516"),
	config = {unperish_tally = 0},
	loc_vars = function(self, info_queue, joker)
		return {vars = {joker.ability.dbbq_husk.unperish_tally}}
	end,
	should_apply = function(self, joker, center, area, bypass_roll)
		if area == G.jokers then return false end
		return SMODS.Sticker.should_apply(self, joker, center, area, bypass_roll)
	end,
	apply = function(self, joker, val)
		SMODS.Sticker.apply(self, joker, val)
		if joker.added_to_deck then
			SMODS.debuff_card(joker, val, "dbbq_husk")
		end
	end,
	dbbq_add_or_remove = function(self, joker, val)
		SMODS.debuff_card(joker, val, "dbbq_husk")
	end
}

table.insert(DBBQ.calculates, function(context)
	if (context.card_added or context.joker_type_destroyed or context.selling_card) and context.card.ability.dbbq_husk then
		SMODS.Stickers.dbbq_husk:dbbq_add_or_remove(context.card, context.card_added or false)
	end
	if context.end_of_round and context.main_eval and context.game_over == false then
		for _, area in ipairs(SMODS.get_card_areas("jokers")) do
			for __, joker in ipairs(area.cards) do
				if joker.ability and joker.ability.set == "Joker" and joker.ability.dbbq_husk then
					joker.ability.dbbq_husk.unperish_tally = joker.ability.dbbq_husk.unperish_tally + 1
					if joker.ability.dbbq_husk.unperish_tally < 3 then
						SMODS.calculate_effect({message = tostring(joker.ability.dbbq_husk.unperish_tally), delay = 0.45}, joker)
					elseif joker.ability.dbbq_husk.unperish_tally == 3 then
						SMODS.calculate_effect({
							message = localize("k_dbbq_enabled"),
							delay = 0.45,
							func = function()
								SMODS.debuff_card(joker, false, "dbbq_husk")
							end
						}, joker)
					end
				end
			end
		end
	end
end)
