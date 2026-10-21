--[[
Damson
Luxury, $8

Enhance selected
card into a Damson
--]]

--[[
Damson
Enhancement

Has no rank or suit,
Straights and Flushes can
be formed with one less
card per scoring Damson
--]]

DBBQ.Luxury{
	key = "damson",
	soul_pos = {x = 4, y = 1},
	loc_vars = function(self, info_queue, self)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_dbbq_damson
	end,
	luxury_can_use = function(self, item)
		return #G.hand.highlighted == 1
	end,
	luxury_use = function(self, item, area)
		local selection = G.hand.highlighted[1]
		if not selection then return end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				selection:flip()
				play_sound("card1", 1.15)
				selection:juice_up(0.3, 0.3)
				return true
			end
		}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				selection:set_ability("m_dbbq_damson", false, true)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				selection:flip()
				play_sound("tarot2", 0.85, 0.6)
				selection:juice_up(0.3, 0.3)
				return true
			end
		}))
		delay(0.5)
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}

SMODS.Enhancement{
	key = "damson",
	pos = {x = 5, y = 1},
	atlas = "dbbq_luxury",
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	always_scores = true,
	in_pool = function() return false end
}

local old_four_fingers = SMODS.four_fingers
function SMODS.four_fingers(hand_type)
	local fingers = old_four_fingers(hand_type)
	for _, card in ipairs(#G.play.cards > 0 and G.play.cards or G.hand.highlighted) do
		if SMODS.has_enhancement(card, "m_dbbq_damson") then
			fingers = fingers - 1
			if fingers <= 0 then return 0 end
		end
	end
	return fingers
end
