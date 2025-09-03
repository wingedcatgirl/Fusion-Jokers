SMODS.Atlas {
    key = 'flag_bearer',
    path = "j_flag_bearer.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "flag_bearer",
    name = "Flag Bearer",
    atlas = 'flag_bearer',
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
            hand_add = 1,
            discard_sub = 1, 
            mult = 0,
            joker1 = "j_banner", 
            joker2 = "j_green_joker"
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_add,
                card.ability.extra.discard_sub,
                card.ability.extra.mult * (G.GAME.current_round.discards_left or 0),
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
            }
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3, blocking = false,
        func = function()
            if card.ability.mult and (card.ability.extra.mult == 0) then
                card.ability.extra.mult = card.ability.mult or 0
                card.ability.mult = nil
            end
        return true
        end}))
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and context.other_card == context.full_hand[#context.full_hand] then
			local prev_mult = card.ability.extra.mult
			card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.discard_sub)
			if card.ability.extra.mult ~= prev_mult then
				return {
					message = localize{type='variable',key='a_mult_minus',vars={card.ability.extra.discard_sub}},
					colour = G.C.RED,
					card = card
				}
			end
		end

		if context.cardarea == G.jokers and context.before then
			if not context.blueprint then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.hand_add
				return {
					card = card,
					message = localize{type='variable',key='a_mult',vars={card.ability.extra.hand_add}}
				}
			end
		end

		if context.cardarea == G.jokers and context.joker_main then
			local mult = card.ability.extra.mult * G.GAME.current_round.discards_left
			return {
				message = localize{type='variable',key='a_mult',vars={mult}},
				mult_mod = mult
			}
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
            },
            text_config = { colour = G.C.MULT },
            calc_function = function(card)
                card.joker_display_values.mult = card.ability.extra.mult * G.GAME.current_round.discards_left
            end
        }
    end
}

-- See localization/en-us.lua to create joker text