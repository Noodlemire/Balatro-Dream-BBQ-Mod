DBBQ.suits.dbbq_utility = {
	frames = {16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 18, 19, 20, 21, 22, 23, 24},
	frame = 1,
	timer = 0,
	delay = 0.13
}

SMODS.Suit {
	key = "utility",
	card_key = "UTILITY",
	pos = {y = 16},
	ui_pos = {x = 2, y = 0},
	lc_atlas = "dbbq_suits",
	hc_atlas = "dbbq_suits",
	lc_ui_atlas = "dbbq_suit_ui",
	hc_ui_atlas = "dbbq_suit_ui",
	lc_colour = HEX("7e3a3c"),
	hc_colour = HEX("7e3a3c"),

	in_pool = function(self, args)
		return G.GAME.dbbq_spawn_custom_ranks
	end
}

local old_scc = SMODS.calculate_context
function SMODS.calculate_context(context)
	local ret = old_scc(context)

	if context.after and #context.scoring_hand > 1 then
		local pause = false
		local utilities = {}
		local eligible = {}
		for i, card in ipairs(context.scoring_hand) do
			if not SMODS.has_no_suit(card) and not card.debuff and not card.getting_sliced then
				table.insert(eligible, card)
				if card.base.suit == "dbbq_utility" then
					table.insert(utilities, #eligible)
				end
			end
		end
		if #utilities > 0 and #eligible > 1 then
			local stencil = table.remove(eligible, pseudorandom_element(utilities, "dbbq_utility"))

			local other = {}
			for _, card in ipairs(eligible) do
				if card.base.id ~= stencil.base.id then
					table.insert(other, card)
				end
			end
			if #other == 0 then return ret end

			local target = pseudorandom_element(other, "dbbq_utility")

			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				func = function()
					target:flip()
					stencil:flip()
					play_sound("card1")
					target:juice_up()
					stencil:juice_up()
					return true
				end,
			}))
			delay(0.2)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					SMODS.change_base(target, nil, stencil.base.value)
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				func = function()
					target:flip()
					stencil:flip()
					play_sound("tarot2")
					target:juice_up()
					stencil:juice_up()
					return true
				end,
			}))
			delay(1)
		end
	end

	return ret
end
