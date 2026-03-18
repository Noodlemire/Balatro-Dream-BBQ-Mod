DBBQ = {suits = {}}

local items = {"jokers", "decks", "challenges", "suits"}

SMODS.current_mod.optional_features = function()
	return {
		post_trigger = true,
		cardareas = {
			discard = true,
			deck = true
		}
	}
end

SMODS.Atlas{
	key = "modicon",
	path = "icon.png",
	px = 33,
	py = 33
}

SMODS.Atlas {
	key = "dbbq_jokers",
	path = "Jokers.png",
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
	key = "dbbq_bus",
	path = "j_dbbq_bus.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "dbbq_seals",
	path = "Seals.png",
	px = 71,
	py = 95,
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

if next(SMODS.find_mod("SealsOnEverything")) then
	DBBQ.shared_jokerfronts = {}

	SMODS.Atlas {
		key = "dbbq_jokers_front",
		path = "JokersFront.png",
		px = 71,
		py = 95,
	}

	SMODS.DrawStep{
		key = "jokers_front",
		order = 10,
		conditions = {facing = "front"},
		func = function(card, layer)
			if not card.config.center.original_mod or card.config.center.original_mod.id ~= "DreamBBQ" or (card.ability.extra and card.ability.extra.no_front) then return end
			if card.ability.soe_legalenhancements and (card.ability.soe_legalenhancements.m_lucky or card.ability.soe_legalenhancements.m_gold or card.ability.soe_legalenhancements.m_steel or card.ability.soe_legalenhancements.m_glass) and DBBQ.shared_jokerfronts[card.config.center.key] then
				if not card.oldatlas or not card.oldpos then
					card.oldatlas = card.children.center.atlas
					card.oldpos =  card.children.center.sprite_pos
				end
				card.children.center.atlas = G.ASSET_ATLAS["soe_Enhancers"]
				local center
				for k, v in pairs(card.ability.soe_legalenhancements) do
					if k == 'm_lucky' or k == 'm_gold' or k == 'm_steel' or k == 'm_glass' then
						center = G.P_CENTERS[k]
						break
					end
				end
				card.children.center:set_sprite_pos(center.pos)
				DBBQ.shared_jokerfronts[card.config.center.key].role.draw_major = card
				DBBQ.shared_jokerfronts[card.config.center.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
			elseif card.oldatlas and card.oldpos then
				card.children.center.atlas = card.oldatlas
				card.children.center:set_sprite_pos(card.oldpos)
				card.oldatlas = nil
				card.oldpos = nil
			end
		end,
	}

	local oldmainmenu = Game.main_menu
	function Game:main_menu(change_context)
		local ret = oldmainmenu(self, change_context)
		for k, v in pairs(G.P_CENTER_POOLS.Joker) do
			if v.original_mod and v.original_mod.id == "DreamBBQ" then
				DBBQ.shared_jokerfronts[v.key] = Sprite(0, 0, 71, 95, G.ASSET_ATLAS.dbbq_jokers_front, v.pos or {x = 0, y = 0})
			end
		end
		return ret
	end
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

local next_quote = nil

local old_cc_init = Card_Character.init
function Card_Character:init(args)
	if not G.jokers then
		return old_cc_init(self, args)
	end
	local eligible_jokers = {}
	for _, joker in ipairs(G.jokers.cards) do
		if type(joker.ability.extra) == "table" and joker.ability.extra.dbbq_quotes then
			eligible_jokers[#eligible_jokers+1] = joker
		end
	end
	if (G.STATE == G.STATES.GAME_OVER or G.GAME.won) and #eligible_jokers > 0 then
		local joker = pseudorandom_element(eligible_jokers, "Hope you don't mind, but could you tell me-")
		local eligible_quotes = {}
		for _, quote in ipairs(joker.ability.extra.dbbq_quotes) do
			if (G.STATE == G.STATES.GAME_OVER and quote.type ~= "win") or (G.GAME.won and quote.type ~= "lose") then
				eligible_quotes[#eligible_quotes+1] = quote.key
			end
		end
		if #eligible_quotes > 0 then
			args.center = joker.config.center.key
			next_quote = pseudorandom_element(eligible_quotes, "WHERE THE HELL IS THE BOSS?!")
		end
	end
	old_cc_init(self, args)
end

local old_cc_add_speech_bubble = Card_Character.add_speech_bubble
function Card_Character:add_speech_bubble(text_key, align, loc_vars)
	if next_quote then
		text_key = next_quote
		next_quote = nil
	end
	old_cc_add_speech_bubble(self, text_key, align, loc_vars)
end
