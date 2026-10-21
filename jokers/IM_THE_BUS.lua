--[[
I'M THE BUS
Legendary, $20

Each played card scores X1 Mult
Add X0.05 to amount for each
consecutive hand played
without a scoring face card
--]]

local key = "bus"
DBBQ.quip_colours[key] = {HEX("e9e0d2"), HEX("0f110e")}
DBBQ.quip_sound[key] = DBBQ.sound_range(key, 11)
DBBQ.quip_pitch[key] = 1
DBBQ.add_quip(key, "im_the_bus", "any", 1)

SMODS.Joker{
	key = key,
	atlas = "dbbq_bus",
	rarity = 4,
	cost = 20,
	pos = {x = 0, y = 0},
	blueprint_compat = true,
	pronouns = "bus_bus",
	config = {extra = {Xmult = 1, Xmult_gain = 0.05, timer = 0, frame = 0, anim = false}},
	update = function(self, joker, dt)
		if not joker.ability.extra.anim then return end
		if joker.ability.extra.timer < 3 then
			joker.ability.extra.timer = joker.ability.extra.timer + 1
		else
			joker.ability.extra.timer = 0
			joker.ability.extra.frame = joker.ability.extra.frame + 1
			if joker.ability.extra.frame >= 65 then
				joker.ability.extra.frame = 0
				joker.ability.extra.anim = false
			end
			joker.children.center:set_sprite_pos({
				x = joker.ability.extra.frame % 13,
				y = math.floor(joker.ability.extra.frame / 13)
			})
		end
	end,
	loc_vars = function(self, info_queue, joker)
		if joker.area and joker.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_bus", set = "Other"}
		end
		return {vars = {joker.ability.extra.Xmult, joker.ability.extra.Xmult_gain}}
	end,
	calculate = function(self, joker, context)
		if context.before and context.main_eval and not context.blueprint then
			local faces = false
			for _, card in ipairs(context.scoring_hand) do
				if card:is_face() then
					faces = true
					break
				end
			end
			if not faces then
				SMODS.scale_card(joker, {
					ref_table = joker.ability.extra,
					ref_value = "Xmult",
					scalar_value = "Xmult_gain"
				})
				if not joker.ability.extra.anim then
					return {func = function()
						joker.ability.extra.anim = true
						play_sound("dbbq_bus"..math.ceil(pseudorandom("I'M THE BUS!") * 11))
					end}
				end
			elseif joker.ability.extra.Xmult ~= 1 then
				joker.ability.extra.Xmult = 1
				return {
					message = localize("k_reset"),
					colour = G.C.PURPLE
				}
			end
		elseif context.individual and context.cardarea == G.play and joker.ability.extra.Xmult ~= 1 then
			return {Xmult = joker.ability.extra.Xmult}
		end
	end,
	joker_display_def = function(jd)
		return {
			text = {{border_nodes = {
				{text = "X"},
				{ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp"}
			}}},
			calc_function = function(card)
				local count = 0
				local base = card.ability.extra.Xmult
				local increase = #G.play.cards == 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= "Unknown" then
					for _, scoring_card in pairs(scoring_hand) do
						if scoring_card:is_face() then
							card.joker_display_values.xmult = 1
							return
						else
							count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
						end
					end
				else
					count = 1
					increase = false
				end
				if increase then
					base = base + card.ability.extra.Xmult_gain
				end
				card.joker_display_values.xmult = base ^ count
			end
		}
	end
}

if next(SMODS.find_mod("cardpronouns")) then
	CardPronouns.Pronoun {
		colour = HEX("888888"),
		text_colour = G.C.WHITE,
		pronoun_table = { "Bus", "Bus" },
		in_pool = function()
		    return false
		end,
		key = "bus_bus"
	}
end
