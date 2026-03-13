local old_game_update = Game.update
function Game:update(dt)
	local ret = old_game_update(self, dt)

	for suit, anim in pairs(DBBQ.suits) do
		anim.timer = anim.timer + dt
		if anim.timer >= anim.delay then
			anim.timer = anim.timer - anim.delay
			anim.frame = anim.frame + 1
			if anim.frame > #anim.frames then
				anim.frame = 1
			end
		end
	end

	return ret
end

local old_card_update = Card.update
function Card:update(dt)
	local ret = old_card_update(self, dt)

	local suit = self.base.suit
	local anim = DBBQ.suits[self.base.suit]
	if not SMODS.has_no_suit(self) and anim and type(self.base.id) == "number" then
		self.children.front:set_sprite_pos({x = self.base.id - 2, y = anim.frames[anim.frame]})
	end

	return ret
end

local old_generate_ui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
	local fut = old_generate_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)

	if card and card.base and not SMODS.has_no_suit(card) and DBBQ.suits[card.base.suit] and not card.debuff then
		local vars = {}
		if DBBQ.suits[card.base.suit].loc_vars then
			vars = DBBQ.suits[card.base.suit].loc_vars(card)
		end
		vars.key = card.base.suit
		vars.type = "other"
		vars.nodes = fut.main
		vars.vars = vars.vars or {}
		localize(vars)
	end

	return fut
end
