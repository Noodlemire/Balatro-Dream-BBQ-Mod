--[[
Slot Machine / It Feeds On Hope
Rare, $8

Once per round, you may pay $3
to spin the slots! This joker's
effect changes based the symbols
you get, and if all three are
the same, you get X3 the reward

If played hand [is/contains] a
[Hand name] with at least one
scoring [Edition/Seal] card,
[bonus text here]
--]]

local firstseen = true
local ring_data = {}
local ring_data_list = {
	{frames = 18, data = {2, 1, 2, 1}},
	{frames = 6, data = false},
	{frames = 12, data = {1, 2, 1, 2}},
	{frames = 3, data = false},
	{frames = 3, data = {1, 2, 1, 2}},
	{frames = 3, data = false},
	{frames = 3, data = {2, 1, 2, 1}},
	{frames = 3, data = false},
	{frames = 12, data = {1, 2, 1, 2}},
	{frames = 9, data = {2, 1, 2, 1}},
	{frames = 12, data = false},
	{frames = 3, data = {2, 1, 2, 1}},
	{frames = 3, data = false},
	{frames = 6, data = {1, 2, 1, 2}},
	{frames = 3, data = false},
	{frames = 3, data = {2, 1, 2, 1}},
	{frames = 6, data = false},
	{frames = 3, data = {2, 1, 0, 1}},
	{frames = 3, data = {1, 2, 1, 0}},
	{frames = 3, data = {0, 1, 2, 1}},
	{frames = 3, data = {1, 0, 1, 2}},
	{frames = 3, data = {2, 1, 0, 1}},
	{frames = 3, data = {1, 2, 1, 0}},
	{frames = 3, data = {0, 1, 2, 1}},
	{frames = 3, data = {1, 0, 1, 2}},
	{frames = 3, data = {2, 1, 0, 1}},
	{frames = 3, data = {1, 2, 1, 0}},
	{frames = 3, data = {0, 1, 2, 1}},
	{frames = 3, data = false},
	{frames = 3, data = {1, 0, 1, 2}},
	{frames = 3, data = false},
	{frames = 6, data = {2, 1, 0, 1}},
	{frames = 6, data = {1, 2, 1, 0}},
	{frames = 3, data = false},
	{frames = 9, data = {0, 1, 2, 1}},
	{frames = 6, data = {1, 0, 1, 2}},
	{frames = 12, data = false},
	{frames = 2, data = {0, 2, 0, 1}},
	{frames = 1, data = {2, 0, 1, 0}},
	{frames = 1, data = {0, 2, 0, 1}},
	{frames = 1, data = {1, 0, 2, 0}},
	{frames = 1, data = {0, 0, 0, 1}},
	{frames = 1, data = {1, 0, 2, 0}},
	{frames = 1, data = {0, 1, 0, 0}},
	{frames = 1, data = {2, 0, 0, 1}},
	{frames = 1, data = {1, 0, 2, 0}},
	{frames = 2, data = {2, 0, 2, 1}},
	{frames = 2, data = {0, 1, 0, 0}},
	{frames = 1, data = {1, 0, 1, 2}},
	{frames = 1, data = {0, 0, 2, 1}},
	{frames = 1, data = {0, 1, 2, 0}},
	{frames = 1, data = {1, 2, 0, 1}},
	{frames = 1, data = {0, 0, 2, 0}},
	{frames = 1, data = {1, 2, 1, 1}},
	{frames = 1, data = {0, 2, 0, 0}},
	{frames = 1, data = {0, 0, 2, 0}},
	{frames = 2, data = {0, 0, 0, 2}},
	{frames = 3, data = {0, 0, 2, 2}},
	{frames = 3, data = {0, 2, 2, 2}},
	{frames = 3, data = {2, 2, 2, 2}},
	{frames = 2, data = {2, 2, 2, 1}},
	{frames = 2, data = {2, 2, 1, 2}},
	{frames = 2, data = {2, 1, 2, 2}},
	{frames = 2, data = {1, 2, 2, 2}},
	{frames = 3, data = {1, 1, 2, 2}},
	{frames = 3, data = {1, 1, 1, 2}},
	{frames = 3, data = {1, 1, 1, 1}},
	{frames = 2, data = {0, 1, 2, 1}},
	{frames = 2, data = {2, 0, 2, 1}},
	{frames = 2, data = {2, 1, 0, 1}},
	{frames = 2, data = {2, 1, 2, 0}},
	{frames = 2, data = {1, 2, 0, 2}},
	{frames = 3, data = {1, 0, 1, 2}},
	{frames = 3, data = {0, 2, 1, 2}},
	{frames = 3, data = {1, 0, 1, 2}},
	{frames = 2, data = {2, 1, 0, 1}},
	{frames = 2, data = {2, 1, 2, 0}},
	{frames = 2, data = {2, 1, 0, 1}},
	{frames = 3, data = {2, 0, 2, 1}},
	{frames = 3, data = {0, 1, 1, 1}},
	{frames = 1, data = {2, 2, 1, 1}},
	{frames = 1, data = {1, 1, 2, 2}},
	{frames = 1, data = {2, 2, 1, 1}},
	{frames = 1, data = {1, 1, 2, 2}},
	{frames = 1, data = {2, 2, 1, 1}},
	{frames = 1, data = {1, 1, 2, 2}},
	{frames = 1, data = {2, 2, 1, 1}},
	{frames = 1, data = {1, 1, 2, 2}},
	{frames = 1, data = {1, 2, 1, 2}},
	{frames = 1, data = {2, 1, 2, 1}},
	{frames = 1, data = {1, 2, 1, 2}},
	{frames = 1, data = {2, 1, 2, 1}},
	{frames = 1, data = {1, 2, 1, 2}},
	{frames = 1, data = {2, 1, 2, 1}},
	{frames = 1, data = {1, 2, 1, 2}},
	{frames = 1, data = {2, 1, 2, 1}},
	{frames = 1, data = {1, 2, 1, 2}},
	{frames = 2, data = {0, 2, 1, 2}},
	{frames = 2, data = {0, 0, 1, 2}},
	{frames = 3, data = {0, 0, 0, 2}},
	{frames = 3, data = false},
}
for _, set in ipairs(ring_data_list) do
	for i = 1, set.frames do
		table.insert(ring_data, set.data)
	end
