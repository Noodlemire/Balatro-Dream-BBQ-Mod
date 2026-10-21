--[[
Honesty And Unforgiveness
Uncommon, $6

Gains +1 discard each round if you
play a Straight Flush of Spades with
five cards no rank gaps, and no wrapping
(Currently +0 discards each round)
--]]

local key = "honest"
DBBQ.quip_colours[key] = {HEX("233c35"), HEX("bb532f"), HEX("c7ae44")}
DBBQ.quip_pitch[key] = 1.1
DBBQ.quip_speed[key] = 0.16
DBBQ.add_quip(key, "seen", "any", 4, 0.2)
DBBQ.add_quip(key, "lies", "loss", 6, 0.2)
DBBQ.add_quip(key, "wends", "loss", 13)
DBBQ.add_quip(key, "end", "win", 23)
DBBQ.add_quip(key, "good", "win", 21)
DBBQ.add_quip(key, "truth", "win", 25)
DBBQ.add_quip(key, "learn", "loss", 19)

local function get_honest_spade_flush(hand)
	local ret = {}
	if #hand < 5 then
		return ret
	else
		local t = {}
		local flush_count = 0
		for i = 1, #hand do
			if hand[i]:is_suit("Spades", nil, true) then flush_count = flush_count + 1; t[#t+1] = hand[i] end 
		end
		if flush_count >= 5 then
			table.insert(ret, t)
			return ret
		end
		return {}
	end
end

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 5, y = 5},
	blueprint_compat = false,
	pronouns = "he_him",
	config = {extra = {discards = 0, discard_gain = 1}},
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_honest", set = "Other"}
		end
		return {vars = {joker.ability.extra.discard_gain, joker.ability.extra.discards}}
	end,
	add_to_deck = function(self, joker, from_debuff)
		if joker.ability.extra.discards ~= 0 then
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + joker.ability.extra.discards
			ease_discard(joker.ability.extra.discards)
		end
	end,
	remove_from_deck = function(self, joker, from_debuff)
		if joker.ability.extra.discards ~= 0 then
			G.GAME.round_resets.discards = G.GAME.round_resets.discards - joker.ability.extra.discards
			ease_discard(-joker.ability.extra.discards)
		end
	end,
	calculate = function(self, joker, context)
		if context.after and not context.blueprint and next(get_straight(context.scoring_hand, 5)) and next(get_honest_spade_flush(context.scoring_hand)) then
			SMODS.scale_card(joker, {
				ref_table = joker.ability.extra,
				ref_value = "discards",
				scalar_value = "discard_gain",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + change
					G.GAME.round_resets.discards = G.GAME.round_resets.discards + change
					ease_discard(change)
				end,
			})
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.ability.extra", ref_value = "discards", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.MULT}
		}
	end
}
