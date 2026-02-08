--[[
Blobby Joker
Common, $4

+15 Mult if you don't play one of your most played hands.
--]]

SMODS.Joker{
	key = "blobby",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 1, y = 0},
	blueprint_compat = true,
	config = {extra = {mult = 15, dbbq_quotes = {
		{type = "win", key = "j_dbbq_blobby_friends"},
		{type = "win", key = "j_dbbq_blobby_crazy"},
		{type = "lose", key = "j_dbbq_blobby_sick"},
		{type = "lose", key = "j_dbbq_blobby_run"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_blobby", set = "Other"}
		end
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			local mult = false
			local max_limit = G.GAME.hands[context.scoring_name].played - 1
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played > max_limit and v.visible then
					mult = true
					break
				end
			end
			if mult then
				return {mult = card.ability.extra.mult}
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.MULT},
			calc_function = function(card)
				card.joker_display_values.mult = 0
				if #G.hand.highlighted > 0 or #G.play.cards > 0 then
					local hand = G.FUNCS.get_poker_hand_info(#G.play.cards > 0 and G.play.cards or G.hand.highlighted)
					local max_limit = G.GAME.hands[hand].played
					for k, v in pairs(G.GAME.hands) do
						if k ~= hand and v.played > max_limit and v.visible then
							card.joker_display_values.mult = card.ability.extra.mult
							return
						end
					end
				end
			end
		}
	end
}
