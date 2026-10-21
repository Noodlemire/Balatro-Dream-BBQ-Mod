--[[
Braid
Luxury, $8

Destroy selected joker with an
edition, apply that edition to up
to 3 random cards held in hand
--]]

DBBQ.Luxury{
	key = "braid",
	soul_pos = {x = 1, y = 2},
	config = {extra = {cards = 3, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		if not G.hand or #G.hand.cards == 0 then return false end
		local selected_one = false
		for _, area in ipairs(SMODS.get_card_areas("jokers")) do
			for __, other in ipairs(area.highlighted) do
				if other.ability and other.ability.set == "Joker" and other.edition then
					if selected_one then return false end
					selected_one = true
				end
			end
		end
		return false
	end,
	luxury_use = function(self, item, area)
		G.E_MANAGER:add_event(Event({
			func = function()
				local edition = nil
				for _, area in ipairs(SMODS.get_card_areas("jokers")) do
					for __, other in ipairs(area.highlighted) do
						if other.ability and other.ability.set == "Joker" and other.edition then
							edition = other.edition.key
							other:start_dissolve()
							break
						end
					end
					if edition then break end
				end
				if not edition then return end
				local cards = {}
				for _, card in ipairs(G.hand.cards) do
					table.insert(cards, card)
				end
				table.sort(cards, function(a, b)
					return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
				end)
				pseudoshuffle(cards, pseudoseed("c_dbbq_braid"))
				for i = 1, item.ability.extra.cards do
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							item:juice_up(0.3, 0.5)
							return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.1,
						func = function()
							cards[i]:set_edition(edition)
							return true
						end
					}))
				end
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		if context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand) then
			for _, area in ipairs(SMODS.get_card_areas("jokers")) do
				for __, other in ipairs(area.cards) do
					if other.ability and other.ability.set == "Joker" and other.edition then
						return true
					end
				end
			end
		end
		return false
	end,
}
