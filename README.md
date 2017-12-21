# Touhou DOOM Advance Pack

Extensions and bugfixes pack for **Untitled's Touhou DOOM** mod.

This mod adds some interesting (as for me) features to Untitled's Touhou DOOM.  
(Yes, *I heard you like Touhou and DOOM, so I made a Touhou mod to Touhou mod so you can play even more Touhouish DOOM while playing Touhouish DOOM!*)

You may get Untitled's Touhou DOOM here: [https://forum.zdoom.org/viewtopic.php?f=19&t=57817](https://forum.zdoom.org/viewtopic.php?f=19&t=57817)

What has been done:
- Each boss has her health bar and indicator of remaining spell cards. Color of health bar (green/yellow/orange/red) indicates amount of remaining health, or that it is survival spell (pale violet). Color of boss's name over it indicates type of attack: nonspell (white), spell card (red), survival spell (gold). It may be disabled by `touhou_show_boss_bars` CVAR.
- Score system introduced; current value is shown in bottom left corner of screen along the HUD. It may be disabled by `touhou_use_scoring` CVAR.
- Spell card bonus introduced: if player is able to capture spell card in less than 30 seconds, he/she is awarded by some amount of points (it begins from 100000 prior to spell card declaration and continuously drops until reached 0 at 30 seconds). Survival spell cards are always awarded by 100000 points. It requires bit more tweaking, but now it is like a demonstration.
- Point items are dropped by fairies, dolls and bosses along with power items. Some bosses (notably extra stage ones) do very large drops.
- Power (and point, if scoring enabled) items are dropped by enemies on levels >= 13. It may be disabled by `touhou_spawn_more_items` and `touhou_bosses_drop_powerups` CVARs.
- Power items also increase score on pickup (but less than single point item); so they are still subject to pick up even if you have 400 power.
- Power and point items are depleting with time, so it's better to pick them up as quick as possible (that kinda emulates behavior of point items which gave you more value if they have no time to fall lower on screen).
- Fancy endgame ("ALL CLEAR!") stats screen (and numbers are not static, but counting from 0 to actual value like in DOOM intermission screen!) has been made.
- *EXTEND* bonus introduced. It may be placed on map, or given as drop from a boss. Contrary to Touhou-like extend mechanic, they do not add a life; but, they "extend" player's possible life scale. Each extend raises maximum health level achievable with megaspheres and soulspheres (but not health bonuses, as they aren't used in Touhou-themed stages) by 100; so single extend gives maximum health 300, next one - 400, and so on.
- Player receives an *EXTEND* when score reaches some predefined levels. It may be disabled by `touhou_use_extends` CVAR. This needs balancing, maybe.

What is missing now, but possibly is a subject to be added when I figure out how to implement it in reasonable way and consider it needed:
- Grazing. I just can't find a suitable way to implement grazing other than fix every single projectile class in game. It looks a bit insane.
- Under some conditions, rarely boss (spotted with Suika, Aya, Koishi, Flandre and Yukari) starts her attack in `Melee` (maybe `Missile`, but it was not seen) state, and not in `See`. It results in the situation when health bar on this attack is not shown at all (because it is activated in `See` state), if it was started while player was in melee range. I surely don't know how to deal with it other way than add health bar starting code to every possible state (`See`, `Missile`, `Melee`, `Spawn`, `Pain`, etc...) which looks way too dumb. By the way, fighting a boss in melee range is highly dangerous, unless you have `IDDQD` (if so, cheater must suffer, lol, and don't need health bar as much as legitimate player). In other cases such problems were not spotted, so I think it's all OK with this. If you encounter such thing in a normal battle, let me know which spell/nonspell of which boss it was; I'll fix the specific case instead of every one of them.
- Auto-collect. I suppose when boss or midboss battle begins, player must auto-collect all power and score items remaining on map; I still don't know how to do this in nice-looking matter (Well, draft idea is to use `ThingCount`, then despawn every point/power item, and add resulting value to score; but it's not even nearly pretty as mechanic of auto-collect in Touhou).
- High score. I don't think ACS allow me to modify files on disk, but for now you still may save your score table as a typical savegame (yes, it is possible!) and show this to your friends lol.
- Enemy marker. It turned out much harder than I thought of it; that's because ACS/DECORATE don't know anything about player screen. As for now, I surely can't find the way to do something like what I want to see there.

