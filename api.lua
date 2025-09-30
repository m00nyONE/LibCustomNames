-- SPDX-FileCopyrightText: 2025 m00nyONE
-- SPDX-License-Identifier: Artistic-2.0

local lib_name = "LibCustomNames"
local lib = _G[lib_name]
local n = lib.GetNamesTable()

--[[ doc.lua begin ]]

--- Checks whether a custom name exists for the given username.
--- @param username string The player's account name (e.g., "@m00nyONE").
--- @return boolean hasCustomName `true` if a custom name exists, `false` otherwise.
function lib.HasCustomName(username)
    --if n[string.lower(username)] then
    if n[username] then
        return true
    end

    return false
end

--- Retrieves the custom name for a given username.
---
--- If `colored` is `true` or `nil`, the colored version will be returned.
--- If `colored` is `false`, the uncolored version will be returned.
--- Falls back to the uncolored version if the colored one is missing.
---
--- @param username string The player's account name (e.g., "@m00nyONE").
--- @param colored boolean|nil Whether to return the colored name. Defaults to `true`.
--- @return string|nil customName The custom name if it exists, or `nil` otherwise.
function lib.Get(username, colored)
    --local entry = n[string.lower(username)]
    local entry = n[username]
    if not entry then return nil end

    if colored == false then
        return entry[1]
    else
        return entry[2] or entry[1]
    end
end

--- Retrieves the colored custom name for a given username.
---
--- @param username string The player's account name (e.g., "@m00nyONE").
--- @return string|nil customName The custom name if it exists, or `nil` otherwise.
function lib.GetColored(username)
    return lib.Get(username, true)
end

--- Retrieves the uncolored custom name for a given username.
---
--- @param username string The player's account name (e.g., "@m00nyONE").
--- @return string|nil customName The custom name if it exists, or `nil` otherwise.
function lib.GetUncolored(username)
    return lib.Get(username, false)
end

-- cached Clones of the internal tables for the GetAll function. As these tables should always be readOnly and do nothing if edited, there is no need for them to be cloned each time they're requested
local cachedTableClone = nil

--- Retrieves all custom names from the internal table as a deep copy.
--- Editing the returning table has no effect to the internal one that is used to retrieve actual names.
---
--- @return table<string, string[]>
function lib.GetAll()
    if not cachedTableClone then
        cachedTableClone = ZO_DeepTableCopy(n)
    end
    return cachedTableClone
end

-- The number of custom name entries is fixed at runtime (names are registered once and not modified later). To optimize performance, counts are calculated only once when first requested and then cached for future calls.
local cachedNamesCount = 0

--- Returns the number of registered custom names.
--- The result is cached after the first computation.
--- @return number count The number of custom names
function lib.GetCustomNameCount()
    if cachedNamesCount == 0 then
        for _ in pairs(n) do
            cachedNamesCount = cachedNamesCount + 1
        end
    end
    return cachedNamesCount
end

--[[ doc.lua end ]]