end
ring_data_list = nil

local create_fronts = function(self, joker)
	joker.dbbq_ring_fronts = {}
	joker.dbbq_slot_fronts = {}
	for i = 1, 4 do
		joker.dbbq_ring_fronts[i] = Sprite(0, 0, 71, 95, G.ASSET_ATLAS[self.atlas], {x = 0, y = 0})
		joker.dbbq_ring_fronts[i].role.draw_major = joker
	end
	for i = 1, 3 do
		joker.dbbq_slot_fronts[i] = Sprite(0, 0, 71, 95, G.ASSET_ATLAS[self.atlas], {x = 0, y = 0})
		joker.dbbq_slot_fronts[i].role.draw_major = joker
	end
	if not joker.ability.extra.slots[3] then
		self:dbbq_spin(joker, true)
	else
		for i = 1, 3 do
			joker.dbbq_slot_fronts[i]:set_sprite_pos({x = joker.ability.extra.slots[i], y = i})
		end
	end
end

local slot_data = {
	[0] = {
		hand = {contains = "Full House"},
		card = {seal = "Gold"},
		colours = {G.C.BLACK},
		pluralize = true,
		bonus = function(self, joker, context, var)
			if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				local i = 1
				while i <= var and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit do
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					i = i + 1
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.15,
						func = function()
							SMODS.add_card({set = "dbbq_luxury"})
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
							return true
						end
					}))
					SMODS.calculate_effect({message = localize("k_plus_dbbq_luxury"), colour = HEX("000000")}, joker)
				end
			end
		end
	},
	{
		hand = {contains = "Flush"},
		card = {seal = "Purple"},
		colours = {G.C.SECONDARY_SET.Spectral},
		pluralize = true,
		bonus = function(self, joker, context, var)
			if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				local i = 1
				while i <= var and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit do
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					i = i + 1
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.15,
						func = function()
							SMODS.add_card({set = "Spectral"})
							G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
							return true
						end
					}))
					SMODS.calculate_effect({message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral}, joker)
				end
			end
		end
	},
	{
		hand = {is = "Three of a Kind", jd_shorten = "3oak"},
		card = {edition = "e_holo", jd_shorten = "holo"},
		colours = {G.C.MULT},
		bonus = function(self, joker, context, var)
			if context.individual and context.cardarea == G.play then
				joker.ability.extra.scalar_cache = var
				SMODS.scale_card(context.other_card, {
					ref_table = context.other_card.ability,
					ref_value = "perma_mult",
					scalar_table = joker.ability.extra,
					scalar_value = "scalar_cache",
					message_colour = G.C.RED
				})
			end
		end
	},
	{
		hand = {contains = "Straight"},
		card = {seal = "Red"},
		colours = {G.C.FILTER},
		pluralize = true,
		bonus = function(self, joker, context, var)
			if context.before and not context.blueprint then
				for _, area in ipairs(SMODS.get_card_areas("jokers")) do
					local found = false
					for _, other in ipairs(area.cards) do
						if found then
							if other.ability and other.ability.set == "Joker" then
								joker.ability.extra.joker_right = other
							end
							return
						end
						if other == joker then
							found = true
						end
					end
					if found then return end
				end
			elseif context.retrigger_joker_check and context.other_card == joker.ability.extra.joker_right then
				return {repetitions = var}
			elseif context.after and not context.blueprint then
				joker.ability.extra.joker_right = nil
			end
		end
	},
	{
		hand = {is = "Two Pair"},
		card = {seal = "Blue"},
		colours = {G.C.FILTER},
		pluralize = true,
		bonus = function(self, joker, context, var)
			if context.joker_main then
				for i = 1, var do
					SMODS.calculate_effect({message = localize("k_dbbq_plus_tag")}, joker)
					G.E_MANAGER:add_event(Event({
						func = function()
							add_tag({key = SMODS.poll_object({type = "Tag"})})
							return true
						end
					}))
				end
			end
		end
	},
	{
		hand = {is = "Pair"},
		card = {edition = "e_foil"},
		colours = {G.C.CHIPS},
		bonus = function(self, joker, context, var)
			if context.individual and context.cardarea == G.play then
				joker.ability.extra.scalar_cache = var
				SMODS.scale_card(context.other_card, {
					ref_table = context.other_card.ability,
					ref_value = "perma_bonus",
					scalar_table = joker.ability.extra,
					scalar_value = "scalar_cache",
					message_colour = G.C.BLUE
				})
			end
		end
	},
	{
		hand = {contains = "Four of a Kind", jd_shorten = "4oak"},
		card = {edition = "e_polychrome", jd_shorten = "poly"},
		colours = {G.C.WHITE, G.C.MULT},
		symbol = "X",
		bonus = function(self, joker, context, var)
			if context.individual and context.cardarea == G.play then
				joker.ability.extra.scalar_cache = var
				SMODS.scale_card(context.other_card, {
					ref_table = context.other_card.ability,
					ref_value = "perma_x_mult",
					scalar_table = joker.ability.extra,
					scalar_value = "scalar_cache",
					message_colour = G.C.RED
				})
			end
		end
	},
}

