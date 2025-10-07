[size=6][b]LibCustomNames[/b][/size]

[i]LibCustomNames[/i] is a lightweight library for [i]The Elder Scrolls Online[/i] that allows custom names for players.
Originally part of [b]HodorReflexes[/b], this library was separated out to improve modularity and reduce overhead.
Dependencies: [URL="https://www.esoui.com/downloads/info7-LibAddonMenu.html"]LibAddonMenu-2.0[/URL]

Whether you're a streamer, guild leader, or just want to stand out with a personalized name, this library gives you that little touch of customization — shared across all supported addons.


[size=4][b]Features[/b][/size]

[list]
[*]Assign custom names to ESO players
[*]Centralized and easy-to-maintain name list
[*]Designed for reuse in multiple addons (e.g., HodorReflexes)
[*]Lightweight and dependency-free
[/list]


[size=4][b]Get Your Custom Name[/b][/size]

Want to be featured with your own custom name?

[size=3][b]How to participate:[/b][/size]
[list]
[*][b]Create a Pull Request[/b] adding your name entry to the list
[*]Or [b]send a donation[/b] to @m00nyONE in-game (EU server) and your request will be added
[/list]

This helps support development and keeps the ESO addon ecosystem fun and alive!


[size=4][b]Usage[/b][/size]

If you're an addon developer and want to use [b]LibCustomNames[/b]:

Have a look at the full documentation here: [URL="https://m00nyone.github.io/LibCustomNames/"]Github Pages[/URL]

[code]
local name = LibCustomNames:Get("@originalAccountName") or "@originalAccountName"
[/code]

Documentation will be expanded as needed — feel free to open an issue if you need help integrating it.

[size=4][b]Repository Structure[/b][/size]
[list]
[*][b]PC/names/[/b]: Contains all custom name definitions for PC
[*][b]Console/names/[/b]: Contains all custom name definitions for Console
[/list]

[size=4][b]Contributing[/b][/size]

[SIZE="4"][URL="https://github.com/m00nyONE/LibCustomNames"]https://github.com/m00nyONE/LibCustomNames[/URL]
[/SIZE]
Community contributions are welcome and appreciated!

[list]
[*]Fork the repo
[*]Add your custom name to the data file
[*]Open a Pull Request with a short description
[/list]

[i]Make sure to keep names appropriate and tasteful. Offensive or misleading content will not be accepted.[/i]

[size=4][b]Credits[/b][/size]

[img]https://contrib.rocks/image?repo=m00nyONE/LibCustomNames[/img]
[i]Made with [url=https://contrib.rocks]contrib.rocks[/url][/i]

[size=4][b]Contact[/b][/size]

For questions, contributions, or donations:

[list]
[*]GitHub: [url=https://github.com/m00nyONE/LibCustomNames/issues]Issues & PRs[/url]
[/list]