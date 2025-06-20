--[[
Smoker
Rare, $9

1 in 4 cards are drawn face down
Each face down card held in hand grants X1.5 Mult
--]]

SMODS.Joker{
	key = "smoker",
	loc_txt = {
		name = "Smoker",
		text = {
			"{C:green}#1# in #2#{} cards are drawn face down",
			"Each face down card held",
			"in hand grants {X:mult,C:white}X#3#{} Mult"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 9,
	pos = {x = 4, y = 3},
	blueprint_compat = true,
	config = {extra = {odds = 4, Xmult = 1.5}},
    loc_vars = function(self, info_queue, card)
        return {vars = {(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context)
		if context.stay_flipped and not context.blueprint and pseudorandom("cough") < G.GAME.probabilities.normal / card.ability.extra.odds then
			return {stay_flipped = true}
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
	end
}
