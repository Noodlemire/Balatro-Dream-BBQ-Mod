--[[
Smoker
Rare, $9

1 in 4 cards are drawn face down
Each face down card held in hand grants X1.5 Mult
--]]

SMODS.Joker{
	key = "smoker",
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 9,
	pos = {x = 4, y = 3},
	blueprint_compat = true,
	config = {extra = {num = 1, den = 4, Xmult = 1.5}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_smoker", set = "Other"}
		end
		local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den)
        return {vars = {num, den, card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context)
		if context.stay_flipped and context.to_area == G.hand then
			if SMODS.pseudorandom_probability(card, "Remember, ENA...", card.ability.extra.num, card.ability.extra.den) then
				return {stay_flipped = true}
			end
		elseif context.individual and not context.end_of_round and context.cardarea == G.hand and context.other_card.facing == "back" then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
				}
			else
				return {
					Xmult = card.ability.extra.Xmult,
				}
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {{border_nodes = {
				{text = "X"},
				{ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp"}
			}}},
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local count = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if playing_card.facing and playing_card.facing == "back" and not playing_card.debuff then
							count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.xmult = card.ability.extra.Xmult ^ count
			end
		}
	end
}
