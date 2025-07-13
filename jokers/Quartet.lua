--[[
Quartet
Uncommon, $4

When Hand is played: Gain +4 Mult if you have exactly 4 Jokers
(Currently +0 Mult)
--]]

SMODS.Joker{
	key = "quartet",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 4,
	pos = {x = 1, y = 3},
	blueprint_compat = true,
    config = {extra = {mult_gain = 4, mult = 0, dbbq_quotes = {
		{type = "win", key = "j_dbbq_quartet_delightful"},
		{type = "any", key = "j_dbbq_quartet_reference"},
		{type = "lose", key = "j_dbbq_quartet_fault"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_quartet", set = "Other"}
		end
        return {vars = {
			card.ability.extra.mult_gain,
			card.ability.extra.mult
		}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		elseif context.before and context.main_eval and not context.blueprint and #G.jokers.cards == 4 then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
                message = localize({type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}),
                colour = G.C.RED
            }
		end
	end
}
