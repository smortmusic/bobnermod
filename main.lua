--#region Atlases

SMODS.Atlas {
    key = 'bobnerholders',
    path = 'bobnerholders.png',
    px = 71,
    py = 95
}

--#region File Loading

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

--#endregion

SMODS.Sound({
    key = 'bass_shatter',
    path = 'bass_shatter.ogg'
})