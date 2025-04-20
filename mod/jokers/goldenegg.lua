SMODS.Atlas {
    key = 'golden_egg',
    path = "j_golden_egg.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "golden_egg",
    name = "Golden Egg",
    atlas = 'golden_egg',
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
            dollars = 4,
            joker1 = "j_egg",
            joker2 = "j_golden"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card:set_cost()
    end,
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.dollars
			card:set_cost()
			return {
				message = localize('k_val_up'),
				colour = G.C.MONEY
			}
		end
    end
}

-- See localization/en-us.lua to create joker text