--[[
Spacious Durable Luxury Bag
Booster, $8

Choose 1 of up to
3 Luxury items
--]]

local luxury_sets = {
	{"flange", "pencil", "mead"},
	{"pivot", "crampon", "artillery"},
	{"cutlets", "target", "plimsol"},
	{"jodhpurs", "printer", "damson"},
	{"fish", "leek", "braid"},
	{"pot", "knurler", "lathe"},
	{"spigot", "tripod", "pickle"},
	{"razorback", "periwinkle", "argon"}
}

SMODS.Booster{
	key = "sdlb",
	atlas = "dbbq_luxury",
	pos = {x = 5, y = 0},
	cost = 8,
	kind = "dbbq_luxury",
	select_card = "consumeables",
	disable_shine = true,
	config = {extra = 3, choose = 1},
	create_card = function(self, card, i)
		if not G.GAME.dbbq_current_luxury_set or #G.GAME.dbbq_current_luxury_set == 0 then
			G.GAME.dbbq_current_luxury_set = {}
			local set = pseudorandom_element(luxury_sets, "p_dbbq_sdlb")
			for i = 1, #set do
				table.insert(G.GAME.dbbq_current_luxury_set, set[i])
			end
		end
		return {
			key = "c_dbbq_"..table.remove(G.GAME.dbbq_current_luxury_set, 1),
			area = G.pack_cards,
			skip_materialize = true,
			soulable = true,
		}
	end
}
