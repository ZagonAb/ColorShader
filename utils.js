.pragma library

var colorMapping= {
    "3do": "#154234",
    "3ds": "#3e2c22",
    "actionmax": "#4c6d9a",
    "adam": "#5f616e",
    "advision": "#654d42",
    "ags": "#4e351f",
    "amiga": "#806e9f",
    "amiga1200": "#4d462f",
    "amiga4000": "#4d462f",
    "amiga500": "#2b4737",
    "amiga600": "#2b4737",
    "amigacd32": "#7a3625",
    "amigacdtv": "#ba6047",
    "amstradcpc": "#313868",
    "android": "#3d3d3c",
    "androidgames": "#39331d",
    "apfm1000": "#797970",
    "apple2": "#7f89a2",
    "apple2gs": "#5b3a30",
    "arcade": "#5f616e",
    "arcadia": "#654d42",
    "archimedes": "#342218",
    "arduboy": "#474747",
    "astrocade": "#c67d67",
    "atari2600": "#493618",
    "atari5200": "#bebacb",
    "atari7800": "#585d49",
    "atari800": "#496db9",
    "atarijaguar": "#362546",
    "atarijaguarcd": "#445579",
    "atarilynx": "#4b4a7b",
    "atarist": "#98a3bd",
    "atarixe": "#5474aa",
    "atom": "#584e38",
    "atomiswave": "#39373c",
    "bbcmicro": "#543641",
    "boom3": "#3f2e20",
    "c128": "#353d44",
    "c20": "#4b281d",
    "c64": "#353d44",
    "camplynx": "#3f2027",
    "cavestory": "#48723a",
    "cdi": "#37333e",
    "cdtv": "#ba6047",
    "cgenius": "#2a3852",
    "chailove": "#8d9195",
    "channelf": "#6ccd72",
    "coco": "#a9a7a5",
    "colecovision": "#353f78",
    "completed": "#405a7a",
    "consolearcade": "#c2c6c2",
    "cps": "#b8624c",
    "cps1": "#a26237",
    "cps2": "#68592e",
    "cps3": "#5a3f32",
    "creativision": "#293861",
    "crvision": "#478cba",
    "custom-collections": "#402e2c",
    "daphne": "#7836a0",
    "default": "#446992",
    "desktop": "#304244",
    "doom": "#313f3a",
    "dos": "#2a3852",
    "dragon32": "#44433f",
    "dreamcast": "#373228",
    "easyrpg": "#62827c",
    "electron": "#563522",
    "emulators": "#56678d",
    "epic": "#3a3028",
    "famicom": "#343c4b",
    "fba": "#c5cac1",
    "fbneo": "#3b4132",
    "final_fantasy": "#5073ab",
    "flash": "#482861",
    "fm7": "#4d3b67",
    "fmtowns": "#512e26",
    "fmtownsmarty": "#512e26",
    "fpinball": "#1b384f",
    "gamate": "#3c2f3e",
    "gameandwatch": "#bfccc5",
    "gamecom": "#341e16",
    "gamecube": "#4c442d",
    "gamegear": "#b6afc9",
    "gamepock": "#bdbdbd",
    "gb": "#99aa95",
    "gb2players": "#c44d46",
    "gba": "#287e44",
    "gba2players": "#59a65e",
    "gbah": "#3a2d36",
    "gbc": "#6b9260",
    "gbc2players": "#3b367f",
    "gbch": "#5a5536",
    "gbh": "#45571b",
    "gemrb": "#463225",
    "genesis": "#76c5d2",
    "genh": "#4d6a49",
    "gmaster": "#3c403b",
    "gp32": "#a4526f",
    "gx4000": "#484848",
    "hbmame": "#5f616e",
    "intellivision": "#4676a4",
    "j2me": "#767270",
    "kodi": "#43353d",
    "laser310": "#375882",
    "laserdisc": "#445579",
    "lcdgames": "#c1cf80",
    "love": "#8d9195",
    "lowresnx": "#1e2c4d",
    "lutris": "#919a8b",
    "lutro": "#434545",
    "macintosh": "#2f3c45",
    "mame-advmame": "#b7c0b3",
    "mame": "#42352a",
    "mario": "#487e3d",
    "mastersystem": "#1d5e55",
    "megacd": "#62573a",
    "megacdjp": "#b3b0ae",
    "megadrive-japan": "#916f48",
    "megadrive": "#76c5d2",
    "megadrivejp": "#916f48",
    "megaduck": "#b54140",
    "mess": "#402e25",
    "model2": "#421a15",
    "model3": "#d59767",
    "moonlight": "#698e9c",
    "moto": "#536367",
    "msx": "#2d3033",
    "msx1": "#7a9464",
    "msx2+": "#2d3033",
    "msx2": "#79a4d2",
    "msxturbor": "#3d2b26",
    "mugen": "#1a2b3e",
    "multivision": "#ceae9b",
    "n3ds": "#3e2c22",
    "n64": "#83bbc8",
    "n64dd": "#9882a9",
    "namco2x6": "#8b5b5b",
    "naomi": "#40376c",
    "naomi2": "#a7a8ad",
    "naomigd": "#79484b",
    "nds": "#925534",
    "neogeo": "#a48c7f",
    "neogeocd": "#473937",
    "neogeocdjp": "#473937",
    "nes": "#3d5557",
    "nesdisk": "#606845",
    "nesh": "#0d1420",
    "ngage": "#9a9ab0",
    "ngp": "#513025",
    "ngpc": "#4a506d",
    "now-playing": "#35456b",
    "odyssey2": "#274c40",
    "openbor": "#562f2d",
    "oric": "#333023",
    "palm": "#8d7548",
    "pc": "#504c46",
    "pc88": "#454260",
    "pc98": "#795648",
    "pcarcade": "#49464e",
    "pce-cd": "#3b5b9a",
    "pcengine": "#cba490",
    "pcenginecd": "#3b5b9a",
    "pcfx": "#3d2b1c",
    "pet": "#4596ac",
    "pico8": "#565765",
    "plus4": "#4b473d",
    "pokemini": "#4a5a69",
    "pokemon": "#44474f",
    "ports": "#cb9253",
    "prboom": "#313f3a",
    "ps2": "#435c7f",
    "ps3": "#2e4d59",
    "ps4": "#313d43",
    "psp": "#b0a5a0",
    "pspminis": "#778494",
    "psvita": "#303d3e",
    "psx": "#373920",
    "pv1000": "#808479",
    "pygame": "#9b656a",
    "pyxel": "#2b325f",
    "quake": "#36261e",
    "samcoupe": "#3e6da1",
    "satellaview": "#b7bab7",
    "saturn": "#4b5f7a",
    "saturnjp": "#6d62d3",
    "scummvm": "#c3a254",
    "scv": "#4a8296",
    "sega32x": "#715047",
    "sega32xjp": "#848947",
    "sega32xna": "#715047",
    "segacd": "#8e7a2b",
    "segastv": "#727b28",
    "sf": "#a26237",
    "sfc": "#a77c33",
    "sg-1000": "#42261e",
    "sgb": "#7a977d",
    "snes": "#3f6c94",
    "snesh": "#332418",
    "snesmsu-1": "#57483e",
    "snesmsu1": "#57483e",
    "snesna": "#20213f",
    "socrates": "#3e3b38",
    "solarus": "#623e5e",
    "spectravideo": "#222238",
    "st-v": "#727b28",
    "steam": "#3b424a",
    "stratagus": "#393630",
    "stv": "#727b28",
    "sufami": "#5f7ec1",
    "supergb": "#7a977d",
    "supergrafx": "#3a4b2a",
    "supervision": "#4231a3",
    "supracan": "#424550",
    "switch": "#a17d79",
    "symbian": "#4c201e",
    "tanodragon": "#634c24",
    "tg-cd": "#6c2723",
    "tg16": "#cba490",
    "tg16cd": "#6c2723",
    "thextech": "#a5703c",
    "thomson": "#544839",
    "ti99": "#3a3f4d",
    "tic80": "#31346d",
    "to8": "#544839",
    "triforce": "#706752",
    "trs-80": "#a19e9c",
    "tutor": "#75ab3b",
    "tvgames": "#43458d",
    "type-x": "#591d1c",
    "tyrquake": "#36261e",
    "uzebox": "#cfa468",
    "vc4000": "#070202",
    "vectrex": "#62778e",
    "vic20": "#4b281d",
    "videopac": "#4d2c2f",
    "videopacplus": "#274c40",
    "virtualboy": "#74667b",
    "vis": "#5c4f4b",
    "vpinball": "#d49174",
    "vsmile": "#574d2f",
    "wasm4": "#c88857",
    "wii": "#46593c",
    "wiiu": "#6d5c5a",
    "windows": "#3c534a",
    "windows3x": "#4f3628",
    "windows9x": "#3e3838",
    "wonderswan": "#57638f",
    "wonderswancolor": "#b3957a",
    "x1": "#6e7b73",
    "x68000": "#402822",
    "xbox": "#3d4233",
    "xbox360": "#9d5d33",
    "xegs": "#5474aa",
    "zelda": "#6a593d",
    "zeldac": "#6a593d",
    "zmachine": "#4a4841",
    "zx81": "#7a4629",
    "zxnext": "#1b393b",
    "zxspectrum": "#413a2c"
};