SMODS.Joker{
	key = "slots",
	atlas = "dbbq_slotmachine",
	rarity = 3,
	cost = 8,
	pos = {x = 0, y = 0},
	blueprint_compat = true,
	pronouns = "it_its",
	config = {extra = {
		spun = false, spin_cost = 3, triple_bonus = 3, slots = {},
		ring_timer = 0, ring_frame = 1,
		mouth_stage = 0, mouth_frame = 1,
		spin_frame = 0,
		slot_vars = {[0] = 1, 1, 4, 1, 1, 20, 0.2}
	}},
	add_to_deck = function(self, joker, from_debuff)
		if not from_debuff then
			local least = 999
			for _, area in ipairs(SMODS.get_card_areas("jokers")) do
				for _, other in ipairs(area.cards) do
					if other.ability and other.ability.set == "Joker" and other.config.center.key == self.key and other.ability.extra.ring_frame < least then
						least = other.ability.extra.ring_frame
					end
				end
			end
			joker.ability.extra.ring_frame = least % 995 - 2
		end
	end,
	update = function(self, joker, dt)
		if joker.ability.extra.ring_timer < 5 then
			joker.ability.extra.ring_timer = joker.ability.extra.ring_timer + 1
		else
			joker.ability.extra.ring_timer = 0
			joker.ability.extra.ring_frame = joker.ability.extra.ring_frame + 1
			if joker.ability.extra.ring_frame > #ring_data then
				joker.ability.extra.ring_frame = 1
			end
		end
		joker.ability.extra.mouth_timer = (joker.ability.extra.mouth_timer or math.random(900, 3600)) - 1
		if joker.ability.extra.mouth_stage == 1 then
			joker.ability.extra.mouth_frame = math.ceil(1 + (30 - joker.ability.extra.mouth_timer) / 10)
		elseif joker.ability.extra.mouth_stage == 3 then
			joker.ability.extra.mouth_frame = math.ceil(1 + joker.ability.extra.mouth_timer / 5)
		end
		joker.children.center:set_sprite_pos({x = 8, y = joker.ability.extra.mouth_frame})
		if joker.ability.extra.mouth_timer <= 0 then
			joker.ability.extra.mouth_stage = (joker.ability.extra.mouth_stage + 1) % 4
			if joker.ability.extra.mouth_stage == 1 then
				joker.ability.extra.mouth_timer = 30
			elseif joker.ability.extra.mouth_stage == 2 then
				joker.ability.extra.mouth_timer = math.random(30, 90)
			elseif joker.ability.extra.mouth_stage == 3 then
				joker.ability.extra.mouth_timer = 15
			else
				joker.ability.extra.mouth_timer = nil
			end
		end
		joker.ability.extra.spin_frame = (joker.ability.extra.spin_frame + 1) % 16
	end,
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_slots", set = "Other"}
		end
		local temp = {}
		for i = 1, 3 do
			temp[i] = slot_data[joker.ability.extra.slots[i]]
		end
		local hand, card, bonus = unpack(temp)
		local var = joker.ability.extra.slot_vars[joker.ability.extra.slots[3]] * (hand == card and card == bonus and joker.ability.extra.triple_bonus or 1)
		local label = card.card.seal and card.card.seal:lower().."_seal" or card.card.edition:sub(3)
		if label == "holo" then label = "holographic" end
		local plural = bonus.pluralize and var > 1 and "s" or ""
		local vars = {vars = {
			joker.ability.extra.spin_cost,
			joker.ability.extra.triple_bonus,
			localize(hand.hand.is and "k_dbbq_is" or "k_dbbq_contains"),
			localize(hand.hand.is or hand.hand.contains, "poker_hands"),
			localize(label, "labels"),
			(bonus.symbol or "+")..var,
			localize("k_dbbq_slotreward"..plural..joker.ability.extra.slots[3]),
			colours = {card.card.seal and G.C.FILTER or G.C.DARK_EDITION, bonus.colours[1], bonus.colours[2] or G.C.WHITE}
		}}
		info_queue[#info_queue + 1] = card.card.seal and G.P_SEALS[card.card.seal] or G.P_CENTERS[card.card.edition]
		if not firstseen and math.random() < 0.1 then
			vars.key = self.key.."_feeds"
		end
		firstseen = false
		return vars
	end,
	calculate = function(self, joker, context)
		if context.before and not context.blueprint then
			local hand = slot_data[joker.ability.extra.slots[1]].hand
			local card = slot_data[joker.ability.extra.slots[2]].card
			local found = false
			if (hand.is and context.scoring_name ~= hand.is) or (hand.contains and not next(context.poker_hands[hand.contains])) then return end
			for _, scoring_card in ipairs(context.scoring_hand) do
				if (card.edition and scoring_card.edition and scoring_card.edition.key == card.edition) or (card.seal and scoring_card:get_seal() == card.seal) then
					found = true
					break
				end
			end
			if not found then return end
			if joker.ability.extra.slots[1] == joker.ability.extra.slots[2] and joker.ability.extra.slots[2] == joker.ability.extra.slots[3] then
				joker.ability.extra.active = joker.ability.extra.triple_bonus
			else
				joker.ability.extra.active = 1
			end
		elseif context.end_of_round and not context.game_over and not context.blueprint then
			joker.ability.extra.spun = false
		end
		if not joker.ability.extra.active then return end
		local bonus = slot_data[joker.ability.extra.slots[3]]
		local ret = bonus.bonus(self, joker, context, joker.ability.extra.slot_vars[joker.ability.extra.slots[3]] * joker.ability.extra.active)
		if context.after and not context.blueprint then
			joker.ability.extra.active = nil
		end
		if ret then return ret end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{border_nodes = {
					{ref_table = "card.joker_display_values", ref_value = "symbol"},
					{ref_table = "card.joker_display_values", ref_value = "var", retrigger_type = "mult"}
				}},
				{text = " ", scale = 0.15},
				{ref_table = "card.joker_display_values", ref_value = "effect_text"},
			},
			reminder_text = {
				{text = "("},
				{ref_table = "card.joker_display_values", ref_value = "is_or_has"},
				{text = " "},
				{ref_table = "card.joker_display_values", ref_value = "hand_type", colour = G.C.FILTER},
				{text = " | "},
				{ref_table = "card.joker_display_values", ref_value = "card_type"},
				{text = ")"},
			},
			calc_function = function(joker)
				local temp = {}
				for i = 1, 3 do
					temp[i] = slot_data[joker.ability.extra.slots[i]]
				end
				local hand, card, bonus = unpack(temp)
				local var = joker.ability.extra.slot_vars[joker.ability.extra.slots[3]] * (hand == card and card == bonus and joker.ability.extra.triple_bonus or 1)
				local plural = bonus.pluralize and var > 1 and "s" or ""
				local label = card.card.seal and card.card.seal:lower().."_seal" or card.card.edition:sub(3)
				if label == "holo" then label = "holographic" end
				joker.joker_display_values.symbol = bonus.symbol or "+"
				joker.joker_display_values.var = var
				joker.joker_display_values.effect_text = localize("k_dbbq_jd_slotreward"..plural..joker.ability.extra.slots[3])
				joker.joker_display_values.is_or_has = localize(hand.hand.is and "k_dbbq_is" or "k_dbbq_has")
				joker.joker_display_values.hand_type = hand.hand.jd_shorten and localize("k_dbbq_"..hand.hand.jd_shorten) or localize(hand.hand.is or hand.hand.contains, "poker_hands")
				joker.joker_display_values.card_type = card.card.jd_shorten and localize("k_dbbq_"..card.card.jd_shorten) or localize(label, "labels")
			end,
			style_function = function(joker, text, reminder_text)
				if text and text.children[1] and text.children[1].children[1] then
					local bonus = slot_data[joker.ability.extra.slots[3]]
					text.children[1].config.colour = bonus.colours[2] or G.C.CLEAR
					text.children[1].children[1].config.colour = bonus.colours[1]
					text.children[1].children[2].config.colour = bonus.colours[1]
				end
				if reminder_text and reminder_text.children[6] then
					local card = slot_data[joker.ability.extra.slots[2]]
					reminder_text.children[6].config.colour = card.card.seal and G.C.FILTER or G.C.DARK_EDITION
				end
			end,
			retrigger_joker_function = function(retrigger_joker, joker)
				if joker ~= retrigger_joker and joker.ability.extra.slots[3] == 3 then
					for _, area in ipairs(SMODS.get_card_areas("jokers")) do
						local found = false
						for _, other in ipairs(area.cards) do
							if found then
								if other == retrigger_joker then
									local temp = {}
									for i = 1, 3 do
										temp[i] = slot_data[joker.ability.extra.slots[i]]
									end
									local hand, card, bonus = unpack(temp)
									return joker.ability.extra.slot_vars[joker.ability.extra.slots[3]] * (hand == card and card == bonus and joker.ability.extra.triple_bonus or 1)
								else
									return
								end
							elseif retrigger_joker == other then
								return
							end
							if other == joker then
								found = true
							end
						end
						if found then return end
					end
				end
			end
		}
	end,
	dbbq_spin = function(self, joker, collection)
		joker.ability.extra.slots = {}
		if not collection then
			local pool = {0, 1, 2, 3, 4, 5, 6}
			joker.ability.extra.slots[1] = table.remove(pool, pseudorandom("j_dbbq_slots", 1, 7))
			if pseudorandom("j_dbbq_slots", 1, 3) == 1 then
				joker.ability.extra.slots[2] = joker.ability.extra.slots[1]
				local only_win = pseudorandom("j_dbbq_slots", 1, 100)
				if only_win == 1 then
					joker.ability.extra.slots[3] = joker.ability.extra.slots[1]
				end
			else
				joker.ability.extra.slots[2] = table.remove(pool, pseudorandom("j_dbbq_slots", 1, #pool))
				if pseudorandom("j_dbbq_slots", 1, 3) == 1 then
					joker.ability.extra.slots[3] = joker.ability.extra.slots[pseudorandom("j_dbbq_slots", 1, 2)]
				end
			end
			if not joker.ability.extra.slots[3] then
				joker.ability.extra.slots[3] = table.remove(pool, pseudorandom("j_dbbq_slots", 1, #pool))
			end
		end
		for i = 1, 3 do
			if collection then
				joker.ability.extra.slots[i] = math.random(0, 6)
			end
			joker.dbbq_slot_fronts[i]:set_sprite_pos({x = joker.ability.extra.slots[i], y = i})
		end
	end
}

SMODS.DrawStep({
	key = "slotmachine_animation_layers",
	order = -5,
	func = function(joker, layer)
		if not joker.config or not joker.config.center or joker.config.center.key ~= "j_dbbq_slots" or (not joker.config.center.discovered and not joker.bypass_discovery_center) then return end
		if not joker.dbbq_ring_fronts then create_fronts(joker.config.center, joker) end
		local data = ring_data[joker.ability.extra.ring_frame]
		if data then
		for a, b in ipairs(data) do
				if b ~= 0 then
					joker.dbbq_ring_fronts[a]:set_sprite_pos({x = a + (b-1) * 4, y = 0})
					joker.dbbq_ring_fronts[a]:draw_shader("dissolve", nil, nil, nil, joker.children.center)
				end
			end
		end
		if joker.ability.extra.spinning then
			joker.dbbq_slot_fronts[1]:set_sprite_pos({x = joker.ability.extra.spin_frame % 8, y = 4 + math.floor(joker.ability.extra.spin_frame/8)})
			joker.dbbq_slot_fronts[1]:draw_shader("dissolve", nil, nil, nil, joker.children.center)
		else
			for _, sprite in ipairs(joker.dbbq_slot_fronts) do
				sprite:draw_shader("dissolve", nil, nil, nil, joker.children.center)
			end
		end
	end,
	conditions = {vortex = false, facing = "front"}
})

local function spin_slots_button(joker)
	return UIBox {
		config = {
			align = "cl", padding = 0.15, major = joker, parent = joker, offset = {x = 0.25, y = -0.05}
		},
		definition = {
			n = G.UIT.ROOT,
			config = {colour = G.C.CLEAR},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cl", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.ORANGE,
						button = "dbbq_spin_slots",
						func = "dbbq_spin_slots_can_press",
						ref_table = joker,
					},
					nodes = {
						{n = G.UIT.B, config = {w = 0.1, h = 0.6}},
						{
							n = G.UIT.C, config = {align = "tm", maxw = 1.25},
							nodes = {
								{
									n = G.UIT.R, config = {align = "cm", maxw = 1.25},
									nodes = {{n = G.UIT.T, config = {text = localize("k_dbbq_spin"), colour = G.C.UI.TEXT_LIGHT, scale = 0.4}}}
								},
								{
									n = G.UIT.R,
									config = {align = "cm"},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("$"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
											}
										},
										{
											n = G.UIT.T,
											config = {
												ref_table = joker.ability.extra,
												ref_value = "spin_cost",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.55,
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
end

G.FUNCS.dbbq_spin_slots_can_press = function(e)
	local jae = e.config.ref_table.ability.extra
	if not jae.spun and G.GAME.dollars - G.GAME.bankrupt_at - jae.spin_cost >= 0 then
		e.config.button = "dbbq_spin_slots"
		e.config.colour = G.C.ORANGE
	else
		e.config.button = nil
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end

G.FUNCS.dbbq_spin_slots = function(e)
	local joker = e.config.ref_table
	joker.ability.extra.spinning = true
	joker.ability.extra.spun = true
	ease_dollars(-joker.ability.extra.spin_cost)
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 4,
		func = function()
			joker.ability.extra.spinning = false
			joker.config.center:dbbq_spin(joker)
			return true
		end
	}))
end

local old_card_highlight = Card.highlight
function Card:highlight(is_highlighted)
	if is_highlighted and self.added_to_deck and self.config and self.config.center and self.config.center.key == "j_dbbq_slots" and not self.debuff then
		self.children.j_dbbq_slots_button = spin_slots_button(self)
	elseif self.children.j_dbbq_slots_button then
		self.children.j_dbbq_slots_button:remove()
		self.children.j_dbbq_slots_button = nil
	end

	return old_card_highlight(self, is_highlighted)
end

SMODS.DrawStep {
  key = "dbbq_button_spin_slots",
  order = -30, --before the Card is drawn
  func = function(card, layer)
    if card.children.j_dbbq_slots_button then
      card.children.j_dbbq_slots_button:draw()
    end
  end
}
SMODS.draw_ignore_keys.j_dbbq_slots_button = true
