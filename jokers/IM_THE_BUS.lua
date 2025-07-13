--[[
I'M THE BUS
Legendary, $20

Each played card scores X1 Mult
Add X0.05 to amount for each consecutive hand played without a scoring face card
--]]

SMODS.Joker{
	key = "bus",
	atlas = "dbbq_bus",
	rarity = 4,
	cost = 20,
	pos = {x = 0, y = 0},
	blueprint_compat = true,
	config = {extra = {Xmult = 1, Xmult_gain = 0.05, timer = 0, frame = 0, anim = false, dbbq_quotes = {
		{type = "any", key = "j_dbbq_im_the_bus"},
	}}},
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
				joker.ability.extra.Xmult = joker.ability.extra.Xmult + joker.ability.extra.Xmult_gain
				local output = {
					message = 'X'..joker.ability.extra.Xmult,
					colour = G.C.MULT
				}
				if not joker.ability.extra.anim then
					output.func = function()
						joker.ability.extra.anim = true
						play_sound("dbbq_bus"..math.ceil(pseudorandom("I'M THE BUS!") * 11))
					end
				end
				return output
			elseif joker.ability.extra.Xmult > 1 then
				joker.ability.extra.Xmult = 1
				return {
					message = localize("k_reset"),
					colour = G.C.PURPLE
				}
			end
		elseif context.individual and context.cardarea == G.play and joker.ability.extra.Xmult > 1 then
			return {Xmult = joker.ability.extra.Xmult}
		end
	end
}
