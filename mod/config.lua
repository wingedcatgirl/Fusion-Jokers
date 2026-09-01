local colorblind = G.SETTINGS.colourblind_option or false
local nomotion = G.SETTINGS.reduced_motion or false

return {
    ["block_components"] = true,
    ["cw_alt_art"] = colorblind,
    ["no_price_flicker"] = nomotion
}
