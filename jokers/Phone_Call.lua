--[[
Phone Call
Common, $2

When hand is played,
attempt to call someone using held cards
If their ranks match one
of four secret phone numbers,
self-destruct and spawn the associated joker
(Phone numbers are all 7 digits
long, and only use numbers 2-8)
(Order doesn't matter)
(Cannot produce a joker you already have)
--]]



local phonebook = {}
local function phonebook_entry(joker, number)
	phonebook[joker] = {
		digits = {['2'] = 0, ['3'] = 0, ['4'] = 0, ['5'] = 0, ['6'] = 0, ['7'] = 0, ['8'] = 0},
		order = {}
	}
	for n = 1, 7 do
		local digit = number:sub(n, n)
		phonebook[joker].digits[digit] = phonebook[joker].digits[digit] + 1
		phonebook[joker].order[n] = digit
	end
end
phonebook_entry("j_dbbq_radical", "2543276")
phonebook_entry("j_dbbq_soooooie", "6687226")
phonebook_entry("j_dbbq_fax", "7746837")--7774683
phonebook_entry("j_dbbq_lazy", "8237653")

SMODS.Joker{
	key = "phone",
	atlas = "dbbq_jokers",
	rarity = 1,
	cost = 2,
	pos = {x = 6, y = 1},
	blueprint_compat = false,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_phone", set = "Other"}
		end
	end,
	calculate = function(self, card, context)
		if context.after and not context.blueprint then
			local call = {}
			for _, pc in ipairs(G.hand.cards) do
				local rank = tostring(pc:get_id())
				if phonebook.j_dbbq_fax.digits[rank] then
					call[rank] = (call[rank] or 0) + 1
				end
			end
			for joker, number in pairs(phonebook) do
				if #SMODS.find_card(joker) == 0 then
					local match = true
					for i = 2, 8 do
						local rank = tostring(i)
						if (call[rank] or 0) < number.digits[rank] then
							match = false
							break
						end
					end
					if match then
						if not card.edition or not card.edition.negative or #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
							local already = {}
							for i = 1, 7 do
								for _, pc in ipairs(G.hand.cards) do
									if tostring(pc:get_id()) == number.order[i] and not already[pc] then
										already[pc] = true
										G.E_MANAGER:add_event(Event({
											trigger = "after",
											delay = 1,
											func = function()
												local n = tonumber(number.order[i]) % 3
												if n == 0 then n = 3 end
												play_sound("dbbq_phonebeep"..n)
												card:juice_up()
												pc:juice_up()
												return true
											end
										}))
										break
									end
								end
							end
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 1,
								func = function()
									SMODS.add_card({key = joker})
									card.getting_sliced = true
									card:start_dissolve()
									return true
								end
							}))
							return {message = localize("k_plus_joker")}
						else
							return {message = localize("k_no_room_ex")}
						end
					end
				end
			end
		end
	end
}
