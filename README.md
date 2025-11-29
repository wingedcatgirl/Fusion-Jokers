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

There are a total of 17 fusions added in the mod, two of which are exclusive to [Six Suits](https://github.com/Aurelius7309/SixSuits)!

You can find a list of their abilities, as well as the jokers needed to make them, in this link: https://itayfeder.github.io/Fusion-Jokers/

## ⬇ How to Download <a name = "how_to_download"></a>

- The mod requires Steamodded. You can see info about how to use it [here](https://github.com/Steamopollys/Steamodded)
- Download the latest commit of Fusion Jokers from the green "Code" button up there
- Extract the downloaded mod to the Mods folder (at %appdata%/Balatro/Mods)

## ⚙️ Config <a name = "config"></a>

- **Block used components from reappearing**: Jokers used in a fusion cannot reappear if the fusion is present (unless Showman is also present). Currently only applies to Fusion Jokers fusions; cross-mod functionality is planned. Default true.

## ➕ Fusion API (For Developers) <a name = "fusion_api"></a>

The mod adds a way for other developers to create their own fusions!

Developers can call the function `FusionJokers.fusions:register_fusion()` to register their own fusion to the game. The function also allows them to determine carried stats between the component jokers and the fusion joker.

```lua
FusionJokers.fusions:register_fusion{
  jokers = {
      --First component Joker; all values except "name" optional
			{ name = "j_modprefix_key", carry_stat = "stat_to_carry", merge_stat = "stat_to_merge" },
      --       String, key of component 1      String, name of stat          String, name of stat
      --                                               to carry over                 to merge                                  
			{ name = "j_modprefix_key", carry_stat = "stat_to_carry", merge_stat = "stat_to_merge" },
      --Second component Joker; same values.
      --This works for arbitrary numbers of additional Jokers
      --if you want to do the Exodia thing.
  }
  result_joker = "j_modprefix_key", --String, key of result Joker
  cost = number,                    --Number, cost in $ to fuse this recipe
  requirement = func,               --Optional function; fusion can only be carried out if this function returns `true`.
  merged_stat = "stat",             --Optional string, name of stat that contains "merge_stat"s above
  aftermath = func,                 --Optional function; will be run after the fusion is complete.
}
```

> [!NOTE]
> Carried and merged stats _always_ go in the new Joker's `ability.extra` table now! You also no longer need to specify whether the component Jokers' abilities are in an `extra` table or not; this is now detected automatically.

> [!NOTE]
> The old `add_fusion` method is depreciated and kept only for compatibility; please switch to `register_fusion` at your earliest convenience!

## 🎉 Credits <a name = "credits"></a>

- The original mod was written by [**Itayfeder**](https://github.com/stars/itayfeder/lists/balatro-modding), with art created by [**Lyman**](https://github.com/spikeof2010)
- [**elbe**](https://github.com/lshtech) maintained the mod for several months through breaking Steamodded changes, and added some features
- [**wingedcatgirl**](https://github.com/wingedcatgirl) (hi!) is the current mod maintainer
