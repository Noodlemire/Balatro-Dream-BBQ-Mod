--[[
Hoarder
Uncommon, $5

+0 Mult
After Boss Blind is defeated,
Add 60% of money to Mult and set money to $0
--]]

SMODS.Joker{
	key = "hoarder",
	loc_txt = {
		name = "Hoarder",
		text = {
			"{C:mult}+#1#{} Mult",
			"After {C:attention}Boss Blind{} is defeated,",
			"add {C:attention}60%{} of money to Mult",
			"and set money to {C:money}$0"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 5,
	pos = {x = 3, y = 1},
	blueprint_compat = true,
	config = {extra = {mult = 0}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_hoarder", set = "Other"}
		end
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		elseif context.blueprint then
			return
		end
		if context.setting_blind then
			card.ability.extra.ante = G.GAME.round_resets.ante
		elseif context.starting_shop and card.ability.extra.ante ~= G.GAME.round_resets.ante then
			card.ability.extra.mult = card.ability.extra.mult + math.ceil(G.GAME.dollars * 0.6)
			if to_big then
				card.ability.extra.mult = card.ability.extra.mult:to_number()
			end
			ease_dollars(-G.GAME.dollars)
			return {message = "Mine!"}
		end
	end
}
