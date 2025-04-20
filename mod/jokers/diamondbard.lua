SMODS.Atlas {
    key = 'diamond_bard',
    path = "j_diamond_bard.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "diamond_bard",
    name = "Diamond Bard",
    atlas = 'diamond_bard',
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
            money_threshold = 20,
            mult = 4,
            money = 1,
            joker1 = "j_greedy_joker",
            joker2 = "j_rough_gem",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
                card.ability.extra.mult,
                card.ability.extra.money_threshold,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Diamonds') then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + to_big(card.ability.extra.money)
			G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
			return {
				dollars = card.ability.extra.money,
				mult = card.ability.extra.mult * (1 + math.floor(to_number(G.GAME.dollars) / card.ability.extra.money_threshold)),
				card = card
			}
		end
    end
}

-- See localization/en-us.lua to create joker text