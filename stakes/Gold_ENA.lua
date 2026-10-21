SMODS.Stake {
	key = "gold_ena",
	applied_stakes = {"gold", "dbbq_bbq"},
	prefix_config = {applied_stakes = {mod = false}},
	above_stake = "dbbq_bbq",
	atlas = "dbbq_stakes",
	pos = {x = 5, y = 0},
	sticker_atlas = "dbbq_stickers",
	sticker_pos = {x = 4, y = 0},
	colour = HEX("c79000"),
	shiny = true
}
--[[
local old_stake_sprite = get_stake_sprite
function get_stake_sprite(_stake, _scale)
	local sprite = old_stake_sprite(_stake, _scale)
	if G.P_CENTER_POOLS.Stake[_stake].key == "stake_dbbq_gold_ena" then
		sprite.draw = function(_sprite)
			_sprite.ARGS.send_to_shader = _sprite.ARGS.send_to_shader or {}
			_sprite.ARGS.send_to_shader[1] = math.min(_sprite.VT.r*3, 1) + G.TIMERS.REAL/(18) + (_sprite.juice and _sprite.juice.r*20 or 0) + 1
			_sprite.ARGS.send_to_shader[2] = G.TIMERS.REAL

			Sprite.draw_shader(_sprite, 'dissolve')
			Sprite.draw_shader(_sprite, 'voucher', nil, _sprite.ARGS.send_to_shader)
		end
	end
	return sprite
end--]]
