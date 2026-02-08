--[[
Matryoshka Joker
Common, $3

Sell create a random Joker that is one step below your Jokers' highest rarity
(Currently: <Rarity>)
--]]

local function get_keys(t)
    local keys = {}
    for k, _ in pairs(t) do
        keys[#keys + 1] = k
    end
    return keys
end

SMODS.Joker{
	key = "matry",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 3,
	pos = {x = 2, y = 2},
	blueprint_compat = false,
	config = {extra = {dbbq_quotes = {
		{type = "lose", key = "j_dbbq_matry_cents"},
		{type = "win", key = "j_dbbq_matry_toot"},
		{type = "lose", key = "j_dbbq_matry_ruin"},
	}}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_matry", set = "Other"}
		end
		local highest = 1
		for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
			if type(joker.config.center.rarity) == "number" and joker.config.center.rarity > highest then
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
				if type(joker.config.center.rarity) == "number" and joker.config.center.rarity > highest then
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
	end,
	joker_display_def = function(jd)
		return {
			text = {{border_nodes = {
				{ref_table = "card.joker_display_values", ref_value = "rarity"}
			}}},
			calc_function = function(card)
				local highest = 1
				for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
					if type(joker.config.center.rarity) == "number" and joker.config.center.rarity > highest then
						highest = joker.config.center.rarity
					end
				end
				if highest >= 4 then
					highest = "Rare"
				elseif highest == 3 then
					highest = "Uncommon"
				elseif highest == 2 then
					highest = "Common"
				else
					highest = "None"
				end
				card.joker_display_values.rarity = highest
			end,
			style_function = function(card, text, reminder_text, extra)
				if text and text.children[1] and text.children[1].children[1] then
					local rarity = card.joker_display_values.rarity
					local color = HEX("000000")
					if rarity == "Rare" then
						color = G.C.RARITY[3]
					elseif rarity == "Uncommon" then
						color = G.C.RARITY[2]
					elseif rarity == "Common" then
						color = G.C.RARITY[1]
					end
					text.children[1].config.colour = color
				end
			end
		}
	end
}
