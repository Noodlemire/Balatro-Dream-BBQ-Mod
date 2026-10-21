--[[
Periwinkle
Luxury, $8

Convert 3 selected cards
to the top 3 ranks and
suits from your full deck
--]]

local function top_bases()
	local ranks, suits, ranks_sorted, suits_sorted = {}, {}, {}, {}
	for _, card in ipairs(G.playing_cards or {}) do
		if not SMODS.has_no_rank(card) then
			ranks[card.base.value] = (ranks[card.base.value] or 0) + 1
		end
		if not SMODS.has_no_suit(card) then
			suits[card.base.suit] = (suits[card.base.suit] or 0) + 1
		end
	end
	for k in pairs(ranks) do
		table.insert(ranks_sorted, k)
	end
	table.sort(ranks_sorted, function (a, b) return ranks[a] > ranks[b] end)
	for k in pairs(suits) do
		table.insert(suits_sorted, k)
	end
	table.sort(suits_sorted, function (a, b) return suits[a] > suits[b] end)
	return ranks_sorted, suits_sorted
end

DBBQ.Luxury{
	key = "periwinkle",
	soul_pos = {x = 4, y = 4},
	config = {extra = {cards = 3, used = false}},
	dbbq_sort_selected = true,
	loc_vars = function(self, info_queue, item)
		local ret = {vars = {item.ability.extra.cards}}
		local ranks, suits = top_bases()
		if #ranks >= item.ability.extra.cards and #suits >= item.ability.extra.cards then
			ret.key = self.key.."_current"
			local str = ""
			for i = 1, item.ability.extra.cards do
				if ranks[i] ~= tostring(tonumber(rank)) then
					ranks[i] = ranks[i]:sub(1, 1)
				end
				str = str..ranks[i]..localize(suits[i], "suits_singular"):sub(1, 1)
				if i < item.ability.extra.cards then
					str = str..", "
				end
				ret.vars[2] = str
			end
		end
		return ret
	end,
	luxury_can_use = function(self, item)
		local ranks, suits = top_bases()
		return #ranks >= item.ability.extra.cards and #suits >= item.ability.extra.cards and #G.hand.highlighted == math.floor(item.ability.extra.cards)
	end,
	luxury_use = function(self, item, area)
		local ranks, suits = top_bases()
		if #ranks < item.ability.extra.cards or #suits < item.ability.extra.cards or #G.hand.highlighted == 0 then return end
		for i, card in ipairs(G.hand.highlighted) do
			local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					card:flip()
					play_sound("card1", percent)
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for i, card in ipairs(G.hand.highlighted) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					SMODS.change_base(card, suits[i], ranks[i])
					return true
				end
			}))
		end
		for i, card in ipairs(G.hand.highlighted) do
			local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					card:flip()
					play_sound("tarot2", percent, 0.6)
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.5)
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}