var gameSystems = [
    {
        shortName: "archimedes",
        systemName: "Acorn Archimedes",
        releaseYear: 1987,
        description: "The Acorn Archimedes is a family of personal computers designed by Acorn Computers of Cambridge, England. The systems are based on Acorn's own ARM architecture processors and the proprietary operating systems Arthur and RISC OS."
    },
{
    shortName: "androidapps",
    systemName: "Android Apps",
    releaseYear: "Various",
    description: "View and use your favorite Android Apps."
},
{
    shortName: "easyrpg",
    systemName: "EasyRPG",
    releaseYear: 2007,
    description: "EasyRPG is a free, open source engine to create RPG games, aiming to be also compatible with all RPG Maker 2000 and RPG Maker 2003 games. RPG Maker 2000/2003 games tend to have mechanics and visuals similar to 16-bit JRPGs, though custom scripts can be made by the creators to modify how the game feels and looks."
},
{
    shortName: "ags",
    systemName: "Adventure Game Studio",
    releaseYear: 1997,
    description: "Adventure Game Studio (AGS) is an open source development tool primarily used to create graphic adventure games. It is aimed at intermediate-level game designers, and combines an integrated development environment (IDE) with a scripting language based on the C programming language to process game logic."
},
{
    shortName: "auto-huntingandfishing",
    systemName: "Hunting and Fishing",
    releaseYear: "Various",
    description: "View and play the Hunting and Fishing games across your entire library."
},
{
    shortName: "atarijaguarcd",
    systemName: "Atari Jaguar CD",
    releaseYear: 1995,
    description: "The Atari Jaguar CD is a fifth generation (1993–2005) CD-ROM peripheral for the Atari Jaguar video game console developed and distributed by Atari Corporation. It was released in September 1995 in North America at a retail price of $149."
},
{
    shortName: "amiga600",
    systemName: "Amiga 600",
    releaseYear: 1985,
    description: "The Amiga is a family of personal computers marketed by Commodore in the 1980s and 1990s. The first model was launched in 1985 as a high-end home computer and became popular for its graphical, audio and multi-tasking abilities."
},
{
    shortName: "arcade",
    systemName: "Arcade",
    releaseYear: "Various",
    description: "An arcade game or coin-op is a coin-operated entertainment machine typically installed in public businesses such as restaurants, bars and amusement arcades. Most arcade games are video games, pinball machines, electro-mechanical games, redemption games or merchandisers."
},
{
    shortName: "auto-at4players",
    systemName: "4 Player",
    releaseYear: "Various",
    description: "View and play the 4 player games across your entire library."
},
{
    shortName: "nds",
    systemName: "Nintendo DS",
    releaseYear: 2004,
    description: "The Nintendo DS or simply, DS, is a 32-bit dual-screen handheld game console developed and released by Nintendo. The device went on sale in North America on November 21, 2004."
},
{
    shortName: "fds",
    systemName: "Famicom Disk System",
    releaseYear: 1986,
    description: "The Family Computer Disk System, sometimes shortened as the Famicom Disk System or simply the Disk System, and abbreviated as the FDS or FCD, is a peripheral for Nintendo's Family Computer home video game console, released in Japan on February 21, 1986. It uses proprietary floppy disks called 'Disk Cards' for data storage."
},
{
    shortName: "lutris",
    systemName: "Lutris",
    releaseYear: 2010,
    description: "Lutris is a free and open source game manager for Linux-based operating systems developed and maintained by Mathieu Comandon and the community, released"
},
{
    shortName: "ps3",
    systemName: "PlayStation 3",
    releaseYear: 2006,
    description: "The PlayStation 3 (PS3) is a home video game console developed by Sony Computer Entertainment. It is the successor to PlayStation 2, and is part of the PlayStation brand of consoles. The console was first officially announced at E3 2005, and was released at the end of 2006. It was the first console to use Blu-ray Disc as its primary storage medium."
},
{
    shortName: "mame",
    systemName: "MAME",
    releaseYear: 1997,
    description: "MAME (formerly an acronym of Multiple Arcade Machine Emulator) is a free and open-source emulator designed to recreate the hardware of arcade game systems in software on modern personal computers and other platforms. Its intention is to preserve gaming history by preventing vintage games from being lost or forgotten."
},
{
    shortName: "3ds",
    systemName: "Nintendo 3DS",
    releaseYear: 2011,
    description: "The Nintendo 3DS, abbreviated to 3DS, is a portable game console produced by Nintendo. It is capable of displaying stereoscopic 3D effects without the use of 3D glasses or additional accessories."
},
{
    shortName: "spectravideo",
    systemName: "Spectravideo",
    releaseYear: 1983,
    description: "Spectravideo International Limited (SVI) was an American computer manufacturer and software house. It was originally called SpectraVision, a company founded by Harry Fox in 1981."
},
{
    shortName: "chailove",
    systemName: "ChaiLove Framework",
    releaseYear: 2017,
    description: "ChaiLove is an awesome framework you can use to make 2D games in ChaiScript. It's free, open-source, and works on Windows, Mac OS X, Linux, Android, and ARM through libretro/RetroArch."
},
{
    shortName: "vpinball",
    systemName: "Visual Pinball",
    releaseYear: 2000,
    description: "Visual Pinball is a freeware and source available video game engine for pinball tables and similar games such as pachinko machines. It includes a table editor as well as the simulator itself, and runs on Microsoft Windows."
},
{
    shortName: "gamegear",
    systemName: "Game Gear",
    releaseYear: 1990,
    description: "The Game Gear is an 8-bit fourth generation handheld game console released by Sega on October 6, 1990 in Japan, in April 1991 throughout North America and Europe, and during 1992 in Australia."
},
{
    shortName: "gx4000",
    systemName: "GX4000",
    releaseYear: 1990,
    description: "The Amstrad GX4000, commonly known as the GX4000, is a third generation (1983-2003) video game console developed and distributed by Amstrad. It was released in September of 1990 in Europe at a retail price of £99,"
},
{
    shortName: "neogeo",
    systemName: "Neo Geo",
    releaseYear: 1990,
    description: "The Advanced Entertainment System (AES), originally known just as the Neo Geo, is the first video game console in the family. The hardware features comparatively colorful 2D graphics."
},
{
    shortName: "ti99",
    systemName: "TI-99/4",
    releaseYear: 1981,
    description: "The TI-99/4 is a home computer released in late 1979 by Texas Instruments. Based on the Texas Instruments TMS9900 microprocessor originally used in minicomputers, it was the first 16-bit home computer. It includes a simplified internal design, a full-travel keyboard, improved graphics, and a unique expansion system. At half the price of the original model, sales picked up significantly. TI supported the 4A with peripherals, including a speech synthesizer and a 'Peripheral Expansion System' box to contain hardware add-ons. TI released developer information and tools, but the insistence on remaining sole publisher continued to starve the platform of software."
},
{
    shortName: "auto-adventure",
    systemName: "Adventure",
    releaseYear: "Various",
    description: "View and play the adventure games across your entire library."
},
{
    shortName: "c64",
    systemName: "Commodore 64",
    releaseYear: 1982,
    description: "The Commodore 64 is an 8-bit home computer introduced in January 1982 by Commodore International. It is listed in the Guinness World Records as the highest-selling single computer model of all time, with independent estimates placing the number sold between 10 and 17 million units."
},
{
    shortName: "tools",
    systemName: "Tools",
    releaseYear: "Various",
    description: "Programs, scripts and utilities to manage your set up."
},
{
    shortName: "atari2600",
    systemName: "Atari 2600",
    releaseYear: 1977,
    description: "The Atari Video Computer System (VCS), later named the Atari 2600, is a second generation (1976–1992) home video game console developed and distributed by Atari, Inc. It was released on September 11, 1977 in North America at a retail price of $199."
},
{
    shortName: "sfc",
    systemName: "Super Famicom",
    releaseYear: 1990,
    description: "The Super Famicom is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America."
},
{
    shortName: "doom",
    systemName: "Doom",
    releaseYear: 1993,
    description: "Doom is a 1993 first-person shooter (FPS) game developed by id Software for MS-DOS. Players assume the role of a space marine, popularly known as Doomguy, fighting their way through hordes of invading demons from hell."
},
{
    shortName: "symbian",
    systemName: "Symbian",
    releaseYear: 1997,
    description: "Symbian is a discontinued mobile operating system (OS) and computing platform designed for smartphones. It was originally developed as a proprietary software OS for personal digital assistants in 1998 by the Symbian Ltd."
},
{
    shortName: "gbch",
    systemName: "GBC Hacks",
    releaseYear: 1998,
    description: "The Game Boy Color, (abbreviated as GBC) is a handheld game console manufactured by Nintendo, which was released on October 21, 1998 in Japan and was released in November of the same year in international markets. It is the successor of the Game Boy."
},
{
    shortName: "snesmsu-1",
    systemName: "Super Disc System",
    releaseYear: "Unreleased",
    description: "The Super NES CD-ROM System is an unreleased video game peripheral for the Super Nintendo Entertainment System (SNES). The add-on built upon the functionality of the cartridge-based SNES by adding support for a CD-ROM-based format known as Super Disc. The SNES-CD platform was developed in a partnership between Nintendo and Sony."
},
{
    shortName: "thextech",
    systemName: "TheXTech",
    releaseYear: 2020,
    description: "TheXTech is a free and open-source game engine for Mario-like platforming games. There is a complete and extended source code port of the Super Mario Bros."
},
{
    shortName: "naomigd",
    systemName: "Naomi GD-ROM",
    releaseYear: 1998,
    description: "The NAOMI (New Arcade Operation Machine Idea) is an arcade system released by Sega in 1998. It was designed as a successor to Sega Model 3 hardware, using a similar architecture to the Sega Dreamcast."
},
{
    shortName: "supracan",
    systemName: "Super A'can",
    releaseYear: 1995,
    description: "The Super A'can is a home video game console released exclusively in Taiwan in 1995 by Funtech/Dunhuang Technology. It is based around the Motorola 68000 microchip, which is also used in the Sega Genesis and Neo Geo."
},
{
    shortName: "mplayer",
    systemName: "Media Player",
    releaseYear: "Various",
    description: "Play the media in your collection."
},
{
    shortName: "auto-shooter",
    systemName: "Shooter",
    releaseYear: "Various",
    description: "View and play the Shooter games across your entire library."
},
{
    shortName: "gb",
    systemName: "Game Boy",
    releaseYear: 1989,
    description: "The Game Boy is an 8-bit handheld video game console developed and manufactured by Nintendo. It was released in Japan on April 21, 1989, in North America in August 1989, and in Europe in 1990."
},
{
    shortName: "tic80",
    systemName: "TIC-80",
    releaseYear: 2017,
    description: "TIC-80 is a free and open source fantasy computer for making, playing and sharing tiny games. There are built-in tools for development: code, sprites, maps, sound editors and the command line, which is enough to create a mini retro game."
},
{
    shortName: "cps2",
    systemName: "CPS-II",
    releaseYear: 1993,
    description: "The CP System II (CPS-2) is an arcade system board that Capcom first used in 1993 for Super Street Fighter II. It was the successor to their previous CP System and Capcom Power System Changer arcade hardware and was succeeded by the CP System III hardware in 1996."
},
{
    shortName: "scv",
    systemName: "Super Cassette Vision",
    releaseYear: 1984,
    description: "Epoch's original Cassette Vision was introduced in Japan by Epoch in 1981, which had steady sales and took over 70% of the Japanese home console market at the time, with around 400,000 units sold. However, the introduction of next-generation systems from Nintendo, Casio and Sega quickly pushed back the original Cassette Vision, leading Epoch to quickly develop a successor."
},
{
    shortName: "wonderswancolor",
    systemName: "WonderSwan Color",
    releaseYear: 2000,
    description: "The WonderSwan is a handheld game console released in Japan by Bandai. It was developed by Gunpei Yokoi's company Koto Laboratory and Bandai, and was the last piece of hardware Yokoi developed before his death in 1997. Released in 1999 in the fifth generation of video game consoles, the WonderSwan and its two later models, the WonderSwan Color and SwanCrystal were officially supported until being discontinued by Bandai in 2003. During its lifespan, no variation of the WonderSwan was released outside of Japan."
},
{
    shortName: "megadrivejp",
    systemName: "Mega Drive",
    releaseYear: 1988,
    description: "The Mega Drive is a 16-bit fourth-generation home video game console developed and sold by Sega. It's Sega's third console and the successor to the Master System."
},
{
    shortName: "wonderswan",
    systemName: "WonderSwan",
    releaseYear: 1999,
    description: "The WonderSwan is a handheld game console released in Japan by Bandai. It was developed by Gunpei Yokoi's company Koto Laboratory and Bandai, and was the last piece of hardware Yokoi developed before his death in 1997. Released in 1999 in the fifth generation of video game consoles, the WonderSwan and its two later models, the WonderSwan Color and SwanCrystal were officially supported until being discontinued by Bandai in 2003. During its lifespan, no variation of the WonderSwan was released outside of Japan."
},
{
    shortName: "palm",
    systemName: "Palm",
    releaseYear: 1997,
    description: "The PalmPilot Personal and PalmPilot Professional are the second generation of Palm PDA devices produced by Palm Inc (then a subsidiary of U.S."
},
{
    shortName: "cdtv",
    systemName: "CDTV",
    releaseYear: 1991,
    description: "The CDTV (an acronym for 'Commodore Dynamic Total Vision', a backronym of an acronym for 'Compact Disc Television', giving it a double meaning) is a multimedia platform developed by Commodore International and launched in March 1991. The CDTV was intended as a media appliance rather than a personal computer."
},
{
    shortName: "amstradcpc",
    systemName: "Amstrad CPC",
    releaseYear: 1984,
    description: "The Amstrad Colour Personal Computer, better known as the Amstrad CPC, is a series of 8-bit home computers designed by Amstrad. The first models were released in April 1984 in Europe at a retail price ranging from £199 to £299, depending on the package bought."
},
{
    shortName: "xbox",
    systemName: "Xbox",
    releaseYear: 2001,
    description: "Xbox is a video gaming brand created and owned by Microsoft. It represents a series of video game consoles developed by Microsoft, with three consoles released in the sixth, seventh, and eighth generations, respectively. The brand was first introduced in the United States in November 2001, with the launch of the original Xbox console."
},
{
    shortName: "laserdisc",
    systemName: "LaserDisc Games",
    releaseYear: "Various",
    description: "LaserDisc arcade games use pre-recorded video, either in combination with overlaid sprites or simply as sections of video controllable by the player. The first major LaserDisc game was Sega's Astron Belt, released in 1983."
},
{
    shortName: "pcarcade",
    systemName: "PC Arcade Games",
    releaseYear: "Various",
    description: "In the beginning of the 2000s arcade system manufacturers started to move away from custom board designs, and as part of this change many instead adapted the standard PC architecture. There were numerous such designs running Linux or Windows, for instance Sega Lindbergh, Namco System N2 and Taito Type X."
},
{
    shortName: "snesmsu1",
    systemName: "Super Disc System",
    releaseYear: "Unreleased",
    description: "The Super NES CD-ROM System is an unreleased video game peripheral for the Super Nintendo Entertainment System (SNES). The add-on built upon the functionality of the cartridge-based SNES by adding support for a CD-ROM-based format known as Super Disc. The SNES-CD platform was developed in a partnership between Nintendo and Sony. The platform was planned to be launched as an add-on for the standard SNES, as well as a hybrid console by Sony called the PlayStation."
},
{
    shortName: "flash",
    systemName: "Adobe Flash",
    releaseYear: 1996,
    description: "Adobe Flash (formerly Macromedia Flash and FutureSplash) was a multimedia software platform used for production of animations, rich web applications, desktop applications, mobile apps, mobile games, and embedded web browser video players. Flash displays text, vector graphics, and raster graphics to provide animations, video games, and applications."
},
{
    shortName: "dreamcast",
    systemName: "Dreamcast",
    releaseYear: 1998,
    description: "The Dreamcast is a home video game console released by Sega on November 27, 1998 in Japan, September 9, 1999 in North America, and October 14, 1999 in Europe. It was the first in the sixth generation of video game consoles, preceding Sony's PlayStation 2, Nintendo's GameCube, and Microsoft's Xbox."
},
{
    shortName: "auto-action",
    systemName: "Action",
    releaseYear: "Various",
    description: "View and play the action games across your entire library."
},
{
    shortName: "sega32xna",
    systemName: "Sega 32X",
    releaseYear: 1994,
    description: "The 32X is an add-on for the Sega Mega Drive/Genesis video game console. Codenamed 'Project Mars', the 32X was designed to expand the power of the Mega Drive/Genesis and serve as a transitional console into the 32-bit era until the release of the Sega Saturn. Unveiled by Sega at June 1994's Consumer Electronics Show, the 32X was presented as a low-cost option for consumers looking to play 32-bit games."
},
{
    shortName: "msx",
    systemName: "MSX",
    releaseYear: 1983,
    description: "MSX is a standardized home computer architecture, announced by Microsoft and ASCII Corporation on June 16, 1983. It was initially conceived by Microsoft as a product for the Eastern sector, and jointly marketed by Kazuhiko Nishi, then vice-president at Microsoft and director at ASCII Corporation."
},
{
    shortName: "scv",
    systemName: "Super Cassette Vision",
    releaseYear: 1984,
    description: "Epoch's original Cassette Vision was introduced in Japan by Epoch in 1981, which had steady sales and took over 70% of the Japanese home console market at the time, with around 400,000 units sold. However, the introduction of next-generation systems from Nintendo, Casio and Sega quickly pushed back the original Cassette Vision, leading Epoch to quickly develop a successor."
},
{
    shortName: "wonderswancolor",
    systemName: "WonderSwan Color",
    releaseYear: 2000,
    description: "The WonderSwan is a handheld game console released in Japan by Bandai. It was developed by Gunpei Yokoi's company Koto Laboratory and Bandai, and was the last piece of hardware Yokoi developed before his death in 1997. Released in 1999 in the fifth generation of video game consoles, the WonderSwan and its two later models, the WonderSwan Color and SwanCrystal were officially supported until being discontinued by Bandai in 2003. During its lifespan, no variation of the WonderSwan was released outside of Japan."
},
{
    shortName: "megadrivejp",
    systemName: "Mega Drive",
    releaseYear: 1988,
    description: "The Mega Drive is a 16-bit fourth-generation home video game console developed and sold by Sega. It's Sega's third console and the successor to the Master System."
},
{
    shortName: "wonderswan",
    systemName: "WonderSwan",
    releaseYear: 1999,
    description: "The WonderSwan is a handheld game console released in Japan by Bandai. It was developed by Gunpei Yokoi's company Koto Laboratory and Bandai, and was the last piece of hardware Yokoi developed before his death in 1997. Released in 1999 in the fifth generation of video game consoles, the WonderSwan and its two later models, the WonderSwan Color and SwanCrystal were officially supported until being discontinued by Bandai in 2003. During its lifespan, no variation of the WonderSwan was released outside of Japan."
},
{
    shortName: "palm",
    systemName: "Palm",
    releaseYear: 1997,
    description: "The PalmPilot Personal and PalmPilot Professional are the second generation of Palm PDA devices produced by Palm Inc (then a subsidiary of U.S."
},
{
    shortName: "cdtv",
    systemName: "CDTV",
    releaseYear: 1991,
    description: "The CDTV (an acronym for 'Commodore Dynamic Total Vision', a backronym of an acronym for 'Compact Disc Television', giving it a double meaning) is a multimedia platform developed by Commodore International and launched in March 1991. The CDTV was intended as a media appliance rather than a personal computer."
},
{
    shortName: "amstradcpc",
    systemName: "Amstrad CPC",
    releaseYear: 1984,
    description: "The Amstrad Colour Personal Computer, better known as the Amstrad CPC, is a series of 8-bit home computers designed by Amstrad. The first models were released in April 1984 in Europe at a retail price ranging from £199 to £299, depending on the package bought."
},
{
    shortName: "xbox",
    systemName: "Xbox",
    releaseYear: 2001,
    description: "Xbox is a video gaming brand created and owned by Microsoft. It represents a series of video game consoles developed by Microsoft, with three consoles released in the sixth, seventh, and eighth generations, respectively. The brand was first introduced in the United States in November 2001, with the launch of the original Xbox console."
},
{
    shortName: "laserdisc",
    systemName: "LaserDisc Games",
    releaseYear: "Various",
    description: "LaserDisc arcade games use pre-recorded video, either in combination with overlaid sprites or simply as sections of video controllable by the player. The first major LaserDisc game was Sega's Astron Belt, released in 1983."
},
{
    shortName: "pcarcade",
    systemName: "PC Arcade Games",
    releaseYear: "Various",
    description: "In the beginning of the 2000s arcade system manufacturers started to move away from custom board designs, and as part of this change many instead adapted the standard PC architecture. There were numerous such designs running Linux or Windows, for instance Sega Lindbergh, Namco System N2 and Taito Type X."
},
{
    shortName: "snesmsu1",
    systemName: "Super Disc System",
    releaseYear: "Unreleased",
    description: "The Super NES CD-ROM System is an unreleased video game peripheral for the Super Nintendo Entertainment System (SNES). The add-on built upon the functionality of the cartridge-based SNES by adding support for a CD-ROM-based format known as Super Disc. The SNES-CD platform was developed in a partnership between Nintendo and Sony. The platform was planned to be launched as an add-on for the standard SNES, as well as a hybrid console by Sony called the PlayStation."
},
{
    shortName: "flash",
    systemName: "Adobe Flash",
    releaseYear: 1996,
    description: "Adobe Flash (formerly Macromedia Flash and FutureSplash) was a multimedia software platform used for production of animations, rich web applications, desktop applications, mobile apps, mobile games, and embedded web browser video players. Flash displays text, vector graphics, and raster graphics to provide animations, video games, and applications."
},
{
    shortName: "dreamcast",
    systemName: "Dreamcast",
    releaseYear: 1998,
    description: "The Dreamcast is a home video game console released by Sega on November 27, 1998 in Japan, September 9, 1999 in North America, and October 14, 1999 in Europe. It was the first in the sixth generation of video game consoles, preceding Sony's PlayStation 2, Nintendo's GameCube, and Microsoft's Xbox."
},
{
    shortName: "auto-action",
    systemName: "Action",
    releaseYear: "Various",
    description: "View and play the action games across your entire library."
},
{
    shortName: "sega32xna",
    systemName: "Sega 32X",
    releaseYear: 1994,
    description: "The 32X is an add-on for the Sega Mega Drive/Genesis video game console. Codenamed 'Project Mars', the 32X was designed to expand the power of the Mega Drive/Genesis and serve as a transitional console into the 32-bit era until the release of the Sega Saturn. Unveiled by Sega at June 1994's Consumer Electronics Show, the 32X was presented as a low-cost option for consumers looking to play 32-bit games."
},
{
    shortName: "msx",
    systemName: "MSX",
    releaseYear: 1983,
    description: "MSX is a standardized home computer architecture, announced by Microsoft and ASCII Corporation on June 16, 1983. It was initially conceived by Microsoft as a product for the Eastern sector, and jointly marketed by Kazuhiko Nishi, then vice-president at Microsoft and director at ASCII Corporation."
},
{
    shortName: "sufami",
    systemName: "SuFami Turbo",
    releaseYear: 1996,
    description: "The SuFami Turbo (スーファミターボ), often compared to the Aladdin Deck Enhancer, is an accessory released by Bandai for Nintendo's Super Famicom system and was released in 1996."
},
{
    shortName: "st-v",
    systemName: "ST-V",
    releaseYear: 1994,
    description: "ST-V (Sega Titan Video) is an arcade system board released by Sega, in 1994 for Japan and 1995 worldwide. Departing from their usual process of building custom arcade hardware, Sega's ST-V is essentially identical to the Sega Saturn home console system."
},
{
    shortName: "pce-cd",
    systemName: "PC Engine CD-ROM²",
    releaseYear: 1988,
    description: "The CD-ROM² (pronounced CD-ROM-ROM) is an add-on attachment for the PC Engine that was released in Japan on December 4, 1988. The add-on allows the core versions of the console to play PC Engine games in CD-ROM format in addition to standard HuCards.\n\nIt was later released as the TurboGrafx-CD in the United States in November 1989, with a remodeled interface unit in order to suit the different shape of the TurboGrafx-16 console."
},
{
    shortName: "videopac",
    systemName: "Videopac",
    releaseYear: 1978,
    description: "The Magnavox Odyssey 2 (stylized as Magnavox Odyssey²), also known as Philips Odyssey 2, is a second generation home video game console that was released in 1978. It was sold in Europe as the Philips Videopac G7000, in Brazil as the Philips Odyssey and in Japan as Odyssey2 (オデッセイ2 odessei2)."
},
{
    shortName: "atomiswave",
    systemName: "Atomiswave",
    releaseYear: 2003,
    description: "The Atomiswave is a custom arcade system board and cabinet from Sammy Corporation. It is based on Sega's NAOMI system board (thus it's common to see the \"Sega\" logo on its boot up screen)."
},
{
    shortName: "crvision",
    systemName: "CreatiVision",
    releaseYear: 1982,
    description: "The Video Technology CreatiVision is a hybrid computer and home video game console introduced by VTech in 1981 and released in 1982 during the Second generation of video game consoles. It was built by the Finnish company Salora."
},
{
    shortName: "auto-lightgun",
    systemName: "Light Gun",
    releaseYear: "Various",
    description: "View and play the Light Gun games across your entire library."
},
{
    shortName: "triforce",
    systemName: "Triforce Arcade",
    releaseYear: 2002,
    description: "The Triforce (トライフォース) is an arcade board developed in a joint venture between Sega, Nintendo, and Namco. It is based upon the Nintendo GameCube video game console to reduce development costs, and allowed for arcade ports of home console games, and vice versa."
},
{
    shortName: "mario",
    systemName: "Super Mario",
    releaseYear: "Various",
    description: "View and play the Mario Games in your collection."
},
{
    shortName: "megadrive-japan",
    systemName: "Mega Drive",
    releaseYear: 1988,
    description: "The Mega Drive is a 16-bit fourth-generation home video game console developed and sold by Sega. It's Sega's third console and the successor to the Master System."
},
{
    shortName: "zxnext",
    systemName: "ZX Spectrum Next",
    releaseYear: 2017,
    description: "ZX Spectrum Next is an 8-bit home computer, initially released in 2017, which is compatible with software and hardware for the 1982 ZX Spectrum. It also has enhanced capabilities."
},
{
    shortName: "colecovision",
    systemName: "ColecoVision",
    releaseYear: 1982,
    description: "The ColecoVision is a second generation (1976–1992) home video game console developed and distributed by Coleco Industries. It was released in August 1982 in North America at a retail price of $175."
},
{
    shortName: "music",
    systemName: "Music Player",
    releaseYear: "Various",
    description: "Listen to the music in your collection."
},
{
    shortName: "megacd",
    systemName: "Mega CD",
    releaseYear: 1993,
    description: "The Sega CD, released as the Mega-CD in most regions outside North America and Brazil, is a CD-ROM accessory for the Mega Drive/Genesis designed and produced by Sega as part of the fourth generation of video game consoles. It was released on December 12, 1991 in Japan, October 15, 1992 in North America, and April 2, 1993 in Europe."
},
{
    shortName: "saturnjp",
    systemName: "Sega Saturn",
    releaseYear: 1994,
    description: "The Sega Saturn is a home video game console developed by Sega and released on November 22, 1994 in Japan, May 11, 1995 in North America, and July 8, 1995 in Europe. Part of the fifth generation of video game consoles, it was the successor to the successful Sega Genesis."
},
{
    shortName: "n64dd",
    systemName: "64DD",
    releaseYear: 1999,
    description: "The 64DD, colloquially referred to as the Nintendo 64DD, is a magnetic disk drive peripheral for the Nintendo 64 game console developed by Nintendo. It was originally announced in 1995, prior to the Nintendo 64's 1996 launch, and after numerous delays was finally released only in Japan on December 1, 1999."
},
{
    shortName: "fpinball",
    systemName: "Future Pinball",
    releaseYear: 2005,
    description: "Future Pinball ('FP') is a freeware 3D pinball editing and gaming application for Microsoft Windows. It is similar to Visual Pinball ('VP') and other modern pinball simulation applications."
},
{
    shortName: "oric",
    systemName: "Oric",
    releaseYear: 1982,
    description: "Oric was the name used by UK-based Tangerine Computer Systems for a series of 6502-based home computers sold in the 1980s, primarily in Europe. With the success of the ZX Spectrum from Sinclair Research, Tangerine's backers suggested a home computer and Tangerine formed Oric Products International Ltd to develop the Oric-1."
},
{
    shortName: "camplynx",
    systemName: "Camputers Lynx",
    releaseYear: 1983,
    description: "The Lynx was an 8-bit British home computer that was first released in early 1983 as a 48 kB model. Several models were available with 48 kB, 96 kB or 128 kB RAM."
},
{
    shortName: "atarixe",
    systemName: "Atari XE",
    releaseYear: 1987,
    description: "The Atari XE Video Game System (Atari XEGS) is an industrial redesign of the Atari 65XE home computer and the final model in the Atari 8-bit family. It was released by Atari Corporation in 1987 and marketed as a home video game console alongside the Nintendo Entertainment System, Sega's Master System, and Atari's own Atari 7800."
},
{
    shortName: "auto-retroachievements",
    systemName: "Retroachievements",
    releaseYear: "Various",
    description: "View and play the Retroachievements games across your entire library."
},
{
    shortName: "auto-pinball",
    systemName: "Pinball",
    releaseYear: "Various",
    description: "View and play the Pinball games across your entire library."
},
{
    shortName: "epic",
    systemName: "Epic Games Store",
    releaseYear: 2018,
    description: "The Epic Games Store is a digital video game storefront for Microsoft Windows and macOS, operated by Epic Games. It launched in December 2018 as both a website and a standalone launcher, of which the latter is required to download and play games."
},
{
    shortName: "pcenginecd",
    systemName: "PC Engine CD-ROM²",
    releaseYear: 1988,
    description: "The CD-ROM² (pronounced CD-ROM-ROM) is an add-on attachment for the PC Engine that was released in Japan on December 4, 1988. The add-on allows the core versions of the console to play PC Engine games in CD-ROM format in addition to standard HuCards."
},
{
    shortName: "vgmplay",
    systemName: "Music Player",
    releaseYear: "Various",
    description: "Listen to the music in your collection."
},
{
    shortName: "pcfx",
    systemName: "PC-FX",
    releaseYear: 1994,
    description: "The PC-FX is a 32-bit home video game console developed by both NEC and Hudson Soft and released in Japan in 1994. Powered by an NEC V810 CPU and using CD-ROMs, the PC-FX was intended as the successor to the PC Engine and its international counterpart the TurboGrafx-16, two successful video game consoles from the late 1980s."
},
{
    shortName: "quake",
    systemName: "Quake",
    releaseYear: 1996,
    description: "Quake is a first-person shooter game developed by id Software and published by GT Interactive. The first game in the Quake series, it was originally released for MS-DOS, Microsoft Windows and Linux in 1996, followed by Mac OS and Sega Saturn in 1997 and Nintendo 64 in 1998."
},
{
    shortName: "to8",
    systemName: "Thomson TO8",
    releaseYear: 1986,
    description: "The Thomson TO8 is a home computer introduced by French company Thomson SA in 1986, with a cost of 2,990 FF. It replaces its predecessor, the Thomson TO7/70, while remaining essentially compatible."
},
{
    shortName: "apfm1000",
    systemName: "APF Imagination Machine",
    releaseYear: 1979,
    description: "The APF Imagination Machine is a combination home video game console and computer system released by APF Electronics Inc. in late 1979."
},
{
    shortName: "psp",
    systemName: "PlayStation Portable",
    releaseYear: 2004,
    description: "The PlayStation Portable (PSP) is a handheld game console developed and marketed by Sony Computer Entertainment. It was first released in Japan on December 12, 2004, in North America on March 24, 2005, and in PAL regions on September 1, 2005, and is the first handheld installment in the PlayStation line of consoles."
},
{
    shortName: "apple2gs",
    systemName: "Apple IIGS",
    releaseYear: 1986,
    description: "The Apple IIGS is a personal computer released by Apple Computer on September 15, 1986 that's compatible with the Apple II series, but otherwise has capabilities comparable to the Atari ST, Commodore Amiga, and Macintosh. The \"GS\" in the name stands for \"Graphics\" and \"Sound,\" referring to its enhanced multimedia hardware, especially its state of the art sound and music synthesis."
},
{
    shortName: "stv",
    systemName: "ST-V",
    releaseYear: 1994,
    description: "ST-V (Sega Titan Video) is an arcade system board released by Sega, in 1994 for Japan and 1995 worldwide. Departing from their usual process of building custom arcade hardware, Sega's ST-V is essentially identical to the Sega Saturn home console system."
},
{
    shortName: "gamecom",
    systemName: "Game.com",
    releaseYear: 1997,
    description: "The Game.com is a fifth-generation handheld game console released by Tiger Electronics in August 1997.\nThe first version of the Game.com can be connected to a 14.4 kbit/s modem for Internet connectivity, hence its name referencing the top level domain .com."
},
{
    shortName: "fmtowns",
    systemName: "FM Towns",
    releaseYear: 1989,
    description: "The FM Towns (Japanese: エフエムタウンズ, Hepburn: Efu Emu Taunzu) is a Japanese personal computer built by Fujitsu from February 1989 to the summer of 1997. It started as a proprietary PC variant intended for multimedia applications and PC games, but later became more compatible with IBM PC compatibles."
},
{
    shortName: "naomi",
    systemName: "Naomi",
    releaseYear: 1998,
    description: "The NAOMI (New Arcade Operation Machine Idea) is an arcade system released by Sega in 1998. It was designed as a successor to Sega Model 3 hardware, using a similar architecture to the Sega Dreamcast."
},
{
    shortName: "zx81",
    systemName: "ZX81",
    releaseYear: 1981,
    description: "The ZX81 is a home computer that was produced by Sinclair Research and manufactured in Dundee, Scotland, by Timex Corporation. It was launched in the United Kingdom in March 1981 as the successor to Sinclair's ZX80 and designed to be a low-cost introduction to home computing for the general public."
},
{
    shortName: "apps",
    systemName: "Google Android",
    releaseYear: 2008,
    description: "Android is a mobile operating system based on a modified version of the Linux kernel and other open-source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. Android is developed by a consortium of developers known as the Open Handset Alliance, though its most widely used version is primarily developed by Google."
},
{
    shortName: "pc",
    systemName: "IBM PC",
    releaseYear: 1981,
    description: "The IBM Personal Computer (model 5150, commonly known as the IBM PC) is the first microcomputer released in the IBM PC model line and the basis for the IBM PC compatible de facto standard. Released on August 12, 1981, it was created by a team of engineers and designers directed by Don Estridge in Boca Raton, Florida."
},
{
    shortName: "msx1",
    systemName: "MSX 1",
    releaseYear: 1983,
    description: "MSX is a standardized home computer architecture, announced by Microsoft and ASCII Corporation on June 16, 1983. It was initially conceived by Microsoft as a product for the Eastern sector, and jointly marketed by Kazuhiko Nishi, then vice-president at Microsoft and director at ASCII Corporation."
},
{
    shortName: "custom-collections",
    systemName: "Custom Collections",
    releaseYear: "Various",
    description: "Organize your games into custom collections."
},
{
    shortName: "amiga",
    systemName: "Amiga",
    releaseYear: 1985,
    description: "The Amiga is a family of personal computers marketed by Commodore in the 1980s and 1990s. The first model was launched in 1985 as a high-end home computer and became popular for its graphical, audio and multi-tasking abilities."
},
{
    shortName: "msx2",
    systemName: "MSX 2",
    releaseYear: 1985,
    description: "MSX is a standardized home computer architecture, announced by Microsoft and ASCII Corporation on June 16, 1983. It was initially conceived by Microsoft as a product for the Eastern sector, and jointly marketed by Kazuhiko Nishi, then vice-president at Microsoft and director at ASCII Corporation."
},
{
    shortName: "auto-fight",
    systemName: "Fighting",
    releaseYear: "Various",
    description: "View and play the Fighting games across your entire library."
},
{
    shortName: "megadrive",
    systemName: "Mega Drive",
    releaseYear: 1990,
    description: "The Mega Drive is a 16-bit fourth-generation home video game console developed and sold by Sega. It's Sega's third console and the successor to the Master System."
},
{
    shortName: "auto-strategy",
    systemName: "Strategy",
    releaseYear: "Various",
    description: "View and play the Strategy games across your entire library."
},
{
    shortName: "psvita",
    systemName: "PlayStation Vita",
    releaseYear: 2011,
    description: "The PlayStation Vita (PS Vita, or Vita) is a handheld video game console developed and marketed by Sony Interactive Entertainment. It was first released in Japan on December 17, 2011, and in North America, Europe, and other international territories beginning on February 22, 2012."
},
{
    shortName: "sgb",
    systemName: "Super Game Boy",
    releaseYear: 1994,
    description: "The Super Game Boy (スーパーゲームボーイ, Sūpā Gēmu Bōi) is a peripheral that allows Game Boy cartridges to be played on a Super Nintendo Entertainment System console, compatible with the same cartridges as the original Game Boy: original Game Boy cartridges, the Game Boy Camera, and dual-mode Game Boy Color cartridges (in Game Boy-mode)."
},
{
    shortName: "vic20",
    systemName: "VIC-20",
    releaseYear: 1980,
    description: "The Commodore VIC-20 (known as the VC-20 in Germany and the VIC-1001 in Japan) is an 8-bit home computer that was sold by Commodore Business Machines. The VIC-20 was announced in 1980, roughly three years after Commodore's first personal computer, the PET."
},
{
    shortName: "androidgames",
    systemName: "Android Games",
    releaseYear: "Various",
    description: "View and play your favorite Android Games."
},
{
    shortName: "plugnplay",
    systemName: "Plug and Play TV Games",
    releaseYear: "Various",
    description: "View and play your plug and play TV games."
},
{
    shortName: "segacd",
    systemName: "Sega CD",
    releaseYear: 1992,
    description: "The Sega CD, released as the Mega-CD in most regions outside North America and Brazil, is a CD-ROM accessory for the Mega Drive/Genesis designed and produced by Sega as part of the fourth generation of video game consoles. It was released on December 12, 1991 in Japan, October 15, 1992 in North America, and April 2, 1993 in Europe."
},
{
    shortName: "atarijaguar",
    systemName: "Atari Jaguar",
    releaseYear: 1993,
    description: "The Atari Jaguar is a fifth generation (1993–2005) video game console developed and distributed by Atari Corporation. It was released in November 1993 in North America at a retail price of $249."
},
{
    shortName: "zmachine",
    systemName: "Z-machine",
    releaseYear: 1979,
    description: "The Z-machine is a virtual machine that was developed by Joel Berez and Marc Blank in 1979 and used by Infocom for its text adventure games. Infocom compiled game code to files containing Z-machine instructions (called story files or Z-code files) and could therefore port its text adventures to a new platform simply by writing a Z-machine implementation for that platform."
},
{
    shortName: "snesna",
    systemName: "Super Nintendo",
    releaseYear: 1991,
    description: "The Super Nintendo Entertainment System (also known as the Super NES, SNES or Super Nintendo) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America. In Japan, the system is called the Super Famicom, officially adopting the abbreviated name of its predecessor, the Family Computer, or SFC for short."
},
{
    shortName: "tg16cd",
    systemName: "TurboGrafx-CD",
    releaseYear: 1989,
    description: "The CD-ROM² (pronounced CD-ROM-ROM) is an add-on attachment for the PC Engine that was released in Japan on December 4, 1988. The add-on allows the core versions of the console to play PC Engine games in CD-ROM format in addition to standard HuCards."
},
{
    shortName: "cps3",
    systemName: "CPS-III",
    releaseYear: 1996,
    description: "The CP System III (CPシステムIII, shīpī shisutemu surī) or CPS-3 is an arcade system board that was first used by Capcom in 1996 with the arcade game Red Earth. It was the second successor to the CP System arcade hardware, following the CP System II."
},
{
    shortName: "pspminis",
    systemName: "Sony PSP Minis",
    releaseYear: 2009,
    description: "PlayStation minis launched on October 1, 2009 for the PSP and the PSPGo in all regions. Under 100MB these games are smaller, cheaper, and download only."
},
{
    shortName: "sega32xjp",
    systemName: "Super 32X",
    releaseYear: 1994,
    description: "The 32X is an add-on for the Sega Mega Drive/Genesis video game console. Codenamed \"Project Mars\", the 32X was designed to expand the power of the Mega Drive/Genesis and serve as a transitional console into the 32-bit era until the release of the Sega Saturn."
},
{
    shortName: "thomson",
    systemName: "Thomson TO8",
    releaseYear: 1986,
    description: "The Thomson TO8 is a home computer introduced by French company Thomson SA in 1986, with a cost of 2,990 FF. It replaces its predecessor, the Thomson TO7/70, while remaining essentially compatible."
},
{
    shortName: "auto-verticalarcade",
    systemName: "Vertical Arcade",
    releaseYear: "Various",
    description: "View and play the Vertical Arcade games across your entire library."
},
{
    shortName: "gp32",
    systemName: "GamePark GP32",
    releaseYear: 2001,
    description: "The GP32 (GamePark 32) is a handheld game console developed by the Korean company Game Park. It was released on November 23, 2001, in South Korea only."
},
{
    shortName: "n3ds",
    systemName: "Nintendo 3DS",
    releaseYear: 2011,
    description: "The Nintendo 3DS, abbreviated to 3DS, is a portable game console produced by Nintendo. It is capable of displaying stereoscopic 3D effects without the use of 3D glasses or additional accessories."
},
{
    shortName: "gbc",
    systemName: "Game Boy Color",
    releaseYear: 1998,
    description: "The Game Boy Color, (abbreviated as GBC) is a handheld game console manufactured by Nintendo, which was released on October 21, 1998 in Japan and was released in November of the same year in international markets. It is the successor of the Game Boy."
},
{
    shortName: "auto-puzzle",
    systemName: "Puzzle",
    releaseYear: "Various",
    description: "View and play the Puzzle games across your entire library."
},
{
    shortName: "virtualboy",
    systemName: "Virtual Boy",
    releaseYear: 1995,
    description: "The Virtual Boy is a 32-bit tabletop portable video game console developed and manufactured by Nintendo. Released in 1995, it was marketed as the first console capable of displaying stereoscopic \"3D\" graphics."
},
{
    shortName: "nes",
    systemName: "Nintendo",
    releaseYear: 1985,
    description: "The Nintendo Entertainment System is an 8-bit video game console that was released by Nintendo in North America during 1985, in Europe during 1986 and Australia in 1987. In most of Asia, including Japan (where it was first launched in 1983), China, Vietnam, Singapore, the Middle East and Hong Kong, it was released as the Family Computer, commonly shortened as either the romanized contraction Famicom, or abbreviated to FC."
},
{
    shortName: "emulators",
    systemName: "Emulators",
    releaseYear: "Various",
    description: "Modify your Emulator settings and configurations"
},
{
    shortName: "ngpc",
    systemName: "Neo Geo Pocket Color",
    releaseYear: 1999,
    description: "The Neo Geo Pocket Color is a 16-bit color handheld video game console manufactured by SNK. It is a successor to SNK's monochrome Neo Geo Pocket handheld which debuted in 1998 in Japan, with the Color being fully backward compatible."
},
{
    shortName: "vsmile",
    systemName: "V.Smile",
    releaseYear: 2004,
    description: "The V.Smile (stylized as V.\nSeveral variants of the V.Smile console are sold including handheld versions, or models with added functionality such as touch tablet integrated controllers or microphones. The V-Motion is a major variant with its own software lineup that includes motion sensitive controllers, and has Smartriges designed to take advantage of motion-related \"active learning\"."
},
{
    shortName: "mastersystem",
    systemName: "Master System",
    releaseYear: 1986,
    description: "The Sega Master System is a third-generation 8-bit home video game console manufactured by Sega. It was originally a remodeled export version of the Sega Mark III, the third iteration of the SG-1000 series of consoles, which was released in Japan in 1985 and featured enhanced graphical capabilities over its predecessors."
},
{
    shortName: "supervision",
    systemName: "Supervision",
    releaseYear: 1992,
    description: "The Watara Supervision, also known as the QuickShot Supervision in the UK, is a monochrome handheld game console, originating from Asia, and introduced in 1992 as a cut-price competitor for Nintendo's Game Boy. It came packaged with a game called Crystball, which is similar to Breakout."
},
{
    shortName: "n64",
    systemName: "Nintendo 64",
    releaseYear: 1996,
    description: "Named for its 64-bit central processing unit, it was released in June 1996 in Japan, September 1996 in North America, March 1997 in Europe and Australia, September 1997 in France and December 1997 in Brazil. As part of the fifth generation of gaming, the N64 competed primarily with the PlayStation and the Sega Saturn."
},
{
    shortName: "x68000",
    systemName: "X68000",
    releaseYear: 1987,
    description: "The X68000 (Japanese: エックス ろくまんはっせん, Hepburn: Ekkusu Rokuman Hassen) is a home computer created by Sharp Corporation, first released in 1987, sold only in Japan."
},
{
    shortName: "nesh",
    systemName: "Nintendo Hacks",
    releaseYear: 1985,
    description: "The Nintendo Entertainment System is an 8-bit video game console that was released by Nintendo in North America during 1985, in Europe during 1986 and Australia in 1987. In most of Asia, including Japan (where it was first launched in 1983), China, Vietnam, Singapore, the Middle East and Hong Kong, it was released as the Family Computer, commonly shortened as either the romanized contraction Famicom, or abbreviated to FC."
},
{
    shortName: "samcoupe",
    systemName: "SAM Coupé",
    releaseYear: 1989,
    description: "The SAM Coupé (pronounced /sæm ku:peɪ/ from its original British English branding) is an 8-bit British home computer that was first released in late 1989. It was based on and designed to have compatibility with the ZX Spectrum 48K and marketed as a logical upgrade from the Spectrum."
},
{
    shortName: "odyssey2",
    systemName: "Odyssey²",
    releaseYear: 1978,
    description: "The Magnavox Odyssey 2 is a second generation (1976–1992) home video game console developed and distributed by Magnavox. It was released in February 1979 in North America at a retail price of $179."
},
{
    shortName: "naomi2",
    systemName: "Naomi 2",
    releaseYear: 2000,
    description: "The Sega NAOMI 2 is an arcade board developed by Sega and is a successor to Sega NAOMI hardware. It was originally released in 2000."
},
{
    shortName: "genh",
    systemName: "Sega Genesis Hacks",
    releaseYear: 1989,
    description: "The Sega Genesis, known as the Mega Drive in most regions outside North America, is a 16-bit home video game console which was developed and sold by Sega Enterprises, Ltd. The Genesis was Sega's third console and the successor to the Master System."
},
{
    shortName: "switch",
    systemName: "Nintendo Switch",
    releaseYear: 2017,
    description: "The Nintendo Switch is an eighth generation (2012-present) home video game console developed and distributed by Nintendo. It was released on March 3, 2017 in North America at a retail price of $299."
},
{
    shortName: "kodi",
    systemName: "Kodi",
    releaseYear: 2002,
    description: "Kodi is a free and open-source media player software application developed by the XBMC Foundation, a non-profit technology consortium. Kodi is available for multiple operating systems and hardware platforms, with a software 10-foot user interface for use with televisions and remote controls."
},
{
    shortName: "auto-musicanddance",
    systemName: "Music and Dance",
    releaseYear: "Various",
    description: "View and play the Music and Dance games across your entire library."
},
{
    shortName: "laser310",
    systemName: "VTech Laser 310",
    releaseYear: 1984,
    description: "The VTech Laser 310 is a home computer developed by Video Technology. It was released in 1984."
},
{
    shortName: "adam",
    systemName: "Coleco Adam",
    releaseYear: 1983,
    description: "The Coleco Adam is a home computer and expansion device for the ColecoVision by American toy and video game manufacturer Coleco. The Adam was an attempt to follow on the success of the company's ColecoVision video game console."
},
{
    shortName: "auto-educational",
    systemName: "Educational",
    releaseYear: "Various",
    description: "View and play the Educational games across your entire library."
},
{
    shortName: "satellaview",
    systemName: "Satellaview",
    releaseYear: 1995,
    description: "The Satellaview is a satellite modem peripheral for Nintendo's Super Famicom system that was released in Japan in 1995. Available for pre-release orders beginning February 13, 1995, the Satellaview retailed for between ¥14,000 and 18,000 (at the time between USD$141 and 182) and came bundled with the BS-X Game Pak and an 8M Memory Pak."
},
{
    shortName: "tutor",
    systemName: "Tomy Tutor",
    releaseYear: 1983,
    description: "The Tomy Tutor, originally sold in Japan as the Pyuta and in the UK as the Grandstand Tutor, is a home computer produced by the Japanese toymaker Tomy. It was architecturally similar, but not identical, to the Texas Instruments TI-99/4A, and used a similar 16-bit CPU."
},
{
    shortName: "msxturbor",
    systemName: "MSX Turbo R",
    releaseYear: 1991,
    description: "The MSX Turbo R is the last generation of MSX computers that was put to market by a household electronic brand. Only Panasonic was brave enough to put faith in the standard once again, by releasing two different models: the Panasonic FS-A1ST and the Panasonic FS-A1GT."
},
{
    shortName: "fm7",
    systemName: "FM-7",
    releaseYear: 1982,
    description: "The FM-7 (Fujitsu Micro 7) is a home computer created by Fujitsu. It was first released in 1982 and was sold in Japan and Spain."
},
{
    shortName: "plus4",
    systemName: "Commodore Plus/4",
    releaseYear: 1984,
    description: "The Commodore Plus/4 is a home computer released by Commodore International in 1984. The Plus/4 name refers to the four-application ROM-resident office suite (word processor, spreadsheet, database, and graphing); it was billed as the productivity computer with software built in."
},
{
    shortName: "gba",
    systemName: "Game Boy Advance",
    releaseYear: 2001,
    description: "The Game Boy Advance (abbreviated as GBA) is a 32-bit handheld video game console developed, manufactured and marketed by Nintendo as the successor to the Game Boy Color. It was released in Japan on March 21, 2001, in North America on June 11, 2001, in Australia and Europe on June 22, 2001, and in mainland China on June 8, 2004 (iQue Player)."
},
{
    shortName: "advision",
    systemName: "Advision",
    releaseYear: 1982,
    description: "The Arcadia 2001 is a second-generation 8-bit home video game console released by Emerson Radio in May 1982 for a price of US$ 99, several months before the release of ColecoVision. It was discontinued only 18 months later, with a total of 35 games having been released."
},
{
    shortName: "ngp",
    systemName: "Neo Geo Pocket",
    releaseYear: 1998,
    description: "The Neo Geo Pocket is a monochrome handheld game console released by SNK. It was the company's first handheld system and is part of the Neo Geo family."
},
{
    shortName: "auto-beatemup",
    systemName: "Beat 'Em Up",
    releaseYear: "Various",
    description: "View and play the Beat 'Em Up games across your entire library."
},
{
    shortName: "wasm4",
    systemName: "WASM-4",
    releaseYear: 2022,
    description: "WASM-4 is a low-level fantasy game console for building small games with WebAssembly. Game cartridges (ROMs) are small, self-contained ."
},
{
    shortName: "android",
    systemName: "Google Android",
    releaseYear: 2008,
    description: "Android is a mobile operating system based on a modified version of the Linux kernel and other open-source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. Android is developed by a consortium of developers known as the Open Handset Alliance, though its most widely used version is primarily developed by Google."
},
{
    shortName: "socrates",
    systemName: "VTech Socrates",
    releaseYear: 1988,
    description: "The VTech Socrates, usually just referred to as Socrates, is a third generation (1983-2003) video game console developed and distributed by VTech. It was released in July 1988 in North America at a retail price of $129."
},
{
    shortName: "pcengine",
    systemName: "PC Engine",
    releaseYear: 1987,
    description: "The PC Engine is a 16-bit fourth-generation home video game console designed by Hudson Soft and sold by NEC Home Electronics. It was released in Japan in 1987 and in North America in 1989."
},
{
    shortName: "openbor",
    systemName: "Open Beats of Rage",
    releaseYear: 2003,
    description: "Beats of Rage is a fan-made tribute game to Sega's Streets of Rage series. It supplants the original graphics and characters with resources taken from The King of Fighters series, albeit with tongue-in-cheek renames."
},
{
    shortName: "auto-breakout",
    systemName: "Breakout",
    releaseYear: "Various",
    description: "View and play the Breakout games across your entire library."
},
{
    shortName: "lcdgames",
    systemName: "LCD Games",
    releaseYear: "Various",
    description: "Handheld electronic games are very small, portable devices for playing interactive electronic games, often miniaturized versions of video games. The controls, display and speakers are all part of a single unit."
},
{
    shortName: "genesis",
    systemName: "Sega Genesis",
    releaseYear: 1989,
    description: "The Sega Genesis, known as the Mega Drive in most regions outside North America, is a 16-bit home video game console which was developed and sold by Sega Enterprises, Ltd. The Genesis was Sega's third console and the successor to the Master System."
},
{
    shortName: "cps1",
    systemName: "CPS-I",
    releaseYear: 1988,
    description: "The CP System (CPシステム, shīpī shisutemu, CPS for short) is an arcade system board developed by Capcom that ran game software stored on removable daughterboards. More than two dozen arcade titles were released for CPS-1, before Capcom shifted game development over to its successor, the CP System II."
},
{
    shortName: "atom",
    systemName: "Acorn Atom",
    releaseYear: 1980,
    description: "The Acorn Atom is a home computer designed by Acorn Computers Ltd. The computer was released in 1980 in Europe at a retail price ranging from £120 to £200, depending on the package bought."
},
{
    shortName: "multivision",
    systemName: "Othello Multivision",
    releaseYear: 1983,
    description: "The Othello Multivision (オセロマルチビジョン) is a licensed SG-1000 clone manufactured by Tsukuda Original. It exists because Sega's original intention for the SC-3000 computer was to allow other manufacturers to produce compatible computers in the hope of having a worldwide standard."
},
{
    shortName: "arcadia",
    systemName: "Arcadia 2001",
    releaseYear: 1982,
    description: "The Arcadia 2001 is a second-generation 8-bit home video game console released by Emerson Radio in May 1982 for a price of US$ 99, several months before the release of ColecoVision. It was discontinued only 18 months later, with a total of 35 games having been released."
},
{
    shortName: "coco",
    systemName: "Tandy CoCo",
    releaseYear: 1980,
    description: "The RadioShack TRS-80 Color Computer, later marketed as the Tandy Color Computer and sometimes nicknamed the CoCo, is a line of home computers developed and sold by Tandy Corporation. Despite sharing a name with the earlier TRS-80, the Color Computer is a completely different, incompatible system and a radical departure in design and compatibility with its Motorola 6809E processor rather than the Zilog Z80 earlier models were built around."
},
{
    shortName: "auto-compilation",
    systemName: "Compilation",
    releaseYear: "Various",
    description: "View and play the Compilation games across your entire library."
},
{
    shortName: "psx",
    systemName: "PlayStation",
    releaseYear: 1994,
    description: "The Sony PlayStation, or PS for short, is a fifth generation (1993–2005) home video game console developed and distributed by Sony Interactive Entertainment. It was released on December 3, 1994 in Japan at a retail price of ¥37,000."
},
{
    shortName: "saturn",
    systemName: "Sega Saturn",
    releaseYear: 1995,
    description: "The Sega Saturn is a home video game console developed by Sega and released on November 22, 1994 in Japan, May 11, 1995 in North America, and July 8, 1995 in Europe. Part of the fifth generation of video game consoles, it was the successor to the successful Sega Genesis."
},
{
    shortName: "consolearcade",
    systemName: "Console Arcade Games",
    releaseYear: "Various",
    description: "While arcade boards have traditionally been custom designs, there have been a number of systems that were instead based on home console platforms. The first such board was the Nintendo VS."
},
{
    shortName: "arduboy",
    systemName: "Arduboy",
    releaseYear: 2015,
    description: "The Arduboy is a handheld game console with open source software, based on the Arduino hardware platform."
},
{
    shortName: "amiga1200",
    systemName: "Amiga 1200",
    releaseYear: 1985,
    description: "The Amiga is a family of personal computers marketed by Commodore in the 1980s and 1990s. The first model was launched in 1985 as a high-end home computer and became popular for its graphical, audio and multi-tasking abilities."
},
{
    shortName: "megacdjp",
    systemName: "Mega-CD",
    releaseYear: 1991,
    description: "The Sega CD, released as the Mega-CD in most regions outside North America and Brazil, is a CD-ROM accessory for the Mega Drive/Genesis designed and produced by Sega as part of the fourth generation of video game consoles. It was released on December 12, 1991 in Japan, October 15, 1992 in North America, and April 2, 1993 in Europe."
},
{
    shortName: "ngage",
    systemName: "N-Gage",
    releaseYear: 2003,
    description: "The N-Gage is a smartphone combining features of a mobile phone and a handheld game system developed by Nokia, announced on 4 November 2002 and released on 7 October 2003. It runs the original Series 60 platform on Symbian OS v6."
},
{
    shortName: "megaduck",
    systemName: "Mega Duck",
    releaseYear: 1993,
    description: "The Welback Holdings Mega Duck, usually just referred to as Mega Duck, is a fourth generation (1987-2004) handheld video game console developed and distributed by Welback Holdings, but marketed under different names like Creatronic, Videojet, Cougar USA, and Hartung. It was released in August 1993 in Netherlands at a retail price of fl 129 as the Creatronic Mega Duck."
},
{
    shortName: "ps4",
    systemName: "PlayStation 4",
    releaseYear: 2013,
    description: "The PlayStation 4 (PS4) is a home video game console developed by Sony Interactive Entertainment. Announced as the successor to the PlayStation 3 in February 2013, it was launched on November 15, 2013, in North America, November 29, 2013 in Europe, South America and Australia, and on February 22, 2014 in Japan."
},
{
    shortName: "tg-cd",
    systemName: "TurboGrafx-CD",
    releaseYear: 1989,
    description: "The CD-ROM² (pronounced CD-ROM-ROM) is an add-on attachment for the PC Engine that was released in Japan on December 4, 1988. The add-on allows the core versions of the console to play PC Engine games in CD-ROM format in addition to standard HuCards."
},
{
    shortName: "auto-racedriving",
    systemName: "Race Driving",
    releaseYear: "Various",
    description: "View and play the Race Driving games across your entire library."
},
{
    shortName: "windows",
    systemName: "Windows",
    releaseYear: 1985,
    description: "Windows is a group of several proprietary graphical operating system families developed and marketed by Microsoft. Each family caters to a certain sector of the computing industry.\nThe first version of Windows was released on November 20, 1985, as a graphical operating system shell for MS-DOS in response to the growing interest in graphical user interfaces (GUIs)."
},
{
    shortName: "completed",
    systemName: "Completed",
    releaseYear: "Various",
    description: "Keep track of the games you've finished."
},
{
    shortName: "sega32x",
    systemName: "Mega Drive 32X",
    releaseYear: 1994,
    description: "The 32X is an add-on for the Sega Mega Drive/Genesis video game console. Codenamed \"Project Mars\", the 32X was designed to expand the power of the Mega Drive/Genesis and serve as a transitional console into the 32-bit era until the release of the Sega Saturn."
},
{
    shortName: "fbneo",
    systemName: "FinalBurn Neo",
    releaseYear: 2002,
    description: "FinalBurn Neo is a Multiple Arcade Emulator most popular for emulating Neo-Geo, Capcom, Konami, and Cave games. It is developed by the FinalBurn team and originated from FinalBurn by Dave and old MAME versions."
},
{
    shortName: "auto-at2players",
    systemName: "2 Player",
    releaseYear: "Various",
    description: "View and play the 2 player games across your entire library."
},
{
    shortName: "tanodragon",
    systemName: "Tano Dragon",
    releaseYear: 1984,
    description: "The Dragon 32 and Dragon 64 are home computers that were built in the 1980s. The Dragons are very similar to the TRS-80 Color Computer, and were produced for the European market by Dragon Data, Ltd."
},
{
    shortName: "snesnah",
    systemName: "Super Nintendo Hacks",
    releaseYear: 1991,
    description: "The Super Nintendo Entertainment System (also known as the Super NES, SNES or Super Nintendo) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America. In Japan, the system is called the Super Famicom, officially adopting the abbreviated name of its predecessor, the Family Computer, or SFC for short."
},
{
    shortName: "amigacdtv",
    systemName: "CDTV",
    releaseYear: 1991,
    description: "The CDTV (an acronym for \"Commodore Dynamic Total Vision\", a backronym of an acronym for \"Compact Disc Television\", giving it a double meaning) is a multimedia platform developed by Commodore International and launched in March 1991. The CDTV was intended as a media appliance rather than a personal computer."
},
{
    shortName: "zelda",
    systemName: "The Legend of Zelda",
    releaseYear: "Various",
    description: "View and play the Zelda Games in your collection."
},
{
    shortName: "model2",
    systemName: "Sega Model 2",
    releaseYear: 1993,
    description: "The Sega Model 2 is an arcade system board originally debuted by Sega in 1993 as a successor to the Sega Model 1 board. It is an extension of the Model 1 hardware, most notably introducing the concept of texture-mapped polygons, allowing for more realistic 3D graphics (for its time)."
},
{
    shortName: "auto-sports",
    systemName: "Sports",
    releaseYear: "Various",
    description: "View and play the Sports games across your entire library."
},
{
    shortName: "atarist",
    systemName: "Atari ST",
    releaseYear: 1985,
    description: "The Atari ST is a line of home computers from Atari Corporation and the successor to the Atari 8-bit family. The initial model, the 520ST, saw limited release in April–June 1985 and was widely available in July."
},
{
    shortName: "auto-adult",
    systemName: "Adult",
    releaseYear: "Various",
    description: "View and play the adult games across the entire library."
},
{
    shortName: "desktop",
    systemName: "Desktop Shorcuts",
    releaseYear: "Various",
    description: "View and run your Desktop shortcuts"
},
{
    shortName: "gbah",
    systemName: "GBA Hacks",
    releaseYear: 2001,
    description: "The Game Boy Advance (abbreviated as GBA) is a 32-bit handheld video game console developed, manufactured and marketed by Nintendo as the successor to the Game Boy Color. It was released in Japan on March 21, 2001, in North America on June 11, 2001, in Australia and Europe on June 22, 2001, and in mainland China on June 8, 2004 (iQue Player)."
},
{
    shortName: "final_fantasy",
    systemName: "Final Fantasy",
    releaseYear: "Various",
    description: "View and play the Final Fantasy Games in your collection."
},
{
    shortName: "windows9x",
    systemName: "Windows 9X",
    releaseYear: 1998,
    description: "Windows is a group of several proprietary graphical operating system families developed and marketed by Microsoft. Each family caters to a certain sector of the computing industry."
},
{
    shortName: "tic-80",
    systemName: "TIC-80",
    releaseYear: 2017,
    description: "TIC-80 is a free and open source fantasy computer for making, playing and sharing tiny games. There are built-in tools for development: code, sprites, maps, sound editors and the command line, which is enough to create a mini retro game."
},
{
    shortName: "mugen",
    systemName: "M.U.G.E.N",
    releaseYear: 1999,
    description: "Mugen (stylized as M.U.G.E.N) is a freeware 2D fighting game engine created by Elecbyte and now maintained by a group of enthusiasts named M.U.G.E.N Development Team. Originally released in 1999, it was initially based on the Street Fighter II engine, but has since been heavily modified."
},
{
    shortName: "gameandwatch",
    systemName: "Game & Watch",
    releaseYear: 1980,
    description: "The Game & Watch brand is a series of handheld electronic games developed, manufactured, released and marketed by Nintendo from 1980 to 1991. Created by game designer Gunpei Yokoi, the product derived its name from its featuring a single game as well as a clock on a LCD screen."
},
{
    shortName: "auto-lastplayed",
    systemName: "Last Played",
    releaseYear: "Various",
    description: "View your recently played games across the entire library."
},
{
    shortName: "x1",
    systemName: "X1",
    releaseYear: 1982,
    description: "The X1 (エックスワン, Ekkusuwan), sometimes called the Sharp X1, is a series of home computers released by Sharp Corporation from 1982 to 1988. It was based on a Z80 CPU.n n Despite the fact that the Computer Division of Sharp Corporation had released the MZ series, suddenly the Television Division released a new computer series called the X1."
},
{
    shortName: "auto-shootemup",
    systemName: "Shoot 'Em Up",
    releaseYear: "Various",
    description: "View and play the Shoot 'Em Up games across your entire library."
},
{
    shortName: "playdate",
    systemName: "Playdate",
    releaseYear: 2022,
    description: "Playdate is a handheld video game console developed by Panic. As well as buttons and a directional pad, the device has a mechanical crank on its side."
},
{
    shortName: "steam",
    systemName: "Steam",
    releaseYear: 2003,
    description: "Steam is a video game digital distribution service and storefront by Valve. It was launched as a software client in September 2003 as a way for Valve to provide automatic updates for their games, and expanded to distributing and offering third-party game publishers' titles in late 2005."
},
{
    shortName: "pico8",
    systemName: "PICO-8",
    releaseYear: 2015,
    description: "PICO-8 is a virtual machine and game engine created by Lexaloffle Games. It is a fantasy video game console that mimics the limited graphical and sound capabilities of 8-bit systems of the 1980s."
},
{
    shortName: "atari5200",
    systemName: "Atari 5200",
    releaseYear: 1982,
    description: "The Atari 5200 SuperSystem, commonly known as the Atari 5200, is a second generation (1976–1992) video game console developed and distributed by Atari, Inc. It was released in November 1982 in North America at a retail price of $269."
},
{
    shortName: "model3",
    systemName: "Sega Model 3",
    releaseYear: 1996,
    description: "The Sega Model 3 is an arcade platform produced by Sega in partnership with Lockheed Martin. It is a successor to the Sega Model 2 platform, and was released in 1996."
},
{
    shortName: "cdimono1",
    systemName: "Philips CD-i",
    releaseYear: 1991,
    description: "The Philips CD-i (Compact Disc Interactive) is an interactive multimedia CD player developed and marketed by Royal Philips Electronics N.V."
},
{
    shortName: "lowresnx",
    systemName: "LowRes NX",
    releaseYear: 2017,
    description: "LowRes NX was inspired by real 8-bit and 16-bit systems and simulates chips for graphics, sound and I/O, which actually work like classic hardware. It supports hardware sprites as well as hardware parallax scrolling, and even offers vertical blank and raster interrupts to create authentic retro effects."
},
{
    shortName: "wiiu",
    systemName: "Wii U",
    releaseYear: 2012,
    description: "The Wii U (WEE YOO) is a home video game console developed by Nintendo as the successor to the Wii. Released in late 2012, it is the first eighth-generation video game console and competed with Microsoft's Xbox One and Sony's PlayStation 4."
},
{
    shortName: "auto-wheel",
    systemName: "Wheel",
    releaseYear: "Various",
    description: "View and play the wheel games across your entire library."
},
{
    shortName: "gamate",
    systemName: "Gamate",
    releaseYear: 1990,
    description: "The Gamate, known as 超級小子 (pinyin: chāojí xiǎozi, literally Super Boy) in Taiwan and 超级神童 (pinyin: chāojí shéntóng, literally Super Child Prodigy) in China, is a handheld game console manufactured by Bit Corporation in the early 1990s, and released in Australia, some parts of Europe, Asia (Taiwan and China), Argentina, and the United States."
},
{
    shortName: "ps2",
    systemName: "PlayStation 2",
    releaseYear: 2000,
    description: "The PlayStation 2 (PS2) is a home video game console developed and marketed by Sony Computer Entertainment. It was first released in Japan on March 4, 2000, in North America on October 26, 2000, in Europe on November 24, 2000, and Australia on November 24, 2000."
},
{
    shortName: "auto-simulation",
    systemName: "Simulation",
    releaseYear: "Various",
    description: "View and play the Simulation games across your entire library."
},
{
    shortName: "fba",
    systemName: "FinalBurn Alpha",
    releaseYear: 2000,
    description: "This source-available project is based on FinalBurn, created by Dave in 2000. It has been programmed by a team composed of Barry Harris (Old username: TrebleWinner), Jan_Klaassen, KEV, LoopMaster, Mike Haggar, Hyper Yagami and Ayeye."
},
{
    shortName: "neogeocd",
    systemName: "Neo Geo CD",
    releaseYear: 1994,
    description: "The Neo Geo CD (Japanese: ネオジオCD, Hepburn: Neo Jio Shī Dī) is the second home video game console of SNK Corporation's Neo Geo family, released in September 9, 1994, four years after its cartridge-based equivalent. This is the same platform, converted to the cheaper CD format retailing at $49 to $79 per title, compared to the $300 cartridges."
},
{
    shortName: "windows3x",
    systemName: "Windows 3.X",
    releaseYear: 1992,
    description: "Windows is a group of several proprietary graphical operating system families developed and marketed by Microsoft. Each family caters to a certain sector of the computing industry."
},
{
    shortName: "vectrex",
    systemName: "Vectrex",
    releaseYear: 1982,
    description: "The Vectrex is a vector display-based home video game console–the only one ever designed and released for the home market, developed by Smith Engineering. It was first released for the North America market in November 1982 and then Europe and Japan in 1983."
},
{
    shortName: "pv1000",
    systemName: "PV-1000",
    releaseYear: 1983,
    description: "The Casio PV-1000 (ぴーぶいせん, Pi Bui-Sen) is a third-generation home video game console manufactured by Casio and released in Japan in 1983. It was discontinued less than a year after release."
},
{
    shortName: "intellivision",
    systemName: "Intellivision",
    releaseYear: 1979,
    description: "The Mattel Intellivision is a second generation (1976–1992) home video game console developed and distributed by Mattel Electronics. It was released in summer 1979 in North America at a retail price of $299."
},
{
    shortName: "atarilynx",
    systemName: "Atari Lynx",
    releaseYear: 1989,
    description: "The Atari Lynx, usually just referred to as Lynx, is a fourth generation (1987-2004) handheld video game console developed in partnership with Epyx, Inc. and distributed by the Atari Corporation."
},
{
    shortName: "supergrafx",
    systemName: "SuperGrafx",
    releaseYear: 1989,
    description: "The PC Engine SuperGrafx (PCエンジンスーパーグラフィックス, Pī Shī Enjin SūpāGurafikkusu), also known as simply the SuperGrafx, is a fourth-generation home video game console manufactured by NEC Home Electronics and released in Japan and France in 1989. It is the successor system to the PC Engine, released two years prior."
},
{
    shortName: "mess",
    systemName: "MESS",
    releaseYear: 1998,
    description: "Multi Emulator Super System (MESS) is an emulator for various consoles and computer systems, based on the MAME core. It used to be a standalone program (which has since been discontinued), but is now integrated into MAME (which is actively developed)."
},
{
    shortName: "ports",
    systemName: "Ports",
    releaseYear: "Various",
    description: "View and play all of your favorite game ports."
},
{
    shortName: "wii",
    systemName: "Wii",
    releaseYear: 2006,
    description: "The Wii (known unofficially as the Nintendo Wii) is a home video game console released by Nintendo on November 19, 2006. As a seventh generation console, the Wii competed with Microsoft's Xbox 360 and Sony's PlayStation 3."
},
{
    shortName: "pc98",
    systemName: "PC-98",
    releaseYear: 1982,
    description: "The NEC PC-9800 was line of personal computers developed in 1982 in Japan by NEC Corporation based on IBM, aimed exclusively at the Japanese market. The first model was a 16-bit architecture with an Intel 8086 processor clocked at 5 MHz and 128 KB of RAM."
},
{
    shortName: "snes",
    systemName: "Super Nintendo",
    releaseYear: 1992,
    description: "The Super Nintendo Entertainment System (also known as the Super NES, SNES or Super Nintendo) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America. In Japan, the system is called the Super Famicom, officially adopting the abbreviated name of its predecessor, the Family Computer, or SFC for short."
},
{
    shortName: "system2x6",
    systemName: "Namco System 246/256",
    releaseYear: 2001,
    description: "The Namco System 246/256 is an arcade platform based on the Sony PlayStation 2. Sometimes referred to as Namco 2x6, as the two hardwares are very similar and run much of the same software."
},
{
    shortName: "dos",
    systemName: "MS-DOS",
    releaseYear: 1981,
    description: "MS-DOS, short for Microsoft Disk Operating System, was an operating system for x86-based personal computers mostly developed by Microsoft. It was the most commonly used member of the DOS family of operating systems, and was the main operating system for IBM PC compatible personal computers during the 1980s to the mid-1990s, when it was gradually superseded by operating systems offering a graphical user interface (GUI), in various generations of the Microsoft Windows operating system."
},
{
    shortName: "channelf",
    systemName: "Fairchild Channel F",
    releaseYear: 1976,
    description: "The Fairchild Channel F is a home video game console released by Fairchild Semiconductor in November 1976. "
},
{
    shortName: "nesdisk",
    systemName: "Nintendo Famicom Disk System",
    releaseYear: 1983,
    description: "The Nintendo Entertainment System is an 8-bit video game console that was released by Nintendo in North America during 1985, in Europe during 1986 and Australia in 1987. In most of Asia, including Japan (where it was first launched in 1983), China, Vietnam, Singapore, the Middle East and Hong Kong, it was released as the Family Computer, commonly shortened as either the romanized contraction Famicom, or abbreviated to FC."
},
{
    shortName: "electron",
    systemName: "Acorn Electron",
    releaseYear: 1983,
    description: "The Acorn Electron (nicknamed the Elk inside Acorn and beyond) was a lower-cost alternative to the BBC Micro educational/home computer, also developed by Acorn Computers Ltd, to provide many of the features of that more expensive machine at a price more competitive with that of the ZX Spectrum. It had 32 kilobytes of RAM, and its ROM included BBC BASIC II together with the operating system."
},
{
    shortName: "atari800",
    systemName: "Atari 800",
    releaseYear: 1979,
    description: "The Atari 8-bit family is a series of 8-bit home computers introduced by Atari, Inc. in 1979 as the Atari 400 and Atari 800 and manufactured until 1992."
},
{
    shortName: "bbcmicro",
    systemName: "BBC Micro",
    releaseYear: 1981,
    description: "The British Broadcasting Corporation Microcomputer System, BBC Microcomputer System, or best known as the BBC Micro is a series of microcomputers designed by Acorn Computers Ltd. and distributed by the BBC."
},
{
    shortName: "prboom",
    systemName: "Doom",
    releaseYear: 1993,
    description: "Doom is a 1993 first-person shooter (FPS) game developed by id Software for MS-DOS. Players assume the role of a space marine, popularly known as Doomguy, fighting their way through hordes of invading demons from hell."
},
{
    shortName: "astrocade",
    systemName: "Bally Astrocade",
    releaseYear: 1977,
    description: "The Bally Astrocade (also known as Bally Arcade or initially as Bally ABA-1000) is a second-generation home video game console and simple computer system designed by a team at Midway, at that time the videogame division of Bally."
},
{
    shortName: "model1",
    systemName: "Sega Model 1",
    releaseYear: 1992,
    description: "The Sega Model 1 is an arcade system board that was released by Sega in 1992 and is the successor to the Sega System 32 (released in 1990). While earlier Sega hardware was capable of handling 3D polygons (such as the Mega Drive, released in 1988), the Model 1 was Sega's first hardware specifically designed for 3D polygon graphics."
},
{
    shortName: "moto",
    systemName: "Thomson MOTO",
    releaseYear: 1984,
    description: "The Thomson MOTO line of computers were a series of 8-bit computers sold in the 1980s by French electronics company Thomson, which has been nationalized in 1982. The MOTO computers became an integral part of the French Government's plan informatique pour tous (IPT) to make computers widespread throughout France by bringing computers and programming classes to French school children."
},
{
    shortName: "vc4000",
    systemName: "VC 4000",
    releaseYear: 1978,
    description: "The VC 4000 (short for Video Computer 4000) is an early second generation 8-bit cartridge-based home video game console released in Germany in 1978 by Interton. The console is quite obscure outside Germany, but many software-compatible systems can be found in many European countries."
},
{
    shortName: "auto-favorites",
    systemName: "Favorites",
    releaseYear: "Various",
    description: "View and play your favorite games across the entire library."
},
{
    shortName: "auto-sportswithanimals",
    systemName: "Sports with Animals",
    releaseYear: "Various",
    description: "View and play the Sports with Animals games across your entire library."
},
{
    shortName: "solarus",
    systemName: "Solarus",
    releaseYear: 2021,
    description: "Solarus was specifically designed with cult 2D action-RPG classics in mind, such as The Legend of Zelda: A Link to the Past and Secret of Mana on the Super Nintendo, or Soleil on the Sega Megadrive/Genesis.The engine is programmed in C++, with the SDL library and an OpenGL backend."
},
{
    shortName: "3do",
    systemName: "3DO",
    releaseYear: 1993,
    description: "The 3DO Interactive Multiplayer (often called simply 3DO) is a video game console originally produced by Panasonic in 1993. Further renditions of the hardware were released in 1994 by Sanyo and Goldstar."
},
{
    shortName: "j2me",
    systemName: "J2ME",
    releaseYear: 1998,
    description: "Java Platform, Micro Edition or Java ME is a computing platform for development and deployment of portable code for embedded and mobile devices (micro-controllers, sensors, gateways, mobile phones, personal digital assistants, TV set-top boxes, printers). Java ME was formerly known as Java 2 Platform, Micro Edition or J2ME."
},
{
    shortName: "archimedes",
    systemName: "Acorn Archimedes",
    releaseYear: 1987,
    description: "The Acorn Archimedes is a family of personal computers designed by Acorn Computers of Cambridge, England. The systems are based on Acorn's own ARM architecture processors and the proprietary operating systems Arthur and RISC OS."
},
{
    shortName: "androidapps",
    systemName: "Android Apps",
    releaseYear: "Various",
    description: "View and use your favorite Android Apps."
},
{
    shortName: "easyrpg",
    systemName: "EasyRPG",
    releaseYear: 2007,
    description: "EasyRPG is a free, open source engine to create RPG games, aiming to be also compatible with all RPG Maker 2000 and RPG Maker 2003 games. RPG Maker 2000/2003 games tend to have mechanics and visuals similar to 16-bit JRPGs, though custom scripts can be made by the creators to modify how the game feels and looks."
},
{
    shortName: "ags",
    systemName: "Adventure Game Studio",
    releaseYear: 1997,
    description: "Adventure Game Studio (AGS) is an open source development tool primarily used to create graphic adventure games. It is aimed at intermediate-level game designers, and combines an integrated development environment (IDE) with a scripting language based on the C programming language to process game logic."
},
{
    shortName: "auto-huntingandfishing",
    systemName: "Hunting and Fishing",
    releaseYear: "Various",
    description: "View and play the Hunting and Fishing games across your entire library."
},
{
    shortName: "atarijaguarcd",
    systemName: "Atari Jaguar CD",
},
{
    shortName: "trs-80",
    systemName: "TRS-80",
    releaseYear: 1977,
    description: "The TRS-80 Micro Computer System (TRS-80, later renamed the Model I to distinguish it from successors) is a desktop microcomputer launched in 1977 and sold by Tandy Corporation through their Radio Shack stores. The name is an abbreviation of Tandy Radio Shack, Z80 [microprocessor]."
},
{
    shortName: "daphne",
    systemName: "Daphne",
    releaseYear: 2007,
    description: "Daphne is an arcade emulator application that emulates a variety of laserdisc video games with the intent of preserving these games and making the play experience as faithful to the originals as possible. The developer calls Daphne the \"First Ever Multiple Arcade Laserdisc Emulator\" (\"FEMALE\")."
},
{
    shortName: "pokemini",
    systemName: "Pokémon Mini",
    releaseYear: 2001,
    description: "The Pokémon Mini is a handheld game console that was designed and manufactured by Nintendo and themed around the Pokémon media franchise. It is the smallest game system with interchangeable cartridges ever produced by Nintendo, weighing just under two and a half ounces (70 grams)."
},
{
    shortName: "auto-playingcards",
    systemName: "Playing Cards",
    releaseYear: "Various",
    description: "View and play the Playing Cards games across your entire library."
},
{
    shortName: "pc88",
    systemName: "PC-88",
    releaseYear: 1981,
    description: "The PC-8800 series (Japanese: PC-8800シリーズ, Hepburn: Pī Shī Hassen Happyaku Shirīzu), commonly shortened to PC-88, are a brand of Zilog Z80-based 8-bit home computers released by Nippon Electric Company (NEC) in 1981 and primarily sold in Japan."
},
{
    shortName: "atari7800",
    systemName: "Atari 7800",
    releaseYear: 1986,
    description: "The Atari 7800 Pro System, commonly known as the Atari 7800, is a third generation (1983-2003) video game console developed and distributed by Atari Corporation. It was released in May 1986 in North America at a retail price of $79."
},
{
    shortName: "tvgames",
    systemName: "Plug and Play TV Games",
    releaseYear: "Various",
    description: "View and play your plug and play TV games."
},
{
    shortName: "neogeocdjp",
    systemName: "Neo Geo CD",
    releaseYear: 1994,
    description: "The Neo Geo CD (Japanese: ネオジオCD, Hepburn: Neo Jio Shī Dī) is the second home video game console of SNK Corporation's Neo Geo family, released in September 9, 1994, four years after its cartridge-based equivalent. This is the same platform, converted to the cheaper CD format retailing at $49 to $79 per title, compared to the $300 cartridges."
},
{
    shortName: "snesh",
    systemName: "Super Nintendo Hacks",
    releaseYear: 1992,
    description: "The Super Nintendo Entertainment System (also known as the Super NES, SNES or Super Nintendo) is a 16-bit home video game console developed by Nintendo that was released in 1990 in Japan, 1991 in North America, 1992 in Europe and Australasia (Oceania), and 1993 in South America. In Japan, the system is called the Super Famicom, officially adopting the abbreviated name of its predecessor, the Family Computer, or SFC for short."
},
{
    shortName: "gamecube",
    systemName: "Nintendo Game Cube",
    releaseYear: 2001,
    description: "The Nintendo GameCube is a home video game console released by Nintendo in Japan and North America in 2001 and in PAL territories in 2002. The GameCube is Nintendo's entry in the sixth generation of video game consoles and is the successor to their previous console, the Nintendo 64."
},
{
    shortName: "pokemon",
    systemName: "Pokémon",
    releaseYear: "Various",
    description: "View and play the Pokémon Games in your collection."
},
{
    shortName: "auto-casino",
    systemName: "Casino",
    releaseYear: "Various",
    description: "View and play the Casino games across your entire library."
},
{
    shortName: "mame-advmame",
    systemName: "AdvanceMAME",
    releaseYear: 1998,
    description: "AdvanceMAME, is a port of the MAME 0.106 and MESS 0."
},
{
    shortName: "auto-demo",
    systemName: "Demo",
    releaseYear: "Various",
    description: "View and play the Demo games across your entire library."
},
{
    shortName: "creativision",
    systemName: "VTech CreatiVision",
    releaseYear: 1982,
    description: "The VTech CreatiVision is a hybrid computer and home video game console introduced by VTech in 1981 and released in 1982 during the second generation of video game consoles. It cost $295 Australian Dollars in Australia."
},
{
    shortName: "auto-neverplayed",
    systemName: "Never Played",
    releaseYear: "Various",
    description: "View and play your never played games across your entire library."
},
{
    shortName: "pet",
    systemName: "Commodore Pet",
    releaseYear: 1977,
    description: "The Commodore PET (Personal Electronic Transactor) is a line of home/personal computers produced starting in 1977 by Commodore International. A top-seller in the Canadian and United States educational markets, it was Commodore's first full-featured computer, and formed the basis for their entire 8-bit product line, including the Commodore 64."
},
{
    shortName: "segastv",
    systemName: "ST-V",
    releaseYear: 1994,
    description: "ST-V (Sega Titan Video) is an arcade system board released by Sega, in 1994 for Japan and 1995 worldwide. Departing from their usual process of building custom arcade hardware, Sega's ST-V is essentially identical to the Sega Saturn home console system."
},
{
    shortName: "uzebox",
    systemName: "Uzebox",
    releaseYear: 2008,
    description: "The Uzebox is a retro-minimalist 8-bit open source game console. It is based on an AVR 8-bit general purpose microcontroller made by Atmel."
},
{
    shortName: "namco2x6",
    systemName: "Namco System 246/256",
    releaseYear: 2001,
    description: "The Namco System 246/256 is an arcade platform based on the Sony PlayStation 2. Sometimes referred to as Namco 2x6, as the two hardwares are very similar and run much of the same software."
},
{
    shortName: "auto-roleplayings",
    systemName: "Roleplaying",
    releaseYear: "Various",
    description: "View and play the Roleplaying games across your entire library."
},
{
    shortName: "auto-reflection",
    systemName: "Reflection",
    releaseYear: "Various",
    description: "View and play the Reflection games across your entire library."
},
{
    shortName: "lutro",
    systemName: "Lutro",
    releaseYear: 2015,
    description: "Lutro is a 2D game framework that aims for simplicity and extreme portability. Using lutro, you can develop any kind of 2D retro games, like NES or Genesis games, and run them on a wide range of platforms through RetroArch."
},
{
    shortName: "xegs",
    systemName: "Atari XE",
    releaseYear: 1987,
    description: "The Atari XE Video Game System (Atari XEGS) is an industrial redesign of the Atari 65XE home computer and the final model in the Atari 8-bit family. It was released by Atari Corporation in 1987 and marketed as a home video game console alongside the Nintendo Entertainment System, Sega's Master System, and Atari's own Atari 7800."
},
{
    shortName: "gmaster",
    systemName: "Game Master",
    releaseYear: 1990,
    description: "The Game Master is a handheld game console manufactured by Hartung, and designed to compete with the Nintendo Game Boy. In Germany, it was marketed by Hartung itself, while in the UK it was released as the Systema 2000 by the already well-established maker of cheap LCD games Systema."
},
{
    shortName: "type-x",
    systemName: "Taito Type X",
    releaseYear: 2004,
    description: "The Taito Type X is an arcade system board released in 2004 by game developer and publisher Taito."
},
{
    shortName: "auto-allgames",
    systemName: "All Games",
    releaseYear: "Various",
    description: "View and play every game across your entire library."
},
{
    shortName: "apple2",
    systemName: "Apple II",
    releaseYear: 1977,
    description: "In 1976, computer pioneers Steve Wozniak and Steve Jobs began selling their Apple I computer in kit form to computer stores. A month later, Wozniak was working on a design for an improved version, the Apple II."
},
{
    shortName: "tg16",
    systemName: "TurboGrafx-16",
    releaseYear: 1989,
    description: "The TurboGrafx-16, known as the PC Engine in Japan and France, is a 16-bit fourth-generation home video game console designed by Hudson Soft and sold by NEC Home Electronics. It was released in Japan in 1987 and in North America in 1989."
},
{
    shortName: "sg-1000",
    systemName: "SG-1000",
    releaseYear: 1983,
    description: "The SG-1000 is a home video game console manufactured by Sega and released in Japan, Australia, New Zealand, and other regions. It was Sega's first entry into the home video game hardware business."
},
{
    shortName: "gamepock",
    systemName: "Game Pocket Computer",
    releaseYear: 1984,
    description: "The Epoch Game Pocket Computer is a second-generation handheld game console released by Epoch Co. in Japan in 1984 for 12,800 Japanese yen."
},
{
    shortName: "auto-platform",
    systemName: "Platform",
    releaseYear: "Various",
    description: "View and play the Platform games across your entire library."
},
{
    shortName: "zxspectrum",
    systemName: "ZX Spectrum",
    releaseYear: 1982,
    description: "The ZX Spectrum is an 8-bit personal home computer released in the United Kingdom in 1982 by Sinclair Research Ltd. It was the follow-up to the Sinclair ZX81."
},
{
    shortName: "auto-casual",
    systemName: "Casual",
    releaseYear: "Various",
    description: "View and play the Casual games across your entire library."
},
{
    shortName: "scummvm",
    systemName: "ScummVM",
    releaseYear: 2001,
    description: "Script Creation Utility for Maniac Mansion Virtual Machine (ScummVM) is a set of game engine recreations. Originally designed to play LucasArts adventure games that use the SCUMM system, it also supports a variety of non-SCUMM games by companies like Revolution Software and Adventure Soft."
},
{
    shortName: "auto-various",
    systemName: "Various",
    releaseYear: "Various",
    description: "View and play various games across your entire library."
},
{
    shortName: "cps",
    systemName: "Capcom Play System",
    releaseYear: 1988,
    description: "The CP System (CPシステム, shīpī shisutemu, CPS for short) is an arcade system board developed by Capcom that ran game software stored on removable daughterboards. More than two dozen arcade titles were released for CPS-1, before Capcom shifted game development over to its successor, the CP System II."
},
{
    shortName: "amigacd32",
    systemName: "Amiga CD32",
    releaseYear: 1993,
    description: "The Amiga CD32, styled \"CD32\" and code-named \"Spellbound\", is the first 32-bit home video game console released in western Europe, Australia, Canada and Brazil. It was first announced at the Science Museum in London on July 16, 1993, and was released in September of the same year."
},
{
    shortName: "dragon32",
    systemName: "Dragon 32",
    releaseYear: 1982,
    description: "The Dragon 32 and Dragon 64 are home computers that were built in the 1980s. The Dragons are very similar to the TRS-80 Color Computer, and were produced for the European market by Dragon Data, Ltd."
},
{
    shortName: "auto-quiz",
    systemName: "Quiz",
    releaseYear: "Various",
    description: "View and play the Quiz games across your entire library."
},
{
    shortName: "auto-board",
    systemName: "Board Games",
    releaseYear: "Various",
    description: "View and play the Board games across your entire library."
},
{
    shortName: "macintosh",
    systemName: "Macintosh",
    releaseYear: 1984,
    description: "The Macintosh (mainly Mac since 1998) is a family of personal computers designed, manufactured, and sold by Apple Inc. (originally as Apple Computer, Inc."
},
{
    shortName: "zeldac",
    systemName: "Zelda Classic",
    releaseYear: "Various",
    description: "View and play the Zelda Games in your collection."
},
{
    shortName: "xbox360",
    systemName: "Xbox 360",
    releaseYear: 2005,
    description: "The Xbox 360 is a home video game console developed by Microsoft. As the successor to the original Xbox, it is the second console in the Xbox series."
}
];

