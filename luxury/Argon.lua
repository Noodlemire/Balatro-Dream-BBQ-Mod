--[[
Argon
Luxury, $8

Create 2 Negative copies of a
Tarot card corresponding to the
median rank out of cards held in hand
(Currently: 0 - The Fool)
--]]

local tarot_map = {
	[0] = "c_fool", "c_magician", "c_high_priestess", "c_empress", "c_emperor",
	"c_heirophant", "c_lovers", "c_chariot", "c_justice", "c_hermit",
	"c_wheel_of_fortune", "c_strength", "c_hanged_man", "c_death", "c_temperance",
	"c_devil", "c_tower", "c_star", "c_moon", "c_sun", "c_judgement", "c_world"
}

local function median_rank_to_tarot(extra)
	if not G.hand or #G.hand.cards <= 0 then return end
	local rank_numbers = {}
	for _, card in ipairs(G.hand.cards) do
		local rank_num = SMODS.has_no_rank(card) and 0 or SMODS.Ranks[card.base.value].nominal
		if card.base.value == "Jack" or card.base.value == "Queen" or card.base.value == "King" or card.base.value == "Ace" then
			rank_num = card.base.id
		end
		table.insert(rank_numbers, SMODS.has_no_rank(card) and 0 or SMODS.Ranks[card.base.value].nominal)
	end
	table.sort(rank_numbers)
	local median = rank_numbers[math.ceil(#rank_numbers / 2)]
	median = math.max(0, math.min(median, #tarot_map))
	extra.tarot = tarot_map[median] or "c_fool"
	extra.tarot_num = tarot_map[median] and median or 0
end

DBBQ.Luxury{
	key = "argon",
	soul_pos = {x = 3, y = 4},
	config = {extra = {cards = 2, tarot_num = 0, tarot = "c_fool"}},
	loc_vars = function(self, info_queue, item)
		median_rank_to_tarot(item.ability.extra)
		info_queue[#info_queue+1] = G.P_CENTERS[item.ability.extra.tarot]
		return {vars = {item.ability.extra.cards, item.ability.extra.tarot_num, localize({type = "name_text", set = "Tarot", key = item.ability.extra.tarot})}}
	end,
	luxury_can_use = function(self, item)
		return #G.hand.cards > 0
	end,
	luxury_use = function(self, item, area)
		median_rank_to_tarot(item.ability.extra)
		for i = 1, item.ability.extra.cards do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.15,
				func = function()
					local card = SMODS.add_card({key = item.ability.extra.tarot})
					card:set_edition("e_negative", true)
					return true
				end
			}))
		end
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}
