-- SPDX-FileCopyrightText: 2025 m00nyONE
-- SPDX-License-Identifier: Artistic-2.0

local strings = {
    LCN_MENU = "LibCustomNames",
    LCN_MENU_HEADER = "mein benutzerdefinierter Name",
    LCN_MENU_NAME_VAL = "Benutzerdefinierter Name",
    LCN_MENU_NAME_VAL_TT = "Hier kannst du einen benutzerdefinierten Namen festlegen.",
    LCN_MENU_GRADIENT = "Farbverlauf",
    LCN_MENU_GRADIENT_TT = "Erstellt einen Farbverlauf basierend auf den untenstehenden Farben.",
    LCN_MENU_COLOR1 = "Startfarbe",
    LCN_MENU_COLOR2 = "Endfarbe",
    LCN_MENU_PREVIEW = "Vorschau",
    LCN_MENU_LUA = "LUA-Code:",
    LCN_MENU_LUA_TT = "Sende diesen Code an den Addon-Autor.",
}

for id, val in pairs(strings) do
    ZO_CreateStringId(id, val)
    SafeAddVersion(id, 1)
end
