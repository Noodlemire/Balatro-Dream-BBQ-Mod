DBBQ = {}

SMODS.current_mod.optional_features = function()
	return {
		post_trigger = true,
		cardareas = {
			discard = true,
			deck = true
		}
	}
end

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
	key = "dbbq_sleeves",
	path = "Sleeves.png",
	px = 73,
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
	px = 73,
	py = 95,
}

local items = {"jokers", "decks", "challenges"}
if next(SMODS.find_mod("CardSleeves")) then
	table.insert(items, "sleeves")
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
				eligible_quotes[#eligible_quotes+1] = quote
			end
		end
		if #eligible_quotes > 0 then
			args.center = joker.config.center.key
			next_quote = pseudorandom_element(eligible_quotes, "WHERE THE HELL IS THE BOSS?!").key
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
