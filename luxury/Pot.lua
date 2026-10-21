--[[
Pot
Luxury, $8

Use to remember cards held in hand,
Those cards will be drawn first next round
--]]

DBBQ.Luxury{
	key = "pot",
	soul_pos = {x = 2, y = 2},
	config = {extra = {memory = {}, used = false}},
	generate_ui = function(self, info_queue, item, desc_nodes, specific_vars, full_UI_table)
		full_UI_table.name = localize({type = 'name', key = self.key, set = self.set, nodes = full_UI_table.name})
		localize({type = 'descriptions', key = self.key, set = self.set, nodes = desc_nodes})
		if next(item.ability.extra.memory) then
			local areadisplay = CardArea(G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h, 2 * G.CARD_W, 0.5 * G.CARD_H, {
				card_limit = G.hand.config.card_limit,
				type = 'title',
				highlight_limit = 0,
				card_w = G.CARD_W * 0.4,
				draw_layers = { 'card' },
				negative_info = 'playing_card'
			})
			for _, c in ipairs(G.playing_cards) do
				if item.ability.extra.memory[c.sort_id] then
					local copy = copy_card(c, nil, 0.4)
					copy.T.x = areadisplay.T.x + areadisplay.T.w / 2
					copy.T.y = areadisplay.T.y
					copy:hard_set_T()
					copy.abn_atomic_exists_for_selection = c
					areadisplay:emplace(copy)
				end
			end
			areadisplay:sort()
			desc_nodes[#desc_nodes + 1] = {{n = G.UIT.O, config = {object = areadisplay}}}
		end
	end,
	luxury_can_use = function(self, item)
		return #G.hand.cards > 0
	end,
	luxury_use = function(self, item, area)
		if #G.hand.cards == 0 then return end
		for _, card in ipairs(G.hand.cards) do
			item.ability.extra.memory[card.sort_id] = true
		end
		SMODS.calculate_effect({message = localize("k_dbbq_remembered")}, item)
	end,
	calculate = function(self, item, context)
		if context.first_hand_drawn then
			item.ability.extra.memory = {}
		end
		return DBBQ.Luxury.calculate(self, item, context)
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}

local old_shuffle = CardArea.shuffle
function CardArea:shuffle(_seed)
	local ret = old_shuffle(self, _seed)
	local pots = SMODS.find_card("c_dbbq_pot")
	if #pots > 0 and self == G.deck then
		local priorities = {}
		local others = {}
		for _, card in pairs(self.cards) do
			local prio = false
			for _, pot in ipairs(pots) do
				if pot.ability.extra.memory[card.sort_id] then
					prio = true
					table.insert(priorities, card)
					break
				end
			end
			if not prio then
				table.insert(others, card)
			end
		end
		for _, card in ipairs(priorities) do
			table.insert(others, card)
		end
		self.cards = others
		self:set_ranks()
	end
	return ret
end
