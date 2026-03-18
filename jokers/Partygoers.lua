--[[
Partygoers
Common, $4

Wild Cards score +Mult
instead of +Chips equal
to their base value

If played 5 card hand is 1 suit
away from containing a Flush,
the outlier becomes a Wild Card
--]]

local function add_wild_condition_check()
	local suit_cards = {}
	local suit_list = {}
	for _, card in ipairs(G.hand.highlighted) do
		if not SMODS.has_any_suit(card) and not SMODS.has_no_suit(card) and not card.debuff then
			local suit = card.base.suit
			if suit_cards[suit] then
				table.insert(suit_cards[suit], card)
			else
				suit_cards[suit] = {card}
				table.insert(suit_list, suit)
			end
		end
	end
	return suit_cards, suit_list
end

SMODS.Joker{
	key = "pg",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 0, y = 5},
	blueprint_compat = false,
	config = {extra = {active = false}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_pg", set = "Other"}
		end
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
	end,
	calculate = function(self, joker, context)
		if context.blueprint then return end
		if context.press_play then
			if #G.hand.highlighted ~= 5 then
				joker.ability.extra.active = false
				return
			end
			local suit_cards, suit_list = add_wild_condition_check()
			if #suit_list == 2 and (#suit_cards[suit_list[1]] == 1 or #suit_cards[suit_list[2]] == 1) then
				joker.ability.extra.active = true
				local card
				if #suit_cards[suit_list[1]] > 1 then
					card = suit_cards[suit_list[2]][1]
				elseif #suit_cards[suit_list[2]] > 1 then
					card = suit_cards[suit_list[1]][1]
				else
					card = suit_cards[pseudorandom_element(suit_list, pseudoseed("Don't be a party pooper!"))][1]
				end
				card:set_ability("m_wild", nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up()
						return true
					end
				}))
				return {
					--replace_scoring_name = "Flush",
					message = localize("k_dbbq_join_us")
				}
			else
				joker.ability.extra.active = false
			end
		elseif context.modify_scoring_hand and context.in_scoring and joker.ability.extra.active then
			return {add_to_hand = true}
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{ref_table = "card.joker_display_values", ref_value = "active_text"}
			},
			calc_function = function(card)
				local active = false
				local suit_cards, suit_list = add_wild_condition_check()
				if #G.hand.highlighted == 5 and #suit_list == 2 and (#suit_cards[suit_list[1]] == 1 or #suit_cards[suit_list[2]] == 1) then
					active = true
				end
				card.joker_display_values.is_active = active
				card.joker_display_values.active_text = localize("jdis_"..(card.joker_display_values.is_active and "active" or "inactive"))
			end,
			style_function = function(card, text, reminder_text, extra)
				if text and text.children and text.children[1] then
					text.children[1].config.colour = card.joker_display_values.is_active and G.C.GREEN or G.C.UI.TEXT_INACTIVE
				end
			end
		}
	end
}
