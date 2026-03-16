--[[
Joker's Tombstone
Common, $4

This Joker gains Chips equal
to X10 a joker's sell value if
you sell that joker
(Joker changes each round)
(Currently +0 Chips)
--]]

local function choose_joker(card)
	local valid_jokers = {}
	for _, joker in ipairs(G.jokers.cards) do
		if joker ~= card and not SMODS.is_eternal(joker, card) and not joker.getting_sliced then
			table.insert(valid_jokers, joker)
		end
	end
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
	config = {extra = {joker = "a joker", mult = 10, chips = 0, dbbq_quotes = {
		{type = "lose", key = "j_dbbq_tomb_cash"},
		{type = "win", key = "j_dbbq_tomb_act"},
		{type = "lose", key = "j_dbbq_tomb_owe"},
		{type = "lose", key = "j_dbbq_tomb_looks"},
		{type = "win", key = "j_dbbq_tomb_now"},
		{type = "win", key = "j_dbbq_tomb_congratulations"},
		{type = "lose", key = "j_dbbq_tomb_island"},
	}}},
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
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.mult * context.card.sell_cost
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
