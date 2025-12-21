SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {minw=1, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15}, nodes = {
        create_toggle({
            label = "Block used components from reappearing",
            ref_table = FusionJokers.fusionconfig,
            ref_value = 'block_components',
        }),
        create_toggle({
            label = "Alt art for Club Wizard",
            ref_table = FusionJokers.fusionconfig,
            ref_value = 'cw_alt_art',
        }),
        }}
    }}
end