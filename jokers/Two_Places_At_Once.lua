--[[
Two Places At Once
Rare, $10

When Blind is selected: Unpin and copy self without modifiers, then pin the copy to the left
(Must have room)
When Blind is defeated: If there's a copy to the right, destroy it and gain X0.2 Mult
(Currently X1 Mult)
--]]

SMODS.Joker{
	key = "tpao",
	loc_txt = {
		name = "Two Places At Once",
		text = {
			"When {C:attention}Blind{} is selected:",
			"Unpin and copy self without modifiers,",
			"then pin the copy to the left",
			"{C:inactive}(Must have room){}",
			"When {C:attention}Blind{} is defeated:",
			"If there's a copy to the right,",
			"destroy it and gain {X:mult,C:white}X#1#{} Mult",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
		}
	},
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 10,
	pos = {x = 2, y = 4},
	blueprint_compat = true,
    config = {extra = {Xmult_gain = 0.2, Xmult = 1}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_tpao", set = "Other"}
		end
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		elseif not context.blueprint then
			if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						local copy = SMODS.add_card({key = "j_dbbq_tpao"})
						copy.pinned = true
						copy.ability.extra.Xmult = card.ability.extra.Xmult
						card.pinned = false
						G.GAME.joker_buffer = G.GAME.joker_buffer - 1
						return true
					end
				}))
				return {
					message = localize('k_plus_joker'),
					colour = G.C.BLUE,
				}
			elseif context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				local found_self = false
				for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
					if joker == card then
						found_self = true
					elseif found_self and joker.config.center.key == "j_dbbq_tpao" then
						joker.getting_sliced = true
						joker:start_dissolve()
						card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
						return {
							message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}
						}
					end
				end
			end
		end
	end
}
