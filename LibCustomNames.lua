-- SPDX-FileCopyrightText: 2025 m00nyONE
-- SPDX-License-Identifier: Artistic-2.0

--[[ doc.lua begin ]]
--- @class LibCustomNames
local lib = {
    name = "LibCustomNames",
    version = "dev",
    author = "@m00nyONE",
}

local lib_name = lib.name
local lib_author = lib.author
local lib_version = lib.version
_G[lib_name] = lib

local EM = EVENT_MANAGER

--- @type table<string, string[]> Table mapping `@accountName` to `{ uncoloredName, coloredName }`
local names = {}
--[[ doc.lua end ]]

--- Returns a reference to the internal names table.
--- This is only available during addon initialization, to disallow other addons tampering with the data later.
--- @return table<string, string[]> The table of custom names.
function lib.GetNamesTable()
    return names
end

--- Internal function to perform post-load initialization.
local function initialize()
    lib.BuildMenu()
end

--- Register for the EVENT_ADD_ON_LOADED event to initialize the addon properly.
EM:RegisterForEvent(lib_name, EVENT_ADD_ON_LOADED, function(_, name)
    if name ~= lib_name then return end

    initialize()

    EM:UnregisterForEvent(lib_name, EVENT_ADD_ON_LOADED)
end)

--- Opens the in-game mail window with donation fields prefilled for supporting the library.
function lib.Donate()
    SCENE_MANAGER:Show('mailSend')
    zo_callLater(function()
        ZO_MailSendToField:SetText(lib_author)
        ZO_MailSendSubjectField:SetText("Donation for " .. lib_name)
        ZO_MailSendBodyField:SetText("")
        ZO_MailSendBodyField:TakeFocus()
    end, 250)
end

--- Handles slash commands for version output and donation prompt.
--- Usage:
--- - `/lcn version` — shows current version
--- - `/lcn donate` — opens mail window for donations
--- @param str string The argument passed with the slash command
local function slashCommands(str)
    if str == "version" then d(lib_version) end
    if str == "donate" then lib.Donate() end
end

--- Register slash commands for interacting with the library.
SLASH_COMMANDS["/LibCustomNames"] = slashCommands
SLASH_COMMANDS["/lcn"] = slashCommands