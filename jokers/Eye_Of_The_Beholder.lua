--[[
Eye Of The Beholder
Rare, $8

Each time you play and score one of
each (Vanilla) Rank, gain X1 Mult
(Remaining: 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A)
(Currently: X1 Mult)
--]]

local a, b, c, d, e, f, g, h, i, j = 1, 1.2, 1.4, 1.6, 1.8, 2, 2.2, 2.4, 2.6, 2.8, 3
local pitch_map = {
	dbbq_beholder_food = {e, f, g, k, j, i, i, g, g, c, c, f, d},
	dbbq_beholder_toilet = {
		e, e, e, e, e, e, g, i, f,
		e, e, e, e, e, h, g, f, e,
		f, e, f, e, e, d, d,
		c, c, c, a, b
	},
	dbbq_beholder_unforgiven = {
		e, c, d, e, e, g, f, e, f,
		c, c, c, c, c, c, a, a
	},
	dbbq_beholder_capable = {
		e, e, e, e, e, e,
		e, e, e, e, c, c, c, d
	},
	dbbq_beholder_punishment = {
		f, f, f, f, f, f, f,
		h, g, f, f, f, h, h, g,
		e, d, d, e,
		a, a, a, a, a
	},
}

local key = "beholder"
DBBQ.quip_function[key] = function(self, times)
	if pitch_map[self.key] then
		play_sound("voice"..math.random(1, 11), pitch_map[self.key][1 + #pitch_map[self.key] - times])
	else
		play_sound("voice"..math.random(1, 11), 0.8)
	end
end
DBBQ.quip_colours[key] = {HEX("6c0848"), HEX("6e3215"), HEX("000000")}
DBBQ.quip_speed[key] = 0.25
DBBQ.add_quip(key, "condolences", "loss", 9, 0.15)
DBBQ.add_quip(key, "never", "loss", 13, 0.15)
DBBQ.add_quip(key, "food", "any", 13, 0.2)
DBBQ.add_quip(key, "toilet", "win", 30)
DBBQ.add_quip(key, "unforgiven", "loss", 17)
DBBQ.add_quip(key, "capable", "loss", 14)
DBBQ.add_quip(key, "punishment", "loss", 24)

local VANILLA_RANKS = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'}

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 3,
	cost = 8,
	pos = {x = 3, y = 0},
	blueprint_compat = true,
	pronouns = "she_her",
	config = {extra = {Xmult_gain = 1, played = {}, Xmult = 1}},
	loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_beholder", set = "Other"}
		end
		local remaining = ""
		for _, rank in ipairs(VANILLA_RANKS) do
			if not card.ability.extra.played[rank] then
				if remaining:len() == 0 then
					remaining = rank
				else
					remaining = remaining..", "..rank
				end
			end
		end
		return {vars = {card.ability.extra.Xmult_gain, remaining, card.ability.extra.Xmult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		elseif context.before and context.main_eval and not context.blueprint then
			for _, play in ipairs(context.scoring_hand) do
				local id = play:get_id()
				if id >= 2 and id <= 14 and not SMODS.has_no_rank(play) then
					if id == 11 then id = 'J'
					elseif id == 12 then id = 'Q'
					elseif id == 13 then id = 'K'
					elseif id == 14 then id = 'A'
					else id = tostring(id)
					end
					card.ability.extra.played[id] = true
				end
			end
			for _, rank in ipairs(VANILLA_RANKS) do
				if not card.ability.extra.played[rank] then
					return
				end
			end
			card.ability.extra.played = {}
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "Xmult",
				scalar_value = "Xmult_gain"
			})
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {
				{border_nodes = {
					{text = "X"},
					{ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp"}
				}}
			},
			extra = {
				{{ref_table = "card.joker_display_values", ref_value = "remaining1", scale = 0.3}},
				{{ref_table = "card.joker_display_values", ref_value = "remaining2", scale = 0.3}}
			},
			calc_function = function(card)
				local remaining = {"", ""}
				local i = 1
				local count = 0
				for _, rank in ipairs(VANILLA_RANKS) do
					if not card.ability.extra.played[rank] then
						count = count + 1
						if count == 8 then
							i = 2
						end
						if remaining[i]:len() == 0 then
							remaining[i] = rank
						else
							remaining[i] = remaining[i]..", "..rank
						end
					end
				end
				card.joker_display_values.remaining1 = remaining[1].."\n"
				card.joker_display_values.remaining2 = remaining[2].."\n"
				card.joker_display_values.xmult = card.ability.extra.Xmult
			end
		}
	end
}
