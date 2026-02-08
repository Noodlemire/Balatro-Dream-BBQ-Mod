--[[
BATHROOM
Rare, $8

When sold, destroys all Jokers
For every third Joker destroyed,
you gain +1 Joker Slot
(Includes itself)
--]]

SMODS.Joker{
	key = "bathroom",
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 0, y = 0},
	blueprint_compat = false,
	eternal_compat = false,
	config = {extra = {slot = 1}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_bathroom", set = "Other"}
		end
        return {vars = {card.ability.extra.slot}}
    end,
	calculate = function(self, card, context)
		if context.selling_self then
			local killcount = 0
			for _, joker in ipairs(G.jokers.cards) do
				if not joker.ability.eternal and not joker.getting_sliced then
					killcount = killcount + 1
					joker.getting_sliced = true
					joker:start_dissolve()
				end
			end
			G.jokers.config.card_limit = G.jokers.config.card_limit + math.floor(killcount * card.ability.extra.slot / 3)
		end
	end,
    in_pool = function(self, args)
		return G.GAME.round_resets.ante >= 3
    end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "jokers"}
			},
			text_config = {colour = G.C.GREEN},
			calc_function = function(card)
				card.joker_display_values.jokers = math.floor((G.jokers and G.jokers.cards and #G.jokers.cards or 0) * card.ability.extra.slot / 3)
			end
		}
	end
}
