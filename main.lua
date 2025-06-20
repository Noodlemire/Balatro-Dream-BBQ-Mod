SMODS.Atlas {
    key = "dbbq_jokers",
    path = "Jokers.png",
    px = 71,
    py = 95,
}

local jokers = NFS.getDirectoryItems(SMODS.current_mod.path.."jokers")
for _, filename in pairs(jokers) do
    if string.sub(filename, string.len(filename) - 3) == '.lua' then
        assert(SMODS.load_file("jokers/"..filename))()
    end
end
