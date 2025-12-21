---@meta

---@class FusionIngredient
---@field name string Key of the ingredient joker
---@field carry_stat? string Name of the stat to be carried over (whether it is in an `extra` table will be detected automatically)
---@field merge_stat? string Name of the stat to be merged (as `carry_stat`); all `merge_stat` are added together.

---@class FusionRecipe
---@field jokers FusionIngredient[] 
---@field result_joker string Key of the Joker to be produced
---@field cost number Cost in dollars to perform this fusion
---@field merged_stat? string Key of the stat in which to place any `merge_stat` values, if present
---@field requirement? fun():boolean Must return `true` to perform this fusion (in addition to having the ingredients and money)
---@field aftermath? fun():nil Will be run after the Jokers are fused3

---Register a fusion recipe
---@param t FusionRecipe
function FusionJokers.fusions:register_fusion(t)
end

---Deprecated, please use `register_fusion` instead.
---@param joker1 string Key of the first Joker to fuse
---@param carry_stat1 string|nil Name of the stat to carry, if any
---@param extra1 nil No longer used
---@param joker2 string Key of the second Joker to fuse
---@param carry_stat2 string|nil Name of the stat to carry, if any
---@param extra2 nil No longer used
---@param result_joker string Key of the output Joker
---@param cost string Cost in dollars to perform this fusion
---@param merged_stat string|nil Name of the stat in which to place `merge_stat`s
---@param merge_stat1 string|nil Name of the stat to merge from Joker 1
---@param merge_stat2 string|nil ... and from Joker 2
function FusionJokers.fusions:add_fusion(joker1, carry_stat1, extra1, joker2, carry_stat2, extra2, result_joker, cost, merged_stat, merge_stat1, merge_stat2)
end