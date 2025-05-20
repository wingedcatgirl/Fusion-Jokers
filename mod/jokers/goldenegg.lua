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
    add_to_deck = function (self, card, from_debuff)
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
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+$" },
                { ref_table = "card.ability.extra", ref_value = "dollars" },
                { text = " /round" },
            },
            text_config = { colour = G.C.GOLD },
            reminder_text = {
                { ref_table = "card.joker_display_values", ref_value = "localized_text" },
            },
            calc_function = function(card)
                card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
            end,
            reminder_text = {
                { text = "(" },
                { text = "$",          colour = G.C.GOLD },
                { ref_table = "card", ref_value = "sell_cost", colour = G.C.GOLD },
                { text = " Sell Value", colour = G.C.GOLD },
                { text = ")" },
            },
            reminder_text_config = { scale = 0.35 }
        }
    end
}

-- See localization/en-us.lua to create joker text