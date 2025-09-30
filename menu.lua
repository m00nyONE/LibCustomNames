-- SPDX-FileCopyrightText: 2025 m00nyONE
-- SPDX-License-Identifier: Artistic-2.0

local lib_name = "LibCustomNames"
local lib = _G[lib_name]
local lib_author = lib.author
local lib_version = lib.version

local sv = {}
local svVersion = 1
local svDefaults = {
    nameRaw = "",
    nameFormatted = "",
    color1 = {1, 1, 1},
    color2 = {1, 1, 1},
    enableGradient = false,
}

local LAM = LibAddonMenu2
local strfmt = string.format

local githubURL = "https://github.com/m00nyONE/LibCustomNames"

local function getPanel()
    return {
        type = 'panel',
        name = lib_name,
        displayName = lib_name,
        author = strfmt("|c76c3f4%s|r", lib_author),
        version = strfmt('|c00FF00%s|r', lib_version),
        website = 'https://www.esoui.com/downloads/info4155-LibCustomNames.html',
        donation = lib.Donate,
        registerForRefresh = true,
    }
end

local function getOptions()

    -- Convert FFFFFF to 1, 1, 1
    local function Hex2RGB(hex)
        hex = hex:gsub("#", "")
        return tonumber("0x" .. hex:sub(1, 2)) / 255, tonumber("0x" .. hex:sub(3, 4)) / 255, tonumber("0x" .. hex:sub(5, 6)) / 255
    end

    -- Convert 1, 1, 1 to FFFFFF
    local function RGB2Hex(r, g, b)
        return strfmt("%.2x%.2x%.2x", zo_round(r * 255), zo_round(g * 255), zo_round(b * 255))
    end

    -- Generate gradient user name.
    local GenerateGradient = function()
        local r1, g1, b1 = unpack(sv.color1)
        local r2, g2, b2 = unpack(sv.color2)
        local s = sv.nameRaw
        local t = {} -- raw name split into single characters
        local n = 0 -- number of non spaces
        -- Split raw name into single utf8 characters.
        for i = 1, utf8.len(s) do
            t[i] = string.sub(s, utf8.offset(s, i), utf8.offset(s, i + 1) - 1)
            if t[i] ~= " " then
                n = n + 1
            end
        end
        -- Don't color spaces.
        if n > 0 then
            local rdelta, gdelta, bdelta = (r2 - r1) / n, (g2 - g1) / n, (b2 - b1) / n
            for i = 1, #t do
                if t[i] ~= " " then
                    r1 = r1 + rdelta
                    g1 = g1 + gdelta
                    b1 = b1 + bdelta
                    t[i] = strfmt('|c%s%s|r', RGB2Hex(r1, g1, b1), t[i])
                end
            end
            return table.concat(t)
        else
            return ""
        end
    end

    -- Generate new LUA code based on custom name and selected colors.
    local GenerateCode = function()
        return strfmt('n["%s"] = {"%s", "%s"}', GetDisplayName('player'), sv.nameRaw, sv.nameFormatted)
    end

    -- Create preview string and update control if needed.
    local GeneratePreview = function(updateControl)
        local s = strfmt("                    %s", sv.nameFormatted)
        if updateControl then
            LibCustomNamesMenu_preview.data.text = s
        end
        return s
    end

    -- Generate formatted name based on raw name and selected colors.
    local GenerateName = function(updateControl)
        if sv.enableGradient then
            sv.nameFormatted = GenerateGradient()
        else
            sv.nameFormatted = strfmt('|c%s%s|r', RGB2Hex(unpack(sv.color1)), sv.nameRaw)
        end
        if updateControl then
            GeneratePreview(true)
        end
        return sv.nameFormatted
    end

    return {
        {
            type = "submenu",
            name = strfmt("|cFF8800%s|r", "For Developers"),
            controls = {
                {
                    type = "description",
                    text = "If you know how to code addons, you can just create a PullRequest on Github and add a custom name that way."
                },
                {
                    type = "button",
                    name = "github",
                    func = function() RequestOpenUnsafeURL(githubURL) end,
                    width = 'full',
                },
                {
                    type = "header",
                    name = strfmt("|cFFFACD%s|r", GetString(LCN_MENU_HEADER))
                },
                {
                    type = "editbox",
                    name = GetString(LCN_MENU_NAME_VAL),
                    tooltip = GetString(LCN_MENU_NAME_VAL_TT),
                    default = sv.nameRaw,
                    getFunc = function() return sv.nameRaw end,
                    setFunc = function(value)
                        if value ~= sv.nameRaw then
                            sv.nameRaw = value or ""
                            GenerateName(true)
                        end
                    end,
                },
                {
                    type = "checkbox",
                    name = GetString(LCN_MENU_GRADIENT),
                    tooltip = GetString(LCN_MENU_GRADIENT_TT),
                    default = false,
                    getFunc = function() return sv.enableGradient end,
                    setFunc = function(value)
                        sv.enableGradient = value
                        GenerateName(true)
                    end,
                },
                {
                    type = "colorpicker",
                    name = GetString(LCN_MENU_COLOR1),
                    default = ZO_ColorDef:New(1, 1, 1, 1),
                    getFunc = function() return unpack(sv.color1) end,
                    setFunc = function(r2, g2, b2)
                        local r1, g1, b1 = unpack(sv.color1)
                        if r1 ~= r2 or g1 ~= g2 or b1 ~= b2 then
                            sv.color1 = {r2, g2, b2}
                            GenerateName(true)
                        end
                    end,
                    width = 'full',
                },
                {
                    type = "colorpicker",
                    name = GetString(LCN_MENU_COLOR2),
                    default = ZO_ColorDef:New(1, 1, 1, 1),
                    getFunc = function() return unpack(sv.color2) end,
                    setFunc = function(r2, g2, b2)
                        local r1, g1, b1 = unpack(sv.color2)
                        if r1 ~= r2 or g1 ~= g2 or b1 ~= b2 then
                            sv.color2 = {r2, g2, b2}
                            GenerateName(true)
                        end
                    end,
                    width = 'full',
                },
                {
                    type = "description",
                    text = GetString(LCN_MENU_PREVIEW),
                    width = 'half',
                },
                {
                    type = "description",
                    text = GeneratePreview(),
                    reference = "LibCustomNamesMenu_preview",
                    width = 'half',
                },
                {
                    type = "editbox",
                    name = GetString(LCN_MENU_LUA),
                    tooltip = GetString(LCN_MENU_LUA_TT),
                    default = GenerateCode(),
                    getFunc = function() return GenerateCode() end,
                    setFunc = function(value) GeneratePreview(true) end,
                    isMultiline = true,
                    isExtraWide = true,
                },
            },
        },
    }
end

--- generates the menu for the library with LibAddonMenu2.0
function lib.BuildMenu()
    sv = ZO_SavedVars:NewAccountWide(lib_name .. "SV", svVersion, nil, svDefaults)

    local panel = getPanel()
    local options = getOptions()

    LAM:RegisterAddonPanel(lib_name .. "Menu", panel)
    LAM:RegisterOptionControls(lib_name .. "Menu", options)

    -- set's itself nil to avoid getting called again
    lib.BuildMenu = nil
end