--[[
Matryoshka Joker
Common, $3

Sell create a random Joker that is one step below your Jokers' highest rarity
(Currently: <Rarity>)
--]]

SMODS.Joker{
	key = "matry",
	loc_txt = {
		name = "Matryoshka Joker",
		text = {
			"Sell this card to",
			"create a random {C:attention}Joker{}",
			"that is one step below",
			"your Jokers' highest rarity",
			"{C:inactive}(Currently: {B:1,C:white}#1#{C:inactive})"
		}
	},
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 3,
	pos = {x = 2, y = 2},
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
		local highest = 1
		for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
			if joker.config.center.rarity > highest then
				highest = joker.config.center.rarity
			end
		end
		if highest >= 4 then
        	return {vars = {colours = {HEX("fe5f55")}, "Rare"}}
		elseif highest == 3 then
        	return {vars = {colours = {HEX("4BC292")}, "Uncommon"}}
		elseif highest == 2 then
        	return {vars = {colours = {HEX("009dff")}, "Common"}}
		else
        	return {vars = {colours = {HEX("000000")}, "None"}}
		end
    end,
	calculate = function(self, card, context)
		if context.selling_self then
			local highest = 1
			for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
				if joker.config.center.rarity > highest then
					highest = joker.config.center.rarity
				end
			end
			if highest > 1 then
				if highest >= 4 then
					highest = "Rare"
				elseif highest == 3 then
					highest = "Uncommon"
				else
					highest = "Common"
				end
				G.GAME.joker_buffer = G.GAME.joker_buffer + 1
				G.E_MANAGER:add_event(Event({
		            func = function()
		                SMODS.add_card {
		                    set = "Joker",
		                    rarity = highest,
		                    key_append = "dbbq_matryoshka"
		                }
		                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
		                return true
		            end
		        }))
			end
		end
	end
}
