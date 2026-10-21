DBBQ = {
	calculates = {},
	suits = {},
	quip_colours = {},
	quip_pitch = {},
	quip_speed = {},
	quip_sound = {},
	quip_sound_pool = {},
	quip_function = {},
	add_quip = function(center, keyword, play_when, length, speed)
		SMODS.JimboQuip{
			key = center..'_'..keyword,
			type = play_when ~= "any" and play_when or nil,
			extra = {
				center = "j_dbbq_"..center,
				particle_colours = DBBQ.quip_colours[center],
				pitch = DBBQ.quip_pitch[center..'_'..keyword] or DBBQ.quip_pitch[center],
				times = length,
				delay = speed or DBBQ.quip_speed[center] or 0.13
			},
			filter = function(self, type)
				if next(SMODS.find_card("j_dbbq_"..center)) then
					return true, {weight = 100}
				end
			end,
			play_sounds = DBBQ.quip_function[center] or (DBBQ.quip_sound[center] and function(self, times)
				if not DBBQ.quip_sound_pool[center] or #DBBQ.quip_sound_pool[center] == 0 then
					DBBQ.quip_sound_pool[center] = {}
					for i, s in ipairs(DBBQ.quip_sound[center]) do
						DBBQ.quip_sound_pool[center][i] = s
					end
				end
				play_sound("dbbq_"..table.remove(DBBQ.quip_sound_pool[center], math.random(1, #DBBQ.quip_sound_pool[center])))
			end)
		}
	end,
	sound_range = function(key, range)
		local output = {}
		for i = 1, range do
			output[i] = key..i
		end
		return output
	end,
	iterate_jokers = function(callback)
		for _, area in ipairs(SMODS.get_card_areas("jokers") or {}) do
			for index, joker in ipairs(area.cards or {}) do
				if joker.ability and joker.ability.set == "Joker" then
					local ret = callback(joker, area, index)
					if ret == "break" then break end
					if ret == "return" then return end
				end
			end
		end
	end,
	count_jokers = function()
		local count = 0
		DBBQ.iterate_jokers(function(joker)
			count = count + 1
		end)
		return count
	end
}

local items = {"jokers", "decks", "challenges", "suits", "luxury", "stakes"}

SMODS.current_mod.optional_features = function()
	return {
		post_trigger = true,
		retrigger_joker = true,
		cardareas = {
			discard = true,
			deck = true
		}
	}
end

SMODS.current_mod.calculate = function(self, context)
	for _, calc in ipairs(DBBQ.calculates) do
		calc(context)
	end
end

SMODS.Atlas {
	key = "dbbq_bus",
	path = "j_dbbq_bus.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "dbbq_decks",
	path = "Decks.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "dbbq_halves",
	path = "Halves.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "dbbq_jokers",
	path = "Jokers.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
    key = "dbbq_luxury",
    path = "Luxury.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{
	key = "modicon",
	path = "icon.png",
	px = 33,
	py = 33
}

SMODS.Atlas {
	key = "dbbq_seals",
	path = "Seals.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "dbbq_slotmachine",
	path = "slotmachine.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
    key = "dbbq_stakes",
    path = "Stakes.png",
    px = 29,
    py = 29,
}

SMODS.Atlas {
	key = "dbbq_stickers",
	path = "Stickers.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "dbbq_suits",
	path = "Suits.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "dbbq_suit_ui",
	path = "Suit_UI.png",
	px = 18,
	py = 18,
}

SMODS.ConsumableType{
	key = "dbbq_luxury",
	primary_colour = HEX("FFFFFF"),
	secondary_colour = HEX("000000"),
	default = "c_dbbq_flange",
}

SMODS.UndiscoveredSprite{
	key = "dbbq_luxury",
	atlas = "dbbq_luxury",
	pos = {x = 5, y = 0},
	no_overlay = true
}

DBBQ.Luxury = SMODS.Consumable:extend{
	set = "dbbq_luxury",
	atlas = "dbbq_luxury",
	default = "c_dbbq_flange",
	pos = {x = 0, y = 0},
	cost = 8,
	config = {extra = {used = false}},
	keep_on_use = function(self, item)
		return true
	end,
	can_use = function(self, item)
		return not item.ability.extra.used and self:luxury_can_use(item)
	end,
	luxury_can_use = function(self, item)
		return true
	end,
	use = function(self, item, area, copier)
		item.ability.extra.used = true
		if self.dbbq_sort_selected then
			table.sort(G.hand.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
		end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				item:juice_up(0.3, 0.5)
				return true
			end
		}))
		self:luxury_use(item, area, copier)
		delay(0.5)
	end,
	add_to_deck = function(self, item, from_debuff)
		if not from_debuff and self:can_use(item) then
			self:luxury_start_juice(item)
		end
	end,
	calculate = function(self, item, context)
		if context.blueprint then return end
		if context.ante_end then
			item.ability.extra.used = false
		end
		if not item.ability.extra.used and self:luxury_start_juice_context(item, context) then
			self:luxury_start_juice(item)
		end
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
	luxury_start_juice = function(self, item)
		juice_card_until(item, function(item)
			return not item.ability.extra.used and not G.RESET_JIGGLES
		end, true)
	end
}

SMODS.Rarity {
	key = "secret",
	badge_colour = HEX("000000"),
	pools = {Joker = true},
	default_weight = 0
}

if next(SMODS.find_mod("CardSleeves")) then
	SMODS.Atlas {
		key = "dbbq_sleeves",
		path = "Sleeves.png",
		px = 73,
		py = 95,
	}

	table.insert(items, "sleeves")
end

for _, item in ipairs(items) do
	local files = NFS.getDirectoryItems(SMODS.current_mod.path..item)
	for _, filename in pairs(files) do
		if string.sub(filename, string.len(filename) - 3) == '.lua' then
			assert(SMODS.load_file(item.."/"..filename))()
		end
	end
end

local sounds = NFS.getDirectoryItems(SMODS.current_mod.path.."assets/sounds")
for _, filename in pairs(sounds) do
	if string.sub(filename, string.len(filename) - 3) == '.ogg' then
		SMODS.Sound({
			key = string.sub(filename, 1, string.len(filename) - 4),
			path = filename
		})
	end
end
