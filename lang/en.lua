-- SPDX-FileCopyrightText: 2025 m00nyONE
-- SPDX-License-Identifier: Artistic-2.0

local strings = {
    LCN_MENU = "LibCustomNames",
    LCN_MENU_HEADER = "my custom name",
    LCN_MENU_NAME_VAL = "Custom name",
    LCN_MENU_NAME_VAL_TT = "You can set a custom name here.",
    LCN_MENU_GRADIENT = "Gradient",
    LCN_MENU_GRADIENT_TT = "Create gradient based on the colors below.",
    LCN_MENU_COLOR1 = "Start color",
    LCN_MENU_COLOR2 = "End color",
    LCN_MENU_PREVIEW = "Preview",
    LCN_MENU_LUA = "LUA code:",
    LCN_MENU_LUA_TT = "Send this code to the addon author.",
}

for id, val in pairs(strings) do
    ZO_CreateStringId(id, val)
    SafeAddVersion(id, 1)
end