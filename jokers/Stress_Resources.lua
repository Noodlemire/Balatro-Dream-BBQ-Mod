--[[
Stress Resources
Common, $4

If you play your last hand,
gain $3 per hand type that
played poker hand contains
--]]

SMODS.Joker{
	key = "stress",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 4, y = 5},
	blueprint_compat = true,
	pronouns = "he_him",
	config = {extra = {money = 3}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_stress", set = "Other"}
		end
		return {vars = {joker.ability.extra.money}}
	end,
	calculate = function(self, joker, context)
		if context.after and G.GAME.current_round.hands_left == 0 then
			local count = 0
			local _, _, hands = G.FUNCS.get_poker_hand_info(#G.play.cards > 0 and G.play.cards or G.hand.highlighted)
			for _, h in pairs(hands) do
				if next(h) then
					count = count + 1
				end
			end
			return {dollars = joker.ability.extra.money * count}
		end
	end,
	in_pool = function(self, args)
		return #SMODS.find_card("j_dbbq_unlucky") == 0
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "$"},
				{ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.MONEY},
			calc_function = function(joker)
				joker.joker_display_values.money = 0
				if G.GAME.current_round.hands_left == 1 or (#G.play.cards > 0 and G.GAME.current_round.hands_left == 0) then
					local count = 0
					local _, _, hands = G.FUNCS.get_poker_hand_info(#G.play.cards > 0 and G.play.cards or G.hand.highlighted)
					for _, h in pairs(hands) do
						if next(h) then
							count = count + 1
						end
					end
					joker.joker_display_values.money = joker.ability.extra.money * count
				end
			end,
		}
	end
}
