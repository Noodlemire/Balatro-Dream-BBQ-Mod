--[[
Pet? Joker
Common, $5

Sell to reduce the Boss Blind's chip requirement by 25%.
--]]

SMODS.Joker{
	key = "pet",
	loc_txt = {
		name = "Pet? Joker",
		text = {
			"Sell this card to",
			"reduce the current Blind's",
			"chip requirement by {C:attention}25%{}"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 0, y = 3},
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_pet", set = "Other"}
		end
    end,
	calculate = function(self, card, context)
		if context.selling_self and G.GAME.blind and G.GAME.blind.in_blind then
			G.GAME.blind.chips = math.max(math.floor(G.GAME.blind.chips * 0.75), 1)
    		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.GAME.blind:set_text()
			G.GAME.blind:wiggle()
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					if G.GAME.chips - G.GAME.blind.chips >= 0 then
						G.STATE = G.STATES.NEW_ROUND
						G.STATE_COMPLETE = false
					end
					return true
				end
			}))
		end
	end,
    in_pool = function(self, args)
		for _, joker in ipairs(G.jokers.cards) do
			if joker.config.center.key == "j_dbbq_horse" and joker.ability.extra.chips >= 400 then
				return false
			end
		end
        return true
    end
}
