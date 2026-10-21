--[[
Joker's Tombstone
Common, $4

This Joker gains Chips equal
to X10 a joker's sell value if
you sell that joker
(Joker changes each round)
(Currently +0 Chips)
--]]

local key = "tomb"
DBBQ.quip_function[key] = function(self, times)
	if self.key == "dbbq_"..key.."_cash" and times >= 2 and times <= 4 then return end
	play_sound("voice"..math.random(1, 11), DBBQ.quip_pitch[key])
end
DBBQ.quip_colours[key] = {HEX("3f48c7"), HEX("7b9fe2"), HEX("af59c4")}
DBBQ.quip_pitch[key] = 1
DBBQ.quip_speed[key] = 0.2
DBBQ.add_quip(key, "cash", "loss", 12)
DBBQ.add_quip(key, "act", "win", 9)
DBBQ.add_quip(key, "owe", "loss", 12)
DBBQ.add_quip(key, "looks", "loss", 6)
DBBQ.add_quip(key, "now", "win", 11)
DBBQ.add_quip(key, "congratulations", "win", 5)
DBBQ.add_quip(key, "island", "loss", 16)

local function choose_joker(card)
	local valid_jokers = {}
	DBBQ.iterate_jokers(function(joker)
		if joker ~= card and not SMODS.is_eternal(joker, card) and not joker.getting_sliced then
			table.insert(valid_jokers, joker)
		end
	end)
	local joker = pseudorandom_element(valid_jokers, "One fatty catty!")
	if joker then
		card.ability.extra.joker = joker.config.center.key
	end
end

SMODS.Joker{
	key = "tomb",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 7, y = 3},
	blueprint_compat = true,
	pronouns = "they_them",
	config = {extra = {joker = "a joker", mult = 10, chips = 0}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_tomb", set = "Other"}
		end
		local joker_text = card.ability.extra.joker
		if joker_text ~= "a joker" then
			joker_text = localize{type = "name_text", key = joker_text, set = "Joker"}
		end
		return {vars = {joker_text, card.ability.extra.mult, card.ability.extra.chips}}
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			choose_joker(card)
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		elseif not context.blueprint then
			if context.end_of_round and context.game_over == false and context.main_eval then
				choose_joker(card)
			elseif context.selling_card and context.card.config.center.key == card.ability.extra.joker then
				--card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.mult * context.card.sell_cost
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_table = context.card,
					scalar_value = "sell_cost",
					no_message = true,
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + ref_table.mult * change
					end
				})
				return {
					message = "+"..card.ability.extra.chips,
					colour = G.C.CHIPS
				}
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.CHIPS},
			reminder_text = {
				{text = "("},
				{ref_table = "card.joker_display_values", ref_value = "joker", colour = G.C.ORANGE},
				{text = ")"}
			},
			calc_function = function(card)
				if card.ability.extra.joker == "a joker" then
					card.joker_display_values.joker = "N/A"
				else
					card.joker_display_values.joker = localize{type = "name_text", key = card.ability.extra.joker, set = "Joker"}
				end
			end
		}
	end
}
