<p align="center">
  <a href="" rel="noopener">
 <img width=600px src="art/logo.png?raw=true" alt="Project logo"></a>
</p>


<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/itayfeder/Fusion-Jokers.svg)](https://github.com/itayfeder/Fusion-Jokers/issues)
[![License](https://img.shields.io/badge/license-GNU-blue.svg)](/LICENSE)

</div>

---

<p align="center"> All new special combinations of jokers!
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [How to Download](#how_to_download)
- [Config](#config)
- [Fusion API (For Developers)](#fusion_api)
- [Credits](#credits)

## 🧐 About <a name = "about"></a>

**Fusion Jokers** is a mod that allows players to combine jokers into special powerful new **Fusion Jokers**!

When you have a fusable joker, pressing on it will show a **"fuse" button**. When you have the correct jokers, and enough money, you can combine the jokers into a powerful **Fusion**! 

<img width=500px src="art/jokers_tab.png?raw=true" alt="Showcase of jokers tab 5"></a>

There are a total of 15 fusions added in the mod!

You can find a list of their abilities, as well as the jokers needed to make them, in this link: https://itayfeder.github.io/Fusion-Jokers/

## ⬇ How to Download <a name = "how_to_download"></a>

- The mod requires Steamodded. You can see info about how to use it [here](https://github.com/Steamopollys/Steamodded)
- Download the latest commit of Fusion Jokers from the green "Code" button up there
- Extract the downloaded mod to the Mods folder (at %appdata%/Balatro/Mods)

## ⚙️ Config <a name = "config"></a>

- **Block used components from reappearing**: Jokers used in a fusion cannot reappear if the fusion is present (unless Showman is also present). Currently only applies to Fusion Jokers fusions; cross-mod functionality is planned. Default true.

## ➕ Fusion API (For Developers) <a name = "fusion_api"></a>

The mod adds a way for other developers to create their own fusions!

Developers can call the function `FusionJokers.fusions:add_fusion()` to register their own fusion to the game. The function also allows them to determine carried stats between the component jokers and the fusion joker.

```lua
FusionJokers.fusions:add_fusion(
  joker1,       --string, component joker's key
  carry_stat1,  --string, name of stat to carry into fusion
  extra1,       --boolean, is the carry stat in an "extra" table or not
  joker2,       --
  carry_stat2,  -- same as 1, but for the other component joker
  extra2,       --
  result_joker, --string, key of result joker
  cost,         --number, cost to fuse
  merged_stat, merge_stat1, merge_stat2, merge_extra --TODO explain these
)
```

Alternately, you can call `FusionJokers.fusions:register_fusion()` and pass the desired arguments as a table.

```lua
FusionJokers.fusions:add_fusion(
  "j_egg",
  "extra_value",
  nil,
  "j_golden",
  nil,
  nil,
  "j_fuse_golden_egg",
  12
)
--is equivalent to:
FusionJokers.fusions:register_fusion({
  joker1 = "j_egg",
  carry_stat1 = "extra_value",
  joker2 = "j_golden",
  result_joker = "j_fuse_golden_egg",
  cost = 12,
})
```

## 🎉 Credits <a name = "credits"></a>

- The original mod was written by [**Itayfeder**](https://github.com/stars/itayfeder/lists/balatro-modding), with art created by [**Lyman**](https://github.com/spikeof2010)
- [**elbe**](https://github.com/lshtech) did several patches to handle breaking changes in Steamodded, as well as various other features
