--[[
Lazy Coworker
Uncommon, $5

+50 Mult
When Blind is defeated, decrease Mult depending on how much your final chip total overshot the Blind's requirement
--]]

SMODS.Joker{
	key = "lazy",
	loc_txt = {
		name = "Lazy Coworker",
		text = {
			"{C:mult}+#1#{} Mult",
			"When {C:attention}Blind{} is defeated,",
			"decrease Mult depending on",
			"how much your final chip total",
			"overshot the Blind's requirement"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 5,
	pos = {x = 1, y = 2},
	blueprint_compat = true,
	config = {extra = {mult = 50}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			local prev_mult = card.ability.extra.mult
			card.ability.extra.mult = math.ceil(card.ability.extra.mult / (G.GAME.chips / G.GAME.blind.chips))
			if prev_mult > card.ability.extra.mult then
				return {
					message = (card.ability.extra.mult - prev_mult).." Mult",
					color = G.C.MULT
				}
			end
		end
	end
}
