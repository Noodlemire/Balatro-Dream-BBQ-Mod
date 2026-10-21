--[[
Razorback
Luxury, $8

Destroy half of your jokers, rounded down,
Remaining jokers gain random editions
(Must have enough jokers to destroy)
--]]

local function get_jokers()
	local safe, dest = {}, {}
	for _, area in ipairs(SMODS.get_card_areas("jokers")) do
		for _, joker in ipairs(area.cards) do
			if joker.ability and joker.ability.set == "Joker" then
				if not SMODS.is_eternal(joker) then
					table.insert(dest, joker)
				else
					table.insert(safe, joker)
				end
			end
		end
	end
	return safe, dest
end

DBBQ.Luxury{
	key = "razorback",
	soul_pos = {x = 3, y = 3},
	luxury_can_use = function(self, item)
		local safe, dest = get_jokers()
		return #dest > 0 and #dest >= math.floor((#dest + #safe) / 2)
	end,
	luxury_use = function(self, item, area)
		local safe, dest = get_jokers()
		local num = math.floor((#dest + #safe) / 2)
		if #dest == 0 or #dest < num then return end
		pseudoshuffle(dest, pseudoseed("c_dbbq_razorback"))
		for i, joker in ipairs(dest) do
			if i <= num then
				G.E_MANAGER:add_event(Event({
					func = function()
						joker:start_dissolve()
						return true
					end
				}))
			else
				table.insert(safe, joker)
			end
		end
		for i, joker in ipairs(safe) do
			if not joker.edition then
				G.E_MANAGER:add_event(Event({
					func = function()
						joker:set_edition(SMODS.poll_edition({guaranteed = true}), true)
						return true
					end
				}))
			end
		end
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
