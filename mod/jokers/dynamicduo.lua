SMODS.Atlas {
    key = 'dynamic_duo',
    path = "j_dynamic_duo.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "dynamic_duo",
    name = "Dynamic Duo",
    atlas = 'dynamic_duo',
    pos = {
        x = 0,
        y = 0
    },
    rarity = "fuse_fusion",
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = {
            mult = 4,
            chips = 31,
            joker1 = "j_even_steven",
            joker2 = "j_odd_todd"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
		not context.other_card:is_face() and not SMODS.has_no_rank(context.other_card) then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
				card = card
			}
		end
    end
}

-- See localization/en-us.lua to create joker text