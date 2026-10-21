--[[
Joker Legs
Common, $4

+100 Chips if you
have drawn through
half of your deck
--]]

local key = "legs"
DBBQ.quip_colours[key] = {HEX("d6be76"), HEX("d8dfe8"), HEX("5c4956")}
DBBQ.quip_sound[key] = DBBQ.sound_range(key, 10)
DBBQ.quip_speed[key] = 0.25
DBBQ.quip_pitch[key] = 1
DBBQ.add_quip(key, "eyeball", "loss", 4)
DBBQ.add_quip(key, "how", "loss", 4)
DBBQ.add_quip(key, "damnation", "loss", 4)
DBBQ.add_quip(key, "boobstraps", "loss", 4)
DBBQ.add_quip(key, "epic", "win", 4)
DBBQ.add_quip(key, "imploded", "win", 4)
DBBQ.add_quip(key, "boss", "win", 4)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 4, y = 1},
	blueprint_compat = true,
	pronouns = "he_they",
	dbbq_i_am_the_boss = "dbbq_boss_generic",
	config = {extra = {chips = 100}},
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
