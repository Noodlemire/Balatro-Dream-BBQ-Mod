--[[
Joker Legs
Common, $4

+100 Chips if you
have drawn through
half of your deck
--]]

SMODS.Joker{
	key = "legs",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 4, y = 1},
	blueprint_compat = true,
	config = {extra = {chips = 100, dbbq_quotes = {
		{type = "lose", key = "j_dbbq_legs_eyeball"},
		{type = "lose", key = "j_dbbq_legs_how"},
		{type = "lose", key = "j_dbbq_legs_damnation"},
		{type = "lose", key = "j_dbbq_legs_boobstraps"},
		{type = "win", key = "j_dbbq_legs_epic"},
		{type = "win", key = "j_dbbq_legs_imploded"},
	}}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_legs", set = "Other"}
		end
        return {vars = {card.ability.extra.chips}}
    end,
	calculate = function(self, card, context)
		if context.joker_main and #G.deck.cards <= G.GAME.starting_deck_size / 2 then
			return {
				chips = card.ability.extra.chips
			}
		end
    end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.CHIPS},
			calc_function = function(card)
				card.joker_display_values.chips = #G.deck.cards <= G.GAME.starting_deck_size / 2 and card.ability.extra.chips or 0
			end
		}
	end
}
