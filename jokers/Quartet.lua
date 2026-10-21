--[[
Quartet
Uncommon, $4

When Hand is played:
Gain +4 Mult if you
have exactly 4 Jokers
Resets otherwise
(Currently +0 Mult)
--]]

local key = "quartet"
local pitch_gold = 2.25
local pitch_green = 0.4
local pitch_red = 1.8
local pitch_purple = 2.75
DBBQ.quip_function[key] = function(self, times)
	if self.key == "dbbq_"..key.."_delightful" then
		if times > 11 then
			play_sound("voice"..math.random(1, 11), pitch_purple)
		elseif times > 4 then
			play_sound("voice"..math.random(1, 11), pitch_gold)
		else
			play_sound("voice"..math.random(1, 11), pitch_red)
		end
	elseif self.key == "dbbq_"..key.."_reference" then
		if times > 22 then
			play_sound("voice"..math.random(1, 11), pitch_gold)
		elseif times > 13 then
			play_sound("voice"..math.random(1, 11), pitch_green)
		else
			play_sound("voice"..math.random(1, 11), pitch_red)
		end
	else
		if times > 53 then
			play_sound("voice"..math.random(1, 11), pitch_green)
		elseif times > 42 then
			play_sound("voice"..math.random(1, 11), pitch_gold)
		else
			play_sound("voice"..math.random(1, 11), pitch_red)
		end
	end
end
DBBQ.quip_colours[key] = {HEX("3e0c4f"), HEX("f72c1a"), HEX("144f0c")}
DBBQ.quip_pitch[key] = 1.2
DBBQ.add_quip(key, "delightful", "win", 18)
DBBQ.add_quip(key, "reference", "any", 35)
DBBQ.add_quip(key, "fault", "loss", 69)

SMODS.Joker{
	key = key,
	atlas = "dbbq_jokers",
	rarity = 2,
	cost = 4,
	pos = {x = 1, y = 3},
	blueprint_compat = true,
	pronouns = "they_them",
    config = {extra = {mult_gain = 4, mult = 0, jokers = 4}},
    loc_vars = function(self, info_queue, card)
		if card.area and card.area.config.collection then
			info_queue[#info_queue + 1] = {key = "j_dbbq_source_quartet", set = "Other"}
		end
        return {vars = {
			card.ability.extra.mult_gain,
			card.ability.extra.mult,
			card.ability.extra.jokers
		}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		elseif context.before and not context.blueprint then
			if DBBQ.count_jokers() == card.ability.extra.jokers then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "mult_gain"
				})
			elseif card.ability.extra.mult > 0 then
				card.ability.extra.mult = 0
				return {
		            message = localize("k_reset"),
		            colour = G.C.RED
		        }
			end
		end
    end,
	joker_display_def = function(jd)
		return {
			text = {
				{text = "+"},
				{ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult"}
			},
			text_config = {colour = G.C.MULT}
		}
	end
}
