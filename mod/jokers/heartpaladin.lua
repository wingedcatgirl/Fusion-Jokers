SMODS.Atlas {
    key = 'heart_paladin',
    path = "j_heart_paladin.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "heart_paladin",
    name = "Heart Paladin",
    atlas = 'heart_paladin',
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
            odds = 3,
            Xmult = 1.5,
            joker1 = "j_lusty_joker",
            joker2 = "j_bloodstone"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                ''..(G.GAME and G.GAME.probabilities.normal or 1), 
                card.ability.extra.odds,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
		context.other_card:is_suit('Hearts') then
			return {
				x_mult = card.ability.extra.Xmult,
				card = card
			}
		end

		if context.repetition and context.cardarea == G.play and
		context.other_card:is_suit('Hearts') then
			if pseudorandom('heart_paladin') < G.GAME.probabilities.normal/card.ability.extra.odds then
				return {
					message = localize('k_again_ex'),
					repetitions = 1,
					card = card
				}
			end
		end
    end
}

-- See localization/en-us.lua to create joker text