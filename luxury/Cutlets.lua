--[[
Cutlets
Luxury, $8

Up to 3 selected cards will
be torn into two Half Cards
--]]

--[[
Half Card

Fills 0.5 hand space
--]]

DBBQ.Luxury{
	key = "cutlets",
	soul_pos = {x = 0, y = 2},
	config = {extra = {cards = 3, used = false}},
	dbbq_sort_selected = true,
	loc_vars = function(self, info_queue, item)
		info_queue[#info_queue+1] = {set = "Other", key = "dbbq_half_card"}
		return {vars = {item.ability.extra.cards}}
	end,
	luxury_can_use = function(self, item)
		if #G.hand.highlighted == 0 or #G.hand.highlighted > item.ability.extra.cards then
			return false
		end
		for _, card in ipairs(G.hand.highlighted) do
			if card.ability.dbbq_half then
				return false
			end
		end
		return true
	end,
	luxury_use = function(self, item, area)
		for i, card in ipairs(G.hand.highlighted) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					card:juice_up()
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					local pos = pseudorandom("c_dbbq_cutlets", 1, 4)
					play_sound("dbbq_rip_paper")
					card.ability.extra_slots_used = ((card.ability.extra_slots_used or 0) + 1) / 2 - 1
					card.ability.dbbq_half = {side = "left", pos = pos}
					local copy = SMODS.copy_card(card)
					copy.ability.dbbq_half = {side = "right", pos = pos}
					copy.T.x = card.T.x + 0.01
					table.sort(G.hand.cards, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			func = function()
				G.hand:unhighlight_all()
				return true
			end
		}))
	end,
	luxury_start_juice_context = function(self, item, context)
		return context.first_hand_drawn or (context.open_booster and context.card.config.center.draw_hand)
	end,
}

-- This is defined here, and not in assets/shaders, because SMODS.Shaders
-- hard require the use of a bunch of extra variables that are only
-- actually relevant if you're making regular shader that does color stuff 
local mask_shader = love.graphics.newShader[[
#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define MY_HIGHP_OR_MEDIUMP highp
#else
	#define MY_HIGHP_OR_MEDIUMP mediump
#endif

#ifdef VERTEX
// In a shader, pixels can only be discarded before the VERTEX stage
// The VERTEX stage is still required, though, to account for card tilting
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	return vec4(1.0);
}
#else
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
		discard;
	}
	return vec4(1.0);
}
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif
]]

local shared_halves = {left = {}, right = {}}
local function sprite(pos)
	local sprites = {}
	for i = 1, 4 do
		sprites[i] = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["dbbq_halves"], {x = pos.x+(i-1)*2, y = pos.y})
	end
	return sprites
end
G.E_MANAGER:add_event(Event({
	func = function()
		shared_halves.left.front = sprite({x = 0, y = 0})
		shared_halves.left.back = sprite({x = 0, y = 1})
		shared_halves.right.front = sprite({x = 1, y = 0})
		shared_halves.right.back = sprite({x = 1, y = 1})
		return true
	end
}))

local card_cache = nil
local function stencilHalf()
	local mask = shared_halves[card_cache.ability.dbbq_half.side][card_cache.sprite_facing][card_cache.ability.dbbq_half.pos]
	mask.role.draw_major = card_cache
	mask.ARGS.prep_shader = mask.ARGS.prep_shader or {}
    mask.ARGS.prep_shader.cursor_pos = mask.ARGS.prep_shader.cursor_pos or {}
    mask.ARGS.prep_shader.cursor_pos[1] = card_cache.tilt_var and card_cache.tilt_var.mx*G.CANV_SCALE or G.CONTROLLER.cursor_position.x*G.CANV_SCALE
    mask.ARGS.prep_shader.cursor_pos[2] = card_cache.tilt_var and card_cache.tilt_var.my*G.CANV_SCALE or G.CONTROLLER.cursor_position.y*G.CANV_SCALE
	mask_shader:send('mouse_screen_pos', mask.ARGS.prep_shader.cursor_pos)
    mask_shader:send('screen_scale', G.TILESCALE*G.TILESIZE*(card_cache.mouse_damping or 1)*G.CANV_SCALE)
    mask_shader:send('hovering', card_cache.hover_tilt or 0)
	love.graphics.setShader(mask_shader)
    mask:draw_from(card_cache.children.center)
	love.graphics.setShader()
end

-- Could this be done in a proper DrawStep? Maybe.
-- I barely got this to work as-is, and it's fully functional,
-- so I'm not touching it further.
local old_card_draw = Card.draw
function Card:draw(layer)
	if not self.ability or not self.ability.dbbq_half then
		old_card_draw(self, layer)
		return
	end
	card_cache = self
	love.graphics.stencil(stencilHalf, "replace", 1)
	love.graphics.setStencilTest("greater", 0)
	old_card_draw(self, layer)
	love.graphics.setStencilTest()
end