function getColor(system) {
    return colorMapping[system] || colorMapping["default"] || "#000000";
}

function getSystemMetadata(shortName) {
    for (var i = 0; i < gameSystems.length; i++) {
        if (gameSystems[i].shortName === shortName) {
            return gameSystems[i];
        }
    }
    return null;
}

function formatGameDescription(description) {
    if (!description || description.trim() === "") {
        return "No description available, use game scraper to get proper information...";
    }
    return description;
}

function formatGameDeveloper(developer) {
    if (!developer || developer.trim() === "") {
        return "Unknown developer";
    }
    return developer;
}

function getPlayersContent(players) {
    if (players > 1) {
        return {
            count: players,
            source: "assets/icons/players.png"
        };
    }
    return null;
}

function getReleaseYearText(year) {
    if (year === 0 || !year) {
        return "Unknown release year";
    }
    return year.toString();
}

function formatGameGenre(genre) {
    if (!genre || genre.trim() === "") {
        return "Unknown genre";
    }

    const maxLength = 40;
    if (genre.length <= maxLength) {
        return genre;
    } else {
        return genre.substring(0, maxLength - 3) + "...";
    }
}

function displayRating(rating) {
    const fullStars = Math.floor(rating * 5);
    const hasHalfStar = (rating * 5) % 1 !== 0;

    let ratingDisplay = "";
    for (let i = 0; i < fullStars; i++) {
        ratingDisplay += "assets/icons/star1.png ";
    }
    if (hasHalfStar) {
        ratingDisplay += "assets/icons/star05.png ";
    }
    for (let i = 0; i < 5 - fullStars - (hasHalfStar ? 1 : 0); i++) {
        ratingDisplay += "assets/icons/star0.png ";
    }

    return ratingDisplay.trim();
}

