# Touhou DOOM Advance Pack

Extensions and bugfixes pack for **Untitled's Touhou DOOM** mod.
Requires Touhou DOOM version 3.5C or higher, and GZDoom 2.2.0 or higher.

This mod adds some interesting (as for me) features to Untitled's Touhou DOOM.
(Yes, *I heard you like Touhou and DOOM, so I made a Touhou mod to Touhou mod so you can play even more Touhouish DOOM while playing Touhouish DOOM!*)

You may get Untitled's Touhou DOOM here: [https://forum.zdoom.org/viewtopic.php?f=19&t=57817](https://forum.zdoom.org/viewtopic.php?f=19&t=57817)

What has been done:
- Score system introduced; current value is shown in bottom left corner of screen along the HUD. It may be disabled by `touhou_use_scoring` CVAR.
- Spell card bonus introduced: if player is able to capture spell card in a given time, he/she is awarded by some amount of points (it begins from 100000 prior to spell card declaration and continuously drops until reached 0 at certain time). Survival spell cards are always awarded by 100000 points.
- Point items are dropped by fairies, dolls and bosses along with power items. Some bosses (notably extra stage ones) do very large drops.
- Power (and point, if scoring enabled) items are dropped by enemies on levels >= 13. It may be disabled by `touhou_spawn_more_items` and `touhou_bosses_drop_powerups` CVARs.
- Power items also increase score on pickup (but less than single point item); so they are still subject to pick up even if you have 400 power.
- Power and point items are depleting with time, so it's better to pick them up as quick as possible (that kinda emulates behavior of point items which gave you more value if they have no time to fall lower on screen).
- Fancy endgame ("ALL CLEAR!") stats screen (and numbers are not static, but counting from 0 to actual value like in DOOM intermission screen!) has been made.
- *EXTEND* bonus introduced. It may be placed on map, or given as drop from a boss. Contrary to Touhou-like extend mechanic, they do not add a life; but, they "extend" player's possible life scale. Each extend raises maximum health level achievable with megaspheres and soulspheres (but not health bonuses, as they aren't used in Touhou-themed stages) by 100; so single extend gives maximum health 300, next one - 400, and so on.
- Player receives an *EXTEND* when score reaches some predefined levels. It may be disabled by `touhou_use_extends` CVAR. This needs balancing, maybe.
- Grazing. I wasn't able to find a suitable way to implement grazing without raising engine version requirements (or else I have to fix every single projectile class in game, which is insane), so it's the main reason for breaking backward compatibility.

What is missing now, but possibly is a subject to be added when I figure out how to implement it in reasonable way and consider it needed:
- Auto-collect. I suppose when boss or midboss battle begins, player must auto-collect all power and score items remaining on map; I still don't know how to do this in nice-looking matter (Well, draft idea is to use `ThingCount`, then despawn every point/power item, and add resulting value to score; but it's not even nearly pretty as mechanic of auto-collect in Touhou).
- High score. I don't think ACS allow me to modify files on disk, but for now you still may save your score table as a typical savegame (yes, it is possible!) and show this to your friends lol.
- Enemy marker. It turned out much harder than I thought of it; that's because ACS/DECORATE don't know anything about player screen. As for now, I surely can't find the way to do something like what I want to see there.

