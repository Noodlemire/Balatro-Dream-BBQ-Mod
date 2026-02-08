--[[
Six-Eyed Joker
Common, $5

Each 6 held in hand grants +36 chips.
--]]

SMODS.Joker{
	key = "sixeyed",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 5,
	pos = {x = 3, y = 3},
	blueprint_compat = true,
	config = {extra = {target = "6", chips = 36, dbbq_quotes = {
		{type = "win", key = "j_dbbq_sixeyed_thank"},
		{type = "lose", key = "j_dbbq_sixeyed_back"},
		{type = "win", key = "j_dbbq_sixeyed_before"},
		{type = "any", key = "j_dbbq_sixeyed_death"},
	}}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_sixeyed", set = "Other"}
		end
		return {vars = {card.ability.extra.target, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.individual and not context.end_of_round and context.cardarea == G.hand and context.other_card:get_id() == 6 then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
				}
			else
				return {
					chips = card.ability.extra.chips,
				}
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.CHIPS},
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local chips = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if playing_card.facing and not (playing_card.facing == "back") and not playing_card.debuff and playing_card:get_id() == 6 then
							chips = chips + card.ability.extra.chips * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.chips = chips
			end
		}
	end
}
