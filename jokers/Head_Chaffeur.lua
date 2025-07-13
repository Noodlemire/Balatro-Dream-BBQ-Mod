--[[
Head Chaffeur
Uncommon, $6

When Hand is played: Gain one of +5 Chips, +1 Mult, or X0.05 Mult at random
(Currently +0 Chips, +0 Mult, X1 Mult)
--]]

SMODS.Joker{
	key = "head",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 1, y = 1},
	blueprint_compat = true,
    config = {extra = {chips_gain = 5, mult_gain = 1, Xmult_gain = 0.05, chips = 0, mult = 0, Xmult = 1, dbbq_quotes = {
		{type = "win", key = "j_dbbq_head_work"},
		{type = "any", key = "j_dbbq_head_party"},
		{type = "win", key = "j_dbbq_head_doom"},
		{type = "lose", key = "j_dbbq_head_awaiting"},
		{type = "win", key = "j_dbbq_head_ride"},
		{type = "lose", key = "j_dbbq_head_awful"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_head", set = "Other"}
		end
        return {vars = {
			card.ability.extra.chips_gain,
			card.ability.extra.mult_gain,
			card.ability.extra.Xmult_gain,
			card.ability.extra.chips,
			card.ability.extra.mult,
			card.ability.extra.Xmult
		}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.Xmult
			}
		elseif context.before and context.main_eval and not context.blueprint then
			local gain = pseudorandom_element({"chips", "mult", "Xmult"}, pseudoseed("taxi"))
			card.ability.extra[gain] = card.ability.extra[gain] + card.ability.extra[gain.."_gain"]
			return {message = gain}
		end
	end
}