Screenshots: [Power and bonus items](https://drive.google.com/open?id=1XLNGhiPnrYkXFIuYhHlQmV8D332sB-5r), [Score screen](https://drive.google.com/open?id=19QdTSPlKm4ecvoTvpvTULunJzd61IbjH), [Options menu](https://drive.google.com/open?id=1XayZUJYZyaaklP4cFbo9vGxxJgCko2K7).

## Why is this exist?

Because DOOM is fun, and Touhou is fun too.

And because Touhou DOOM is fun squared! (or maybe even cubed.)

Well, at first I searched for any Touhou game I will be able to finish (spoiler: there's still no one).
But, as I played DOOM many times, I did wonder: is there anything about Touhou in DOOM?
And, after googling such thing, I found, to my very surprise, such thing: that was *Dusted's Touhou DOOM* ([http://lunaticred.proboards.com/thread/4956/touhou-doom-on-gensokyo-released](http://lunaticred.proboards.com/thread/4956/touhou-doom-on-gensokyo-released)).
It was really excellent and fun thing, but has some bugs and boring elements like monster-wave maps while you didn't get any Touhouish experience, but only put down countless DOOM monsters. So it was more like DOOM with Touhou elements.
Yes, it was totally cool, but at that time, I was not reaaly thinking about what to add to this mod to make it more Touhouish - as it looked like not very Touhouish at all.
But then, I eventually found *Untitled's Touhou DOOM*. In contrast with Dusted's version, it was not DOOM with some Touhou, but like Touhou on DOOM engine!
Yes, it added spell card battles, more consistent and interesting plot, power mechanics, more nice bosses and even extra stages. (And yes, even on easy modo, it was way more harder than generic DOOM even on UV.)
So, I thought: *__Y U NO MORE TOUHOU THERE?__*
And then I started DECORATing and ACSing, and added some features that, as for me, should be in Touhou (even if it is made on DOOM engine), like health bars and point/graze system, and now it is here!
After that, health bar code has been included into original Touhou DOOM, and thus removed from this addon.

P.S. Great thanks to *Dusted* and *Untitled* for giving me a lot of fun playing theirs mods and eventually inspiring me for making this one.

## How to build

### Windows or manual build

1. Download music for score table map.
* By default it is "Shinkirou Orchestra" by U2 Akiyama (title screen theme from Hopeless Masquerade).
* You may find it here: [https://www.youtube.com/watch?v=Qys4Oi1-680](https://www.youtube.com/watch?v=Qys4Oi1-680)
* Use your preferred youtube music downloader or anything else.
* This music is not bundled here for licensing reasons.
* If you don't want to do this, just use your own music.
* Resulting file should be in WAV format and named `22_SHINKIRO.wav`.

2. Compile ACC scripts.
* You may use ACC compiler from [https://github.com/rheit/acc](https://github.com/rheit/acc).
* Run the following commands:
```
acc -i <include_dir> 15_TOUHOU2.acs 13_TOUHOU2.o
acc -i <include_dir> 19_SCRIPTS.acs 18_BEHAVIOR.o
```
* `<include_dir>` is a directory where files like `zcommon.acs`, `zdefs.acs`, `zspecial.acs`, `zwvars.acs` lay.
* Of course, you may use any other ACC compiler including compilers integrated to your WAD editor.

3. Create a WAD file.
* Use your preferred WAD file builder. I use SLADE 3 (see [http://slade.mancubus.net/](http://slade.mancubus.net/)), for example.
* Compile every file named like `nn_aaaaaaaa.xxx` to lump `aaaaaaaa`; skip file extension (`.xxx`) and use numbers at the beginning (`nn`) as order markers; lesser should go first.
* There are some files with zero size; it is WAD section markers, like `SS_START`/`SS_END`, `A_START`/`A_END`, `STATMAP`/`ENDMAP` and so on. Everything is ok with them.

### Linux

Just run `./build.sh`. It does everything automatically:
* download and build acc compiler (if not built already);
* download wadtools and build wadbuild utility (if not built already);
* download music (if not downloaded or created already);
* compile acc scripts;
* build PWAD (overwriting previous version).

Requirements:
* `youtube-dl` ([https://github.com/rg3/youtube-dl](https://github.com/rg3/youtube-dl)); you may install it by just doing `pip install youtube-dl` as root (only if music is to be downloaded).
* `git` (to grab acc compiler and wadtools from github).
* `gcc` (to compile acc and wadtools).
* little-endian machine (or you have to rewrite wadtools to correctly work on your architecture). If you don't know what little-endian is, it's likely you have it.

If you want to clean your working copy to the distribution level, you may run `./build.sh -c`. It will delete acc, wadtools and music; only repository files will be left.

Or, you may perform manual installation, if you want.

## How to use

* Get any modern **GZDoom** source port (minimum requirement is 2.2.0).
* Get DOOM2.WAD from DOOM II game. Possibly FreeDOOM's one can be suitable; it was not tested though.
* Get Untitled's Touhou Doom PK3 here: [https://forum.zdoom.org/viewtopic.php?f=19&t=57817](https://forum.zdoom.org/viewtopic.php?f=19&t=57817)
* *(optional)* Get any launcher like ZDL ([https://zdoom.org/wiki/ZDL](https://zdoom.org/wiki/ZDL)) or use another one - whatever you like.
* Run GZDoom with `DOOM2.WAD` as IWAD, `TouhouDoom.pk3` (or however this file is named) as *first* PWAD in list, and `TouhouDoomAdvancePack.wad` as *second* PWAD in list. Order does strictly matter.
* Enjoy your "advanced" Touhou DOOM!