Screenshots: [Power and bonus items](https://drive.google.com/open?id=1XLNGhiPnrYkXFIuYhHlQmV8D332sB-5r), [Spell card battle](https://drive.google.com/open?id=1aezcYQYXBZKiMU893w-fxNxUjm3qLRAU), [Survival spell](https://drive.google.com/open?id=1kh70I9q2q2C5NSL-KWCoackQV0GahQkw), [Score screen](https://drive.google.com/open?id=19QdTSPlKm4ecvoTvpvTULunJzd61IbjH).

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
And then I started DECORATing and ACSing, and added some features that, as for me, should be in Touhou (even if it is made on DOOM engine), like health bars and point system, and now it is here!

P.S. Great thanks to *Dusted* and *Untitled* for giving me a lot of fun playing theirs mods and eventually inspiring me for making this one.

## How to build

### Windows or manual build

1. Download music for score table map.
* By default it is "Shinkirou Orchestra" by U2 Akiyama (title screen theme from Hopeless Masquerade).  
* You may find it here: [https://www.youtube.com/watch?v=Qys4Oi1-680](https://www.youtube.com/watch?v=Qys4Oi1-680)  
* Use your preferred youtube music downloader or anything else.  
* This music is not bundled here for licensing reasons.  
* If you don't want to do this, just use your own music.  
* Resulting file should be in WAV format and named `30_SHINKIRO.wav`.

2. Compile ACC scripts.
* You may use ACC compiler from [https://github.com/rheit/acc](https://github.com/rheit/acc).
* Run the following commands:
```
acc -i <include_dir> 23_TOUHOU2.acs 21_TOUHOU2.o
acc -i <include_dir> 27_SCRIPTS.acs 26_BEHAVIOR.o
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
* build wadbuild utility (if not built already);
* download music (if not downloaded or created already);
* compile acc scripts;
* build PWAD (overwriting previous version).

Requirements:
* `youtube-dl` ([https://github.com/rg3/youtube-dl](https://github.com/rg3/youtube-dl)); you may install it by just doing `sudo pip install youtube-dl` (only if music is to be downloaded).
* `git` (to grab acc compiler from github).
* `gcc` (to compile acc compiler and wad file build tool).
* little-endian machine (or you have to rewrite `wadbuild.c` to correctly work on your architecture). If you don't know what it is, it's likely you have it.

If you want to clean your working copy to the distribution level, you may run `./build.sh -c`. It will delete acc, wadbuild executable and music; only repository files will be left.

Or, you may perform manual installation, if you want.

## How to use

* Get any modern source port like **Zandronum**, **ZDoom**, **GZDoom**. WAD file was tested on Zandronum 3.0 (https://zdoom.org/wiki/Zandronum), but should be suitable for any not-so-old ZDoom/GZDoom.
* Get DOOM2.WAD from DOOM II game. Possibly FreeDOOM's one can be suitable; it was not tested though.
* Get Untitled's Touhou Doom PK3 here: [https://forum.zdoom.org/viewtopic.php?f=19&t=57817](https://forum.zdoom.org/viewtopic.php?f=19&t=57817)
* *(optional)* Get any launcher like ZDL ([https://zdoom.org/wiki/ZDL](https://zdoom.org/wiki/ZDL)) or use another one - whatever you like.
* Run ZDoom/GZDoom/Zandronum with `DOOM2.WAD` as IWAD, `TouhouDoom.pk3` as *first* PWAD in list, and `TouhouDoomAdvancePack.wad` as *second* PWAD in list. Order does strictly matter.
* Enjoy your "advanced" Touhou DOOM!
