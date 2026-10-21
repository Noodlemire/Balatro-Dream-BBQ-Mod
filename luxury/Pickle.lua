--[[
Pickle
Luxury, $8

Gain $0.5 per card that has
been present in your deck
since the beginning of the run
(Max of $25, currently $0)
--]]

table.insert(DBBQ.calculates, function(context)
	if (context.setting_blind or context.skip_blind) and not G.GAME.dbbq_initial_deck then
		G.GAME.dbbq_initial_deck = {}
		for _, card in ipairs(G.playing_cards) do
			table.insert(G.GAME.dbbq_initial_deck, card.sort_id)
		end
	end
end)

function count_lasting_cards()
	if not G.GAME.dbbq_initial_deck then return #(G.playing_cards or {}) end
	local count = 0
	for _, init in ipairs(G.GAME.dbbq_initial_deck) do
		for _, card in ipairs(G.playing_cards) do
			if card.sort_id == init then
				count = count + 1
				break
			end
		end
	end
	return count
end

DBBQ.Luxury{
	key = "pickle",
	soul_pos = {x = 1, y = 3},
	config = {extra = {money = 0.5, max = 25, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.money, item.ability.extra.max, math.min(item.ability.extra.money * count_lasting_cards(), item.ability.extra.max)}}
	end,
	luxury_can_use = function(self, item)
		return count_lasting_cards() > 0
	end,
	luxury_use = function(self, item, area)
		SMODS.calculate_effect({dollars = math.min(item.ability.extra.money * count_lasting_cards(), item.ability.extra.max)}, item)
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
