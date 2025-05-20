SMODS.Atlas {
    key = 'big_bang',
    path = "j_big_bang.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "big_bang",
    name = "Big Bang",
    atlas = 'big_bang',
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
            Xmult = 0.1, 
            joker1 = "j_supernova", 
            joker2 = "j_constellation"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_name then
			local mult_val = 1 + card.ability.extra.Xmult * (G.GAME.hands[context.scoring_name].level + G.GAME.hands[context.scoring_name].played)
			return {
				message = localize{type='variable',key='a_xmult',vars={mult_val}},
                Xmult_mod = mult_val
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
                    }
                }
            },
            calc_function = function(card)
                local text, _, _ = JokerDisplay.evaluate_hand()
                card.joker_display_values.Xmult = 1 + card.ability.extra.Xmult * ((text ~= 'Unknown' and G.GAME and G.GAME.hands[text] and G.GAME.hands[text].level + G.GAME.hands[text].played + (next(G.play.cards) and 0 or 1)) or
                0)
            end
        }
    end
}

-- See localization/en-us.lua to create joker text