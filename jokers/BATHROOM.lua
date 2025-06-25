--[[
BATHROOM
Rare, $8

When Blind is selected: Destroys all Jokers
For every third Joker destroyed, you gain +1 Joker Slot
(Includes itself)
--]]

SMODS.Joker{
	key = "bathroom",
	loc_txt = {
		name = "BATHROOM",
		text = {
			"When {C:attention}Blind{} is selected:",
			"{C:mult}Destroy all Jokers{}",
			"For every third {C:attention}Joker{} destroyed,",
			"you gain {C:green}+#1# Joker Slot{}",
			"{C:inactive}(Includes itself)"
		}
	},
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
		if context.blueprint then return end
		local killcount = 0
		if context.setting_blind then
			for _, joker in ipairs(G.jokers.cards) do
				if not joker.ability.eternal and not joker.getting_sliced then
					killcount = killcount + 1
					joker.getting_sliced = true
					joker:start_dissolve()
				end
			end
		end
		G.jokers.config.card_limit = G.jokers.config.card_limit + math.floor(killcount / 3)
	end,
    in_pool = function(self, args)
		return G.GAME.round_resets.ante >= 3
    end
}
