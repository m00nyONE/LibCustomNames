-- SPDX-FileCopyrightText: 2025 m00nyONE NeBioNik
-- SPDX-License-Identifier: Artistic-2.0

local strings = {
    LCN_MENU = "LibCustomNames",
    LCN_MENU_HEADER = "Моё пользовательское имя",
    LCN_MENU_NAME_VAL = "Пользовательское имя",
    LCN_MENU_NAME_VAL_TT = "Здесь вы можете указать пользовательское имя.",
    LCN_MENU_GRADIENT = "Градиент",
    LCN_MENU_GRADIENT_TT = "Создает градиент на основе цветов, указанных ниже.",
    LCN_MENU_COLOR1 = "Начальный цвет",
    LCN_MENU_COLOR2 = "Конечный цвет",
    LCN_MENU_PREVIEW = "Предпросмотр",
    LCN_MENU_LUA = "LUA-код:",
    LCN_MENU_LUA_TT = "Отправьте этот код автору аддона.",
}

for id, val in pairs(strings) do
    ZO_CreateStringId(id, val)
    SafeAddVersion(id, 1)
end
