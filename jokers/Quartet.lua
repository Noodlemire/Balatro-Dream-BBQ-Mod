--[[
Quartet
Uncommon, $4

When Hand is played: Gain +4 Mult if you have exactly 4 Jokers
(Currently +0 Mult)
--]]

SMODS.Joker{
	key = "quartet",
	loc_txt = {
		name = "Quartet",
		text = {
			"When {C:attention}Hand{} is played:",
			"Gain {C:mult}+#1#{} Mult if you",
			"have exactly {C:chips}4{} Jokers",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 4,
	pos = {x = 1, y = 3},
	blueprint_compat = true,
    config = {extra = {mult_gain = 4, mult = 0}},
    loc_vars = function(self, info_queue, card)
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
