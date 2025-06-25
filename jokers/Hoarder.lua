--[[
Hoarder
Uncommon, $5

+5 Mult
After Boss Blind is defeated,
Add money to Mult and
set money to $0
--]]

SMODS.Joker{
	key = "hoarder",
	loc_txt = {
		name = "Hoarder",
		text = {
			"{C:mult}+#1#{} Mult",
			"After {C:attention}Boss Blind{} is defeated,",
			"add money to Mult and",
			"set money to {C:money}$0"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 5,
	pos = {x = 3, y = 1},
	blueprint_compat = true,
	config = {extra = {mult = 5}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_hoarder", set = "Other"}
		end
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.blind.boss and G.GAME.dollars ~= 0 then
			card.ability.extra.mult = card.ability.extra.mult + G.GAME.dollars
			ease_dollars(-G.GAME.dollars)
			return {message = "Mine!"}
		end
	end
}
