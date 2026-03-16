--[[
A Dealer In Real Estate
Common, $4

+3 Mult per unique
rank held in hand
--]]

local name = -1
local ranks = {}
local cards = {}

SMODS.Joker{
	key = "adire",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 7, y = 2},
	blueprint_compat = true,
	config = {extra = {mult = 3}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_adire", set = "Other"}
		end
		name = (name + 1) % 22
		return {vars = {card.ability.extra.mult}, key = self.key..name}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			local found = false
			for _, playing_card in ipairs(cards) do
				if playing_card == context.other_card then
					found = true
					break
				end
			end
			if found then
				return {
					mult = card.ability.extra.mult
				}
			end
		elseif not context.blueprint then
			if context.before or context.after then
				ranks = {}
				cards = {}
			end
			if context.before then
				for _, playing_card in ipairs(G.hand.cards) do
					if not SMODS.has_no_rank(playing_card) then
						local rank = tostring(playing_card:get_id())
						if not ranks[rank] then
							table.insert(cards, playing_card)
							ranks[rank] = true
						end
					end
				end
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.MULT},
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local jd_ranks = {}
				local count = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if (playing_hand or not playing_card.highlighted) and not SMODS.has_no_rank(playing_card) then
						local rank = tostring(playing_card:get_id())
						if not jd_ranks[rank] then
							jd_ranks[rank] = true
							count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.mult = count * card.ability.extra.mult
			end
		}
	end
}
