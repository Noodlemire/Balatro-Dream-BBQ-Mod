--[[
Kintsugi
Uncommon, $6

Gains $1 of sell value at end of round
If a Glass Card shatters or a Lucky Card fails,
pay out the sell value and transform into Unlucky Cat.
--]]

SMODS.Joker{
	key = "kintsugi",
	loc_txt = {
		name = "Kintsugi",
		text = {
			"Gains {C:money}$#1#{} of {C:attention}sell value{}",
			"at end of round",
			"If {C:inactive}Glass Card{} shatters",
			"or a {C:attention}Lucky Card{} fails,",
			"pay out the {C:attention}sell value{} and",
			"transform into {C:chips}Unlucky Cat{}"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 6,
	pos = {x = 0, y = 2},
	blueprint_compat = false,
    config = {extra = {price = 1}},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_dbbq_unlucky
        return {vars = {card.ability.extra.price}}
    end,
	calculate = function(self, card, context)
		if not context.blueprint then
			local meteor = false
			if context.end_of_round and context.game_over == false and context.main_eval then
				card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
				card:set_cost()
				return {
					message = localize('k_val_up'),
					colour = G.C.MONEY
				}
			elseif context.remove_playing_cards then
				for _, removed_card in ipairs(context.removed) do
					if removed_card.shattered then
						meteor = true
						break
					end
				end
			elseif context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_lucky') and not context.other_card.lucky_trigger then
				meteor = true
			end
			if meteor then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						card:flip()
						play_sound('card1', percent)
						card:juice_up(0.3, 0.3)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						card:set_ability("j_dbbq_unlucky")
						--Setting Xmult here prevents bizarre crash when viewing full deck post-transformation
						card.ability.extra.Xmult = 2
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						card:flip()
						play_sound('tarot2', percent, 0.6)
						card:juice_up(0.3, 0.3)
						return true
					end
				}))
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.sell_cost
				return {
					dollars = card.sell_cost,
					func = function() -- This is for timing purposes, it runs after the dollar manipulation
						G.E_MANAGER:add_event(Event({
							func = function()
								G.GAME.dollar_buffer = 0
								return true
							end
						}))
					end
				}
			end
		end
	end,
    in_pool = function(self, args)
		return #SMODS.find_card("j_dbbq_unlucky") == 0
    end
}
