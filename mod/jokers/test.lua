FusionJokers.fusions:register_fusion{
    jokers = {
        { name = "j_joker", merge_stat = "mult" },
        { name = "j_joker", merge_stat = "mult" },
        { name = "j_joker", merge_stat = "mult" },
    },
    result_joker = "j_fuse_three_jimbos",
    merged_stat = "mult",
    cost = 2,
    requirement = function ()
        local dp = not not next(SMODS.find_mod("DebugPlus"))
        return dp
    end
}

SMODS.Atlas{
    key = "three",
    path = "j_fuse_three_jimbos.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "three_jimbos",
    loc_txt = {
        name = "Three Fucking Jimbos",
        text = {
            "{C:mult}+#1#{} Mult",
            "{C:inactive,s:0.8}hoLY shit"
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    no_collection = true,
    config = {
        extra = {
            mult = 69
        }
    },
    rarity = "fuse_fusion",
    atlas = "three",
    pos = {x=0,y=0},
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}