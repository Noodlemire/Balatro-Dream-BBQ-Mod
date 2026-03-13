DBBQ.suits.dbbq_fish = {
	frames = {25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48},
	frame = 1,
	timer = 0,
	delay = 0.0667
}

SMODS.Suit {
	key = "fish",
	card_key = "FISH",
	pos = {y = 25},
	ui_pos = {x = 3, y = 0},
	lc_atlas = "dbbq_suits",
	hc_atlas = "dbbq_suits",
	lc_ui_atlas = "dbbq_suit_ui",
	hc_ui_atlas = "dbbq_suit_ui",
	lc_colour = HEX("8954d6"),
	hc_colour = HEX("8954d6"),

	in_pool = function(self, args)
		return G.GAME.dbbq_spawn_custom_ranks
	end
}

local old_scc = SMODS.calculate_context
function SMODS.calculate_context(context)
	local ret = old_scc(context)

	if context.after then
		local fish = {}
		for _, card in ipairs(context.scoring_hand) do
			if not SMODS.has_no_suit(card) and not card.debuff and card.base.suit == "dbbq_fish" then
				table.insert(fish, card)
			end
		end
		if #fish == 2 then
			local lost, copy = fish[1], fish[2]
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				func = function()
					copy:flip()
					lost:flip()
					play_sound("card1")
					copy:juice_up()
					lost:juice_up()
					return true
				end,
			}))
			delay(0.2)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					copy_card(copy, lost)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				func = function()
					copy:flip()
					lost:flip()
					play_sound("tarot2")
					copy:juice_up()
					lost:juice_up()
					return true
				end,
			}))
			delay(1)
		end
	end

	return ret
end
