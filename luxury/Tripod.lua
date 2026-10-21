--[[
Tripod
Luxury, $8

Combine 3 selected cards of
the same suit together,
The resulting card will have a
random rank, enhancement, seal,
and edition from the selected cards
--]]

DBBQ.Luxury{
	key = "tripod",
	soul_pos = {x = 0, y = 4},
	config = {extra = {cards = 3, used = false}},
	dbbq_sort_selected = true,
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		return #G.hand.highlighted == math.floor(item.ability.extra.cards)
	end,
	luxury_use = function(self, item, area)
		if #G.hand.highlighted == 0 then return end
		G.E_MANAGER:add_event(Event({
			func = function()
				local ranks, real_ranks, enh, seal, edi = {}, {}, {}, {}, {}
				for _, card in ipairs(G.hand.highlighted) do
					if not SMODS.has_no_rank(card) then table.insert(ranks, card:get_id()) end
					table.insert(real_ranks, card.base.value)
					if next(SMODS.get_enhancements(card)) then table.insert(enh, card.config.center.key) end
					if card.seal then table.insert(seal, card.seal) end
					if card.edition then table.insert(edi, card.edition.key) end
					card:start_dissolve()
				end
				SMODS.add_card({
					set = #enh > 0 and "Enhanced" or "Base",
					rank = pseudorandom_element(#ranks > 0 and ranks or real_ranks, "c_dbbq_tripod"),
					enhancement = #enh > 0 and pseudorandom_element(enh, "c_dbbq_tripod"),
					seal = #seal > 0 and pseudorandom_element(seal, "c_dbbq_tripod"),
					edition = #edi > 0 and pseudorandom_element(edi, "c_dbbq_tripod"),
					area = G.hand
				})
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}
