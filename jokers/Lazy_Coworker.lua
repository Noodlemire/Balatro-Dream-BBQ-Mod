--[[
Lazy Coworker
Uncommon, $5

+50 Mult
When Blind is defeated, decrease Mult depending on how much your final chip total overshot the Blind's requirement
--]]

SMODS.Joker{
	key = "lazy",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 5,
	pos = {x = 1, y = 2},
	blueprint_compat = true,
	config = {extra = {mult = 50, dbbq_quotes = {
		{type = "win", key = "j_dbbq_lazy_sweat"},
		{type = "lose", key = "j_dbbq_lazy_slack"},
		{type = "win", key = "j_dbbq_lazy_easier"},
		{type = "win", key = "j_dbbq_lazy_proactive"},
		{type = "lose", key = "j_dbbq_lazy_meat"},
		{type = "lose", key = "j_dbbq_lazy_novice"},
		{type = "win", key = "j_dbbq_lazy_working"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_lazy", set = "Other"}
		end
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			local prev_mult = card.ability.extra.mult
			card.ability.extra.mult = math.ceil(card.ability.extra.mult / (G.GAME.chips / G.GAME.blind.chips))
			if type(card.ability.extra.mult) == "table" then card.ability.extra.mult = card.ability.extra.mult:to_number() end
			if prev_mult > card.ability.extra.mult then
				return {
					message = (card.ability.extra.mult - prev_mult).." Mult",
					color = G.C.MULT
				}
			end
		end
	end
}
