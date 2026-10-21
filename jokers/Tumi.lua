--[[
Tumi
Uncommon, $8

If poker hand is <hand>:
X4 Mult and +1 hand
X0 Mult otherwise
Poker hand changes
after every hand played
--]]

local key = "tumi"
DBBQ.quip_colours[key] = {HEX("b2a208"), HEX("971a0d"), HEX("0d9796")}
DBBQ.quip_pitch[key] = 1.9
DBBQ.quip_speed[key] = 0.2
DBBQ.add_quip(key, "boss", "win", 13)
DBBQ.add_quip(key, "nobody", "loss", 18)
DBBQ.add_quip(key, "waste", "loss", 8, 0.3)
DBBQ.add_quip(key, "menu", "win", 16)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 1, y = 4},
	blueprint_compat = true,
	pronouns = "she_her",
	dbbq_i_am_the_boss = "dbbq_boss_tumi",
	config = {extra = {poker_hand = "High Card", Xmult = 4, hand = 1, penalty = 0}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_tumi", set = "Other"}
		end
		return {vars = {card.ability.extra.poker_hand, card.ability.extra.Xmult, card.ability.extra.hand, card.ability.extra.penalty}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if context.scoring_name == card.ability.extra.poker_hand then
				return {
					xmult = card.ability.extra.Xmult,
					message = localize("ph_you_win"),
					func = function()
						ease_hands_played(card.ability.extra.hand)
					end
				}
			else
				return {
					xmult = card.ability.extra.penalty,
					message = localize("k_nope_ex")
				}
			end
		elseif context.after and context.main_eval and not context.blueprint then
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.extra.poker_hand then
					_poker_hands[#_poker_hands + 1] = k
				end
			end
			card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed((card.area and card.area.config.type == "title") and "false_to_do" or "to_do"))
			return {
				message = card.ability.extra.poker_hand
			}
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{border_nodes = {
					{text = "X"},
					{ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp"}
				}},
				{text = ", "},
				{text = "+", colour = G.C.CHIPS},
				{ref_table = "card.joker_display_values", ref_value = "hand", retrigger_type = "add", colour = G.C.CHIPS},
				{text = " Hand", colour = G.C.CHIPS}
			},
			reminder_text = {
				{text = "("},
				{ref_table = "card.joker_display_values", ref_value = "poker_hand", retrigger_type = "mult"},
				{text = ")"},
			},
			calc_function = function(card)
				if #G.play.cards > 0 then return end
				if JokerDisplay.evaluate_hand() == card.ability.extra.poker_hand then
					card.joker_display_values.xmult = card.ability.extra.Xmult
					card.joker_display_values.hand = card.ability.extra.hand
				else
					card.joker_display_values.xmult = card.ability.extra.penalty
					card.joker_display_values.hand = card.ability.extra.penalty
				end
				card.joker_display_values.poker_hand = card.ability.extra.poker_hand
			end
		}
	end
}
