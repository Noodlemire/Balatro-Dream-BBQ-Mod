--[[
Blue-Red Combine
Common, $4

Retrigger first Club and Heart
in scoring hand if it has both
--]]

local function check_hearts_clubs(hand, callback)
	local hearts, clubs, wilds = 0, 0, 0
	for _, pc in ipairs(hand) do
		local valid = false
		if not SMODS.has_no_suit(pc) then
			if SMODS.has_any_suit(pc) then
				wilds = wilds + 1
				valid = true
			elseif pc.base.suit == "Hearts" and hearts < 1 then
				hearts = hearts + 1
				valid = true
			elseif pc.base.suit == "Clubs" and clubs < 1 then
				clubs = clubs + 1
				valid = true
			end
		end
		if callback(wilds + hearts + clubs, valid, pc) then return end
	end
end

SMODS.Joker{
	key = "brc",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 4,
	pos = {x = 1, y = 5},
	blueprint_compat = true,
	config = {extra = {active = false}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_brc", set = "Other"}
		end
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.active = false
			check_hearts_clubs(context.scoring_hand, function(sum)
				if sum >= 2 then
					card.ability.extra.active = true
					return true
				end
			end)
		elseif context.repetition and context.cardarea == G.play and card.ability.extra.active and (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Clubs")) then
			local rep = false
			check_hearts_clubs(context.scoring_hand, function(sum, valid, pc)
				if sum > 2 or (not valid and not SMODS.has_any_suit(context.other_card) and context.other_card.base.suit == pc.base.suit) then
					return true
				elseif pc == context.other_card then
					rep = true
					return true
				end
			end)
			if rep then
				return {repetitions = 1}
			end
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{ref_table = "card.joker_display_values", ref_value = "active_text"}
			},
			reminder_text = {
				{text = "("},
				{ref_table = "card.joker_display_values", ref_value = "local_club", colour = G.C.SUITS.Clubs},
				{text = "+"},
				{ref_table = "card.joker_display_values", ref_value = "local_heart", colour = G.C.SUITS.Hearts},
				{text = ")"},
			},
			calc_function = function(card)
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				card.joker_display_values.is_active = false
				if text ~= "Unknown" then
					check_hearts_clubs(scoring_hand, function(sum)
						if sum >= 2 then
							card.joker_display_values.is_active = true
							return true
						end
					end)
				end
				card.joker_display_values.active_text = localize("jdis_"..(card.joker_display_values.is_active and "active" or "inactive"))
				card.joker_display_values.local_heart = localize("Hearts", 'suits_singular')
				card.joker_display_values.local_club = localize("Clubs", 'suits_singular')
			end,
			style_function = function(card, text, reminder_text, extra)
				if text and text.children and text.children[1] then
					text.children[1].config.colour = card.joker_display_values.is_active and G.C.GREEN or
						G.C.UI.TEXT_INACTIVE
				end
			end,
			retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
				if held_in_hand or not joker_card.joker_display_values.is_active then return 0 end
				local rep = false
				check_hearts_clubs(scoring_hand, function(sum, valid, pc)
					if sum > 2 or (not valid and not SMODS.has_any_suit(playing_card) and playing_card.base.suit == pc.base.suit) then
						return true
					elseif pc == playing_card then
						rep = true
						return true
					end
				end)
				return rep and JokerDisplay.calculate_joker_triggers(joker_card) or 0
			end
		}
	end
}
