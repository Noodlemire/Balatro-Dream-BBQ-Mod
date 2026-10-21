--[[
Flange
Luxury, $8

Apply random Seals to up to 2 cards held in hand.
--]]

DBBQ.Luxury{
	key = "flange",
	soul_pos = {x = 0, y = 1},
	config = {extra = {seals = 2, used = false}},
	loc_vars = function(self, info_queue, item)
		return {vars = {item.ability.extra.seals}}
	end,
	luxury_can_use = function(self, item)
		return G.hand and #G.hand.cards > 0
	end,
	luxury_use = function(self, item, area)
		local cards = {}
		for _, card in ipairs(G.hand.cards) do
			table.insert(cards, card)
		end
		table.sort(cards, function(a, b)
			return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
		end)
		pseudoshuffle(cards, pseudoseed("c_dbbq_flange"))
		for i = 1, item.ability.extra.seals do
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
					cards[i]:set_seal(SMODS.poll_seal({guaranteed = true, type_key = 'c_dbbq_flange'}), nil, true)
					return true
				end
			}))
		end
	end,
}
