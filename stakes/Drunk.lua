local rarity_table = {"Common", "Uncommon", "Rare"}

SMODS.Stake {
	key = "drunk",
	applied_stakes = {"dbbq_moody"},
	above_stake = "dbbq_moody",
	atlas = "dbbq_stakes",
	pos = {x = 2, y = 0},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 2, y = 1},
	colour = HEX("c7bb2b"),
	modifiers = function()
		G.GAME.modifiers.enable_dbbq_drunk = true
	end
}

SMODS.Sticker {
	key = "drunk",
	atlas = "dbbq_stickers",
	pos = {x = 1, y = 0},
	default_compat = true,
	sets = {Joker = true},
	rate = 0.3,
	needs_enable_flag = true,
	badge_colour = G.C.UI.TEXT_DARK,
	text_colour = HEX("a27a00"),
	config = {odds = 4},
	loc_vars = function(self, info_queue, joker)
		local ret = {vars = {SMODS.get_probability_vars(joker, 1, joker.ability.dbbq_drunk.odds)}}
		if joker.config.center.rarity == 1 then
			ret.key = self.key.."_common"
		end
		return ret
	end,
	should_apply = function(self, joker, center, area, bypass_roll)
		if area == G.jokers then return false end
		return SMODS.Sticker.should_apply(self, joker, center, area, bypass_roll)
	end,
	calculate = function(self, joker, context)
		if context.end_of_round and context.main_eval and not context.game_over and SMODS.pseudorandom_probability(joker, "What are yOOUUU even sAYing?", 1, joker.ability.dbbq_drunk.odds) then
			local rarity = joker.config.center.rarity
			if type(rarity) == "number" then
				rarity = math.max(1, rarity - 1)
			else
				local base_cost = joker.config.center.cost
				if base_cost >= 10 then
					rarity = 3
				elseif base_cost >= 7 then
					rarity = 2
				else
					rarity = 1
				end
			end
			local key = SMODS.poll_object({
				type = "Joker",
				rarities = {rarity_table[rarity]},
				seed = "dbbq_drunk_joker_pool_"..rarity
			})
			if key then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						joker:flip()
						play_sound('card1', 0.85)
						joker:juice_up(0.3, 0.3)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						joker:set_ability(key)
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						joker:flip()
						play_sound('tarot2', 0.85, 0.6)
						joker:juice_up(0.3, 0.3)
						return true
					end
				}))
			end
		end
	end
}
