--[[
Pivot
Luxury, $8

Upgrade all least
played poker hands
--]]

DBBQ.Luxury{
	key = "pivot",
	soul_pos = {x = 3, y = 0},
	luxury_use = function(self, item, area)
		update_hand_text(
			{sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3},
			{handname = localize("k_dbbq_least_played_hands"), chips = "...", mult = "...", level = ""}
		)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 1,
			func = function()
				play_sound("tarot1")
				item:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
				return true
			end
		}))
		update_hand_text({delay = 0}, {mult = "+", StatusText = true})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.9,
			func = function()
				play_sound("tarot1")
				item:juice_up(0.8, 0.5)
				return true
			end
		}))
		update_hand_text({delay = 0}, {chips = "+", StatusText = true})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.9,
			func = function()
				play_sound("tarot1")
				item:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = nil
				return true
			end
		}))
		update_hand_text({sound = "button", volume = 0.7, pitch = 0.9, delay = 0}, {level = "+1"})
		delay(1.3)
		local hands, least = {}, nil
		for k, v in pairs(G.GAME.hands) do
			if v.visible and (not least or least > v.played) then
				least = v.played
			end
		end
		for k, v in pairs(G.GAME.hands) do
			if v.played <= least then
				table.insert(hands, k)
			end
		end
		SMODS.upgrade_poker_hands({hands = hands, instant = true})
		update_hand_text(
			{sound = "button", volume = 0.7, pitch = 1.1, delay = 0},
			{mult = 0, chips = 0, handname = "", level = ""}
		)
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
