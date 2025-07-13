--[[
Hoarder
Uncommon, $5

+1000 Consumable Slots
+5 Chips per held Consumable
Prevents use of cards in Consumable Slots
--]]

local ccuc = Card.can_use_consumeable
function Card:can_use_consumeable(any_state, skip_check)
	if self.area == G.consumeables and #SMODS.find_card("j_dbbq_hoarder") > 0 then
		return false
	end
	return ccuc(self, any_state, skip_check)
end

SMODS.Joker{
	key = "hoarder",
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 5,
	pos = {x = 3, y = 1},
	blueprint_compat = true,
	config = {extra = {slots = 1000, chips = 5, dbbq_quotes = {
		{type = "lose", key = "j_dbbq_hoarder_another"},
		{type = "lose", key = "j_dbbq_hoarder_fought"},
		{type = "lose", key = "j_dbbq_hoarder_enjoy"},
		{type = "win", key = "j_dbbq_hoarder_ogling"},
		{type = "lose", key = "j_dbbq_hoarder_posterior"},
		{type = "win", key = "j_dbbq_hoarder_rad"},
	}}},
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
}
