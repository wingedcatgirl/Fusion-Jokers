SMODS.Atlas {
    key = 'commercial_driver',
    path = "j_commercial_driver.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "commercial_driver",
    name = "Commercial Driver",
    atlas = 'commercial_driver',
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
            bonus = 0.25, 
            total = 1, 
            joker1 = "j_ride_the_bus", 
            joker2 = "j_drivers_license"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.bonus, 
                card.ability.extra.total,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
			local enhanced = false
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].config.center ~= G.P_CENTERS.c_base then enhanced = true end
			end
			if not enhanced then
				local last_mult = card.ability.extra.total
				card.ability.extra.total = 1
				if last_mult > 0 then
					return {
						card = card,
						message = localize('k_reset')
					}
				end
			else
				card.ability.extra.total = card.ability.extra.total + card.ability.extra.bonus
			end
		end

		if context.cardarea == G.jokers and context.joker_main then
			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.total}},
				Xmult_mod = card.ability.extra.total
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.ability.extra", ref_value = "total" }
                    }
                }
            }
        }
    end
}

-- See localization/en-us.lua to create joker text