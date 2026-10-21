--[[
Hoarder
Uncommon, $5

+1000 Consumable Slots
+5 Chips per held Consumable
Prevents use of cards
in Consumable Slots
--]]

local key = "hoarder"
DBBQ.quip_colours[key] = {HEX("47705e"), HEX("fbfff7"), HEX("0d281a")}
DBBQ.quip_pitch[key] = 1.15
DBBQ.add_quip(key, "another", "loss", 7)
DBBQ.add_quip(key, "fought", "loss", 41, 0.1)
DBBQ.add_quip(key, "enjoy", "loss", 18)
DBBQ.add_quip(key, "ogling", "win", 13)
DBBQ.add_quip(key, "posterior", "loss", 14)
DBBQ.add_quip(key, "rad", "win", 11)

local ccuc = Card.can_use_consumeable
function Card:can_use_consumeable(any_state, skip_check)
	if self.area == G.consumeables and #SMODS.find_card("j_dbbq_hoarder") > 0 then
		return false
	end
	return ccuc(self, any_state, skip_check)
end

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 5,
	pos = {x = 3, y = 1},
	blueprint_compat = true,
	pronouns = "he_him",
	config = {extra = {slots = 1000, chips = 5}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_hoarder", set = "Other"}
		end
        return {vars = {card.ability.extra.slots, card.ability.extra.chips}}
    end,
	calculate = function(self, card, context)
		if context.other_consumeable then
			return {chips = card.ability.extra.chips}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.CHIPS},
			calc_function = function(card)
				card.joker_display_values.chips = card.ability.extra.chips * #G.consumeables.cards
			end
		}
	end
}
