G.localization.misc.dictionary["k_fusion"] = "Fusion"
G.localization.misc.dictionary["k_flipped_ex"] = "Flipped!"
G.localization.misc.dictionary["k_copied_ex"] = "Cloned!"
G.localization.misc.dictionary["k_in_tact_ex"] = "In-Tact!"
G.localization.misc.dictionary["b_fuse"] = "FUSE"
FusionJokers = {}
FusionJokers.fusions = {
	{ jokers = {
		{ name = "j_greedy_joker", carry_stat = nil, extra_stat = false },
		{ name = "j_rough_gem", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_diamond_bard", cost = 12 },
	{ jokers = {
		{ name = "j_lusty_joker", carry_stat = nil, extra_stat = false },
		{ name = "j_bloodstone", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_heart_paladin", cost = 12 },
	{ jokers = {
		{ name = "j_wrathful_joker", carry_stat = nil, extra_stat = false },
		{ name = "j_arrowhead", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_spade_archer", cost = 12 },
	{ jokers = {
		{ name = "j_gluttenous_joker", carry_stat = nil, extra_stat = false },
		{ name = "j_onyx_agate", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_club_wizard", cost = 12 },
	{ jokers = {
		{ name = "j_supernova", carry_stat = nil, extra_stat = false },
		{ name = "j_constellation", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_big_bang", cost = 11 },
	{ jokers = {
		{ name = "j_even_steven", carry_stat = nil, extra_stat = false },
		{ name = "j_odd_todd", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_dynamic_duo", cost = 8 },
	{ jokers = {
		{ name = "j_flash", carry_stat = "mult", extra_stat = false },
		{ name = "j_chaos", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_collectible_chaos_card", cost = 9 },
	{ jokers = {
		{ name = "j_juggler", carry_stat = nil, extra_stat = false },
		{ name = "j_drunkard", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_flip_flop", cost = 9 },
	{ jokers = {
		{ name = "j_business", carry_stat = nil, extra_stat = false },
		{ name = "j_reserved_parking", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_royal_decree", cost = 10 },
	{ jokers = {
		{ name = "j_abstract", carry_stat = nil, extra_stat = false },
		{ name = "j_riff_raff", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_dementia_joker", cost = 8 },
	{ jokers = {
		{ name = "j_egg", carry_stat = "extra_value", extra_stat = false },
		{ name = "j_golden", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_golden_egg", cost = 10 },
	{ jokers = {
		{ name = "j_banner", carry_stat = nil, extra_stat = false },
		{ name = "j_green_joker", carry_stat = "mult", extra_stat = false }
	}, result_joker = "j_fuse_flag_bearer", cost = 9 },
	{ jokers = {
		{ name = "j_scary_face", carry_stat = nil, extra_stat = false },
		{ name = "j_smiley", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_uncanny_face", cost = 8 },
	{ jokers = {
		{ name = "j_ride_the_bus", carry_stat = nil, extra_stat = false },
		{ name = "j_drivers_license", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_commercial_driver", cost = 8 },
  { jokers = {
		{ name = "j_hiker", carry_stat = nil, extra_stat = false },
		{ name = "j_dusk", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fuse_camping_trip", cost = 10 },
}

FusionJokers.fusionconfig = SMODS.current_mod.config
SMODS.load_file('configui.lua')()

for _, fusion in ipairs(FusionJokers.fusions) do
    local fused = fusion.result_joker

    for _, component in ipairs(fusion.jokers) do
        local component_name = component.name

        SMODS.Joker:take_ownership(component_name, {
            in_pool = function(self, args)
                if #SMODS.find_card('j_showman') > 0 then return true end -- Allow finding copies if Showman is present
				if not FusionJokers.fusionconfig.block_components then return true end --If the option is disabled, don't do the check
                if #SMODS.find_card(fused) > 0 then return false end -- If the fused Joker exists, remove both components
                return true
            end
        }, true) -- silent | suppresses mod badge
    end
end


SMODS.Rarity{
	key = "fusion",
	default_weight = 0,
	badge_colour = HEX("F7D762"),
	pools = {["Joker"] = false},
	get_weight = function(self, weight, object_type)
			return weight
	end,
}

local SMODS_Joker_inject=SMODS.Joker.inject
SMODS.Joker.inject =function(self)
	if self.rarity == 5 or self.rarity == "fusion" then
		self.rarity = "fuse_fusion"
	end
  SMODS_Joker_inject(self)
end

function FusionJokers.fusions:register_fusion(t)
	if type(t) ~= "table" then
		sendErrorMessage("Invalid format for register_fusion; should be table, got "..type(t), "Fusion Jokers")
		return
	end
	local jokers
	if t.jokers then jokers = t.jokers
	else
		local i = 1
		jokers = {}
		while t["joker"..i] do
			jokers[i] = {
				name = t["joker"..i],
				carry_stat = t["carry_stat"..i],
				merge_stat = t["merge_stat"..i]
			}
			i = i+1
		end
	end

	table.insert(self,
	{
		jokers = jokers,
		result_joker = t.result_joker,
		cost = t.cost,
		merged_stat = t.merged_stat,
		requirement = t.requirement,
		aftermath = t.aftermath,
	})
end

function FusionJokers.fusions:add_fusion(joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, merged_stat, merge_stat1, merge_stat2)
	if type(joker1) == "table" then
		sendWarnMessage("add_fusion expects a list of parameters, not a table; passing table to register_fusion", "Fusion Jokers")
		FusionJokers.fusions:register_fusion(joker1)
	else
		sendWarnMessage("add_fusion is now deprecated, please switch to register_fusion at earliest convenience", "Fusion Jokers")
	
		self:register_fusion{
			jokers = {
				{name = joker1, carry_stat = carry_stat1, merge_stat = merge_stat1 },
				{name = joker2, carry_stat = carry_stat2, merge_stat = merge_stat2 },
			},
			merged_stat = merged_stat,
			result_joker = result_joker,
			cost = cost,
		}
	end
end

SMODS.load_file('jokers/diamondbard.lua')()
SMODS.load_file('jokers/heartpaladin.lua')()
SMODS.load_file('jokers/spadearcher.lua')()
SMODS.load_file('jokers/clubwizard.lua')()
if (SMODS.Mods["SixSuits"] or {}).can_load then
	SMODS.load_file('jokers/moonmarauder.lua')()
	SMODS.load_file('jokers/staroracle.lua')()
end
SMODS.load_file('jokers/bigbang.lua')()
SMODS.load_file('jokers/dynamicduo.lua')()
SMODS.load_file('jokers/collectiblechaos.lua')()
SMODS.load_file('jokers/flipflop.lua')()
SMODS.load_file('jokers/royaldecree.lua')()
SMODS.load_file('jokers/dementiajoker.lua')()
SMODS.load_file('jokers/goldenegg.lua')()
SMODS.load_file('jokers/flagbearer.lua')()
SMODS.load_file('jokers/uncannyface.lua')()
SMODS.load_file('jokers/commercialdriver.lua')()
SMODS.load_file('jokers/campingtrip.lua')()
SMODS.load_file('jokers/test.lua')()

to_number = to_number or function(num)
	return num
end

to_big = to_big or function(num)
	return num
end

local function has_joker(val, start_pos, highlight_only)
	if not start_pos then
		start_pos = 1
	end
	for i,v in ipairs(G.jokers.highlighted) do
		if v.ability.set == 'Joker' and v.config.center_key == val and i >= start_pos then

			for ii, vv in ipairs(G.jokers.cards) do
				if vv == v and ii >= start_pos then
					return ii
				end
			end

		end
	end

	if not highlight_only then
		for i, v in ipairs(G.jokers.cards) do
			if v.ability.set == 'Joker' and v.config.center_key == val and i >= start_pos then
				return i
			end
		end
	end
	return -1
end

function Card:can_fuse_card(juicing)
	--[[
	for _, fusion in ipairs(FusionJokers.fusions) do
		if to_number(G.GAME.dollars) >= fusion.cost then
			local found_me = false
			local all_jokers = true
			for _, joker in ipairs(fusion.jokers) do
				if fusion.jokers[1].name == fusion.jokers[2].name then
					if #SMODS.find_card(joker.name) > 1 then
						return true
					else
						return false
					end
				end
				if not next(SMODS.find_card(joker.name)) then
					all_jokers = false
				end
				if joker.name == self.config.center_key then
					found_me = true
				end
			end
			if found_me and all_jokers then
				return true
			end
		end
	end
  	return false
	--]]
	local fusion = self:get_card_fusion()
	if fusion.cost == "??" then return false, fusion end
	if fusion.blocked and not juicing then return false, fusion end
	local reqcheck = true
	if type(fusion.requirement) == "function" then
		reqcheck = fusion.requirement()
	end
	return reqcheck and (to_big(fusion.cost) + to_big(G.GAME.bankrupt_at or 0)) <= to_big(G.GAME.dollars), fusion
end

function Card:get_card_fusion(debug)
	local dprint = function(msg)
		if debug then print(msg) end
	end
	local function deep_copy(tbl)
		if type(tbl) ~= "table" then return tbl end
		local copy = {}
		for k, v in pairs(tbl) do
			copy[k] = deep_copy(v)
		end
		return copy
	end
	local results = {}
	local held = {}
	local affordable = {}
	local result = {
		result_joker = "No fusions",
		jokers = {
			{name = self.config.center_key }
		},
		cost = "??"
	}
	local jokerspos = {}
	for _, fusion in ipairs(FusionJokers.fusions) do
		local valid = true
		for _, joker in ipairs(fusion.jokers) do
			if joker.name == self.config.center_key then
				result.result_joker = "Cannot fuse"
				local recipe = {}
				for i,component in ipairs(fusion.jokers) do
					recipe[component.name] = (recipe[component.name] or 0) + 1
					dprint(component.name.."s needed: "..tostring(recipe[component.name]))
					dprint(component.name.."s found: "..tostring(#SMODS.find_card(component.name)))
					if #SMODS.find_card(component.name) >= recipe[component.name] then
						valid = valid and true
					else
						valid = false
					end
				end
				if valid then
					results[#results+1] = deep_copy(fusion)
				end
				break
			end
		end
	end
	if #results > 1 then
		for i,recipe in ipairs(results) do
			dprint("Checking if components for "..recipe.result_joker.." are owned")
			jokerspos = {}
			local valid = true
			local startpos = {}
			for ii,component in ipairs(recipe.jokers) do
				startpos[component.name] = (startpos[component.name] or 1)
				if has_joker(component.name, startpos[component.name]) ~= -1 then
					startpos[component.name] = has_joker(component.name, startpos[component.name])
					dprint(component.name.." is owned")
					jokerspos[#jokerspos+1] = startpos[component.name]
				else
					valid = false
					dprint(component.name.." is not owned")
					break
				end
			end
			if valid then held[#held+1] = deep_copy(results[i]) end
		end
		if #held == 1 then return held[1] end
		if #held == 0 then return result end
		for i,recipe in ipairs(held) do
			dprint("Checking if components for "..recipe.result_joker.." are highlighted")
			local valid = true
			local startpos = {}
			for ii,component in ipairs(recipe.jokers) do
				startpos[component.name] = (startpos[component.name] or 1)
				if has_joker(component.name, startpos[component.name], true) ~= -1 then
					startpos[component.name] = has_joker(component.name, startpos[component.name], true)
					dprint(component.name.." is highlighted")
				else
					valid = false
					dprint(component.name.." is not highlighted")
					break
				end
			end
			if (to_big(recipe.cost) + to_big(G.GAME.bankrupt_at or 0)) < to_big(G.GAME.dollars) then
				affordable[#affordable+1] = deep_copy(held[i])
			end
			if valid then result = held[i] break end --don't overhighlight :v
		end
	elseif #results == 1 then
		result = results[1]
	end
	if #held > 1 and result.cost == "??" then
		dprint("Picking a random possible fusion...")
		local possible = #affordable > 0 and affordable or held
		local pick = pseudorandom("fusetext", 1, #possible)
		result = possible[pick]
		result.blocked = true
	else
		dprint(result.blocked and "Result is blocked when it shouldn't be??" or "Result is not blocked (this is correct)")
	end
    return result
end


function Card:fuse_card(debug)
	local dprint = function(msg)
		if debug then print(msg) end
	end
	G.CONTROLLER.locks.selling_card = true
    stop_use()
    local area = self.area
    G.CONTROLLER:save_cardarea_focus('jokers')

    if self.children.use_button then self.children.use_button:remove(); self.children.use_button = nil end
    if self.children.sell_button then self.children.sell_button:remove(); self.children.sell_button = nil end

	local my_pos = has_joker(self.config.center_key)

	local edition = nil
	if self.edition then
		edition = self.edition
	end


	local chosen_fusion = self:get_card_fusion()
	local joker_pos = {}
	local carried_stats = {}
	local merged_stat = 0
	do
		local fusion = chosen_fusion
		local found_me = false
		local list = {}
		local recipe = {}
		for i,component in ipairs(fusion.jokers) do
			list[component.name] = (list[component.name] or 0) + 1
			recipe[#recipe+1] = SMODS.find_card(component.name)[list[component.name]] or "FAILURE!"
			if recipe[#recipe] == self  then
				found_me = true
			end
			for ii,vv in ipairs(G.jokers.cards) do
				if vv == recipe[#recipe] then
					table.insert(joker_pos, {pos = ii, joker = vv})
					if component.carry_stat then
						carried_stats[component.carry_stat] = (carried_stats[component.carry_stat] or 0) + (type(vv.ability.extra) == "table" and vv.ability.extra[component.carry_stat] or vv.ability[component.carry_stat] or 0)
					end
					if component.merge_stat then
						merged_stat = merged_stat + (type(vv.ability.extra) == "table" and vv.ability.extra[component.merge_stat] or vv.ability[component.merge_stat])
					end
				end
			end
		end

		if not (#joker_pos == #fusion.jokers and found_me) then
			dprint("Failed to find component Jokers when fusing?")
			chosen_fusion = nil
		end
	end

	if chosen_fusion ~= nil then
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function()
			play_sound('whoosh1')
			for _, pos in ipairs(joker_pos) do
				if not edition and G.jokers.cards[pos.pos].edition then
					edition = G.jokers.cards[pos.pos].edition
				end
				G.jokers.cards[pos.pos]:juice_up(0.3, 0.4)
			end
			return true
		end}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({trigger = 'immediate',func = function()
			ease_dollars(-chosen_fusion.cost)
			local j_fusion = SMODS.create_card({set = "Joker", area = G.jokers, key = chosen_fusion.result_joker, edition = edition})
			table.sort(joker_pos, function (a, b)
				return a.pos > b.pos
			end)
			local ingredience = {}
			for index, pos in ipairs(joker_pos) do
				ingredience[index] = G.jokers.cards[pos.pos]
				G.jokers.cards[pos.pos].fused = true --Check for this if your on-card-removal function has an opinion on whether being fused counts as removal.
			end
			SMODS.calculate_context{fusing_jokers = true, fusion_components = ingredience, fusion_result = j_fusion}
			for index, pos in ipairs(joker_pos) do
				local isPrimary = false
				if G.jokers.cards[pos.pos] == self then
					isPrimary = true
				end
				for k,_ in pairs(SMODS.Stickers) do
					if G.jokers.cards[pos.pos].ability[k] then
						-- if string.find(k, "gemslot") then
						-- 	local gemExists = false
						-- 	for k1, _ in pairs(j_fusion.ability) do
						-- 		if string.find(k1, "gemslot") then
						-- 				gemExists = true
						-- 		end
						-- 	end
						-- 	if isPrimary then
						-- 		j_fusion.ability[k] = true
						-- 	end
						-- else
							j_fusion.ability[k] = true
						--end
					end
				end
				--G.jokers.cards[pos]:start_dissolve({G.C.GOLD})
				local flags = SMODS.calculate_context({joker_type_destroyed = true, card = G.jokers.cards[pos.pos]})
				if not flags.no_destroy then
					G.jokers.cards[pos.pos]:remove()
				else
					G.jokers.cards[pos.pos].fused = nil
				end
			end

			if next(carried_stats) then
				if type(j_fusion.ability.extra) == "number" then
					local num = j_fusion.ability.extra
					j_fusion.ability.extra = {
						extra = num
					}
				elseif type(j_fusion.ability.extra) ~= "table" then
					j_fusion.ability.extra = {}
				end
				for k,v in pairs(carried_stats) do
					j_fusion.ability.extra[k] = v
				end
			end
			if chosen_fusion.merged_stat then
				j_fusion.ability.extra[chosen_fusion.merged_stat] = merged_stat
			end

			delay(0.3)

			j_fusion:add_to_deck()
			G.jokers:emplace(j_fusion)
			play_sound('explosion_release1')
			G.jokers:unhighlight_all()

			delay(0.1)
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.3, blocking = false,
			func = function()
				G.E_MANAGER:add_event(Event({trigger = 'immediate',
				func = function()
					G.E_MANAGER:add_event(Event({trigger = 'immediate',
					func = function()
						G.CONTROLLER.locks.selling_card = nil
						G.CONTROLLER:recall_cardarea_focus(area == G.jokers and 'jokers' or 'consumeables')
					return true
					end}))
				return true
				end}))
			return true
			end}))
			return true
		end}))

		if type(chosen_fusion.aftermath) == "function" then	
			G.E_MANAGER:add_event(Event({func = function ()
				chosen_fusion.aftermath()
				return true
			end}))
		end
	end

	G.CONTROLLER.locks.selling_card = nil
	G.CONTROLLER:recall_cardarea_focus('jokers')
end

G.FUNCS.fuse_card = function(e)
    local card = e.config.ref_table
    card:fuse_card()
end

G.FUNCS.can_fuse_card = function(e)
    if e.config.ref_table:can_fuse_card() then
        e.config.colour = G.C.DARK_EDITION
        e.config.button = 'fuse_card'
    else
      	e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      	e.config.button = nil
    end
  end



local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local retval = use_and_sell_buttonsref(card)

	if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and card.ability.fusion then
		local fuse =
		{n=G.UIT.C, config={align = "cr"}, nodes={

		  {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'sell_card', func = 'can_fuse_card'}, nodes={
			{n=G.UIT.B, config = {w=0.1,h=0.6}},
			{n=G.UIT.C, config={align = "tm"}, nodes={
				{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
					{n=G.UIT.T, config={text = localize('b_fuse'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
				}},
				{n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
					{n=G.UIT.T, config={ref_table = card, ref_value = 'fusion_cost',colour = G.C.WHITE, scale = 0.55, shadow = true}}
				}}
			}}
		  }}
		}}
		retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
		table.insert(retval.nodes[1].nodes[2].nodes, fuse)
		return retval
	end

	return retval
end

local updateref = Card.update
function Card:update(dt)
  updateref(self, dt)

  if G.STAGE == G.STAGES.RUN then
	local fuseable, my_fusion  = self:can_fuse_card(true)

	if my_fusion and my_fusion.result_joker ~= "No fusions" then
		self.ability.fusion = self.ability.fusion or {}
		self.fusion_cost = my_fusion.cost

		if fuseable and not self.ability.fusion.jiggle then
			juice_card_until(self,
			function(card)
				return (card:can_fuse_card(true))
			end,
			true)

			self.ability.fusion.jiggle = true
		end

		if not fuseable and self.ability.fusion.jiggle then
			self.ability.fusion.jiggle = false
		end
	else
		self.ability.fusion, self.fusion_cost = nil, nil
	end
  end
end

-- local shatterref = Card.shatter
-- function Card:shatter()
-- 	G.E_MANAGER:add_event(Event({
--         trigger = 'before',
--         blockable = false,
--         func = (function() 
-- 			if (self.ability.name == 'Glass Card') and find_joker("Moon Marauder") then
-- 				local _card = copy_card(self, nil, nil, G.playing_card)
-- 				_card:add_to_deck()
-- 				table.insert(G.playing_cards, _card)
-- 			end
-- 		return true end)
--     }))

-- 	shatterref(self)

-- end

SMODS.current_mod.reset_game_globals = function (init)
	if init then
		G.jokers.config.highlighted_limit = math.max(G.jokers.config.highlighted_limit, 1e300)
	end
end