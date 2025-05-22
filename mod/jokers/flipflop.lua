SMODS.Atlas {
    key = 'flip_flop',
    path = "j_flip_flop.png",
    px = 71,
    py = 95
}

local flip = {
    x = 0,
    y = 0
}

local flop = {
    x = 1,
    y = 0
}

SMODS.Joker {
    key = "flip_flop",
    name = "Flip-Flop",
    atlas = "flip_flop",
    pos = flip,
    rarity = "fuse_fusion",
    cost = 12,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = {
            hands = 2,
            discards = 2,
            mult = 8,
            chips = 50,
            side = "mult",
            joker1 = "j_juggler",
            joker2 = "j_drunkard"
        }
    },
    loc_vars = function(self, info_queue, card)
        local result = {}
        if card.ability.extra.side == "mult" then
            result = {
                card.ability.extra.hands,
                card.ability.extra.mult,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
                }
        else
            result = {
                card.ability.extra.discards,
                card.ability.extra.chips,
                localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'},
                localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}
                }
        end

        return {
            key = self.key.."_"..card.ability.extra.side,
            vars = result
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local flipref = card.config.center
        if card.ability.extra.side == "mult" then
            flipref.pos = flip
            card:set_sprites(flipref)
        else
            flipref.pos = flop
            card:set_sprites(flipref)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.side == "mult" then
            G.hand:change_size(card.ability.extra.hands)
        else
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
            ease_discard(card.ability.extra.discards)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.side == "mult" then
            G.hand:change_size(-card.ability.extra.hands)
        else
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
            ease_discard(-card.ability.extra.discards)
        end
    end,
    calculate = function(self, card, context)
        local flipref = card.config.center
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			if card.ability.extra.side == "mult" then
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
					func = function()
						card.ability.extra.side = "chips"
						card:juice_up(1, 1)
						flipref.pos = flop
						card:set_sprites(flipref)

				return true; end}))

				G.hand:change_size(-card.ability.extra.hands)
				G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
				ease_discard(card.ability.extra.discards)

				return {
					message = localize('k_flipped_ex'),
					colour = G.C.CHIPS
				}
			else
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
					func = function()
						card.ability.extra.side = "mult"
						card:juice_up(1, 1)
						flipref.pos = flip
						card:set_sprites(flipref)

				return true; end}))

				G.hand:change_size(card.ability.extra.hands)
				G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
				ease_discard(-card.ability.extra.discards)

				return {
					message = localize('k_flipped_ex'),
					colour = G.C.MULT
				}
			end

		end

		if context.cardarea == G.jokers and context.joker_main then
			if card.ability.extra.side == "mult" then
				return {
					message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
					mult_mod = card.ability.extra.mult,
					colour = G.C.MULT
				}
			else
				return {
					message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
					chip_mod = card.ability.extra.chips,
					colour = G.C.CHIPS
				}
			end
		end
    end,
    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
            },
            calc_function = function(card)
                if card.ability.extra.side == "mult" then
                    card.joker_display_values.chips = ""
                    card.joker_display_values.mult = "+" .. card.ability.extra.mult
                else
                    card.joker_display_values.chips = "+" .. card.ability.extra.chips
                    card.joker_display_values.mult = ""
                end
            end
        }
    end
}

-- See localization/en-us.lua to create joker text