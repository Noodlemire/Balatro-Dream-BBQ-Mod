--[[
Henohenohomeji
Uncommon, $7

When Blind is selected: Create a random Enhanced face card and draw it to hand
--]]

SMODS.Joker{
	key = "heno",
	loc_txt = {
		name = "Henohenomoheji",
		text = {
			"When {C:attention}Blind{} is selected:",
			"Create random {C:attention}Enhanced{} face",
			"card and draw it to hand"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 7,
	pos = {x = 2, y = 1},
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			local rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed("I AM DRATULAAAAA!!!!!"))
			local suit = pseudorandom_element({'S','H','D','C'}, pseudoseed("I AM A VAMPIRE, SO STRONK!"))
			local cen_pool = {}
			for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
				if v.key ~= 'm_stone' then 
					cen_pool[#cen_pool+1] = v
				end
			end
			local new_card = create_playing_card({front = G.P_CARDS[suit..'_'..rank], center = pseudorandom_element(cen_pool, pseudoseed("GOOD MORNINK!"))}, G.hand, nil, false, {G.C.SECONDARY_SET.Enhanced}, true)
			return {
				func = function()
				-- This is for retrigger purposes, Jokers need to return something to retrigger
				-- You can also do this outside the return and `return nil, true` instead
				G.E_MANAGER:add_event(Event({
					func = function()
						G.hand:emplace(new_card)
						new_card:start_materialize()
						G.GAME.blind:debuff_card(new_card)
						G.hand:sort()
						if context.blueprint_card then
							context.blueprint_card:juice_up()
						else
							card:juice_up()
						end
						return true
					end
				}))
				SMODS.calculate_context({playing_card_added = true, cards = {new_card}})
				end
			}
		end
	end
}
