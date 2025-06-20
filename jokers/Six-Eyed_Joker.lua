--[[
Six-Eyed Joker
Common, $5

Each 6 held in hand grants +36 chips.
--]]

SMODS.Joker{
	key = "sixeyed",
	loc_txt = {
		name = "Six-Eyed Joker",
		text = {
			"Each {C:attention}#1#{} held in hand",
			"gives {C:chips}+#2#{} Chips",
		}
	},
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 5,
	pos = {x = 3, y = 3},
	blueprint_compat = true,
	config = {extra = {target = "6", chips = 36}},
    loc_vars = function(self, info_queue, card)
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
	end
}
