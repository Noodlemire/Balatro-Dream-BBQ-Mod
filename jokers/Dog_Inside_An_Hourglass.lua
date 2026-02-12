--[[
Dog Inside An Hourglass
Common, $2

Sell during a Blind
to gain +2 hands
--]]

SMODS.Joker{
	key = "diah",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 2,
	pos = {x = 7, y = 0},
	blueprint_compat = false,
	config = {extra = {hands = 2}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_diah", set = "Other"}
		end
		return {vars = {card.ability.extra.hands}}
	end,
	calculate = function(self, card, context)
		if context.selling_self and G.GAME.blind and G.GAME.blind.in_blind then
			return {
				func = function()
					ease_hands_played(card.ability.extra.hands)
				end
			}
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.ability.extra", ref_value = "hands"},
				{text = " Hands"}
			},
			text_config = {colour = G.C.CHIPS},
			reminder_text = {
				{text = "(If sold during Blind)"}
			}
		}
	end
}