function getBatteryIcon(batteryPercent, isCharging) {
    if (isNaN(batteryPercent) || isCharging) {
        return "assets/icons/charging.png";
    } else {
        const percent = batteryPercent * 100;
        if (percent <= 20) {
            return "assets/icons/10.png";
        } else if (percent <= 40) {
            return "assets/icons/25.png";
        } else if (percent <= 60) {
            return "assets/icons/50.png";
        } else if (percent <= 80) {
            return "assets/icons/75.png";
        } else if (percent <= 90) {
            return "assets/icons/90.png";
        } else {
            return "assets/icons/95.png";
        }
    }
}

function getRandomScreenshots(collections) {
    var screenshots = [];
    for (var i = 0; i < collections.count; i++) {
        var games = collections.get(i).games;
        for (var j = 0; j < games.count; j++) {
            var game = games.get(j);
            if (game.assets.screenshot) {
                screenshots.push(game.assets.screenshot);
            }
        }
    }
    return screenshots.sort(() => Math.random() - 0.5);
}

function getGameFromScreenshot(collections, screenshot) {
    for (var i = 0; i < collections.count; i++) {
        var games = collections.get(i).games;
        for (var j = 0; j < games.count; j++) {
            var game = games.get(j);
            if (game.assets.screenshot === screenshot) {
                return game;
            }
        }
    }
    return null;
}
