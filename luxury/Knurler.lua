--[[
Knurler
Luxury, $8

Select any type of card with an edition,
it loses that edition and gains $3, either
as sell value or as a permanent bonus
(Must have room if you're removing Negative)
--]]

local function get_highlighted_edition_card(item)
	local selected = nil
	for _, area in ipairs({G.jokers, G.consumeables, G.hand}) do
		for _, card in ipairs(area.highlighted) do
			if card ~= item then
				if selected or not card.edition then return end
				selected = card
			end
		end
	end
	if selected and selected.edition.key == "e_negative" and #selected.area.cards >= selected.area.config.card_limit then return end
	return selected
end

DBBQ.Luxury{
	key = "knurler",
	soul_pos = {x = 3, y = 2},
	config = {extra = {money = 3, used = false}},
	loc_vars = function(self, info_queue, item)
		if not item.edition or item.edition.key ~= "e_negative_consumable" then
			info_queue[#info_queue+1] = {key = "e_negative", set = "Edition", config = {extra = 1}}
		end
		return {vars = {item.ability.extra.money}}
	end,
	luxury_can_use = function(self, item)
		return get_highlighted_edition_card(item)
	end,
	luxury_use = function(self, item, area)
		local selected = get_highlighted_edition_card(item)
		if not selected then return end
		SMODS.scale_card(selected, {
			ref_table = selected.ability,
			ref_value = selected.playing_card and "perma_p_dollars" or "extra_value",
			scalar_table = item.ability.extra,
			scalar_value = "money",
			scaling_message = {
				message = localize("k_val_up"),
				colour = G.C.MONEY
			},
			operation = not selected.playing_card and function(ref_table, ref_value, initial, change)
				ref_table[ref_value] = initial + change + (SMODS.Centers[selected.edition.key].extra_cost or 0) / 2
				selected:set_cost()
			end
		})
		G.E_MANAGER:add_event(Event({
			func = function()
				selected:set_edition()
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.ante_end
	end,
	luxury_start_juice = function(self, item)
		juice_card_until(item, function(item)
			return not item.ability.extra.used
		end, true)
	end
}
