-- SPDX-FileCopyrightText: 2025 m00nyONE
-- SPDX-License-Identifier: Artistic-2.0

local lib_name = "LibCustomNames"
local lib = _G[lib_name]

--- Returns a read-only proxy table
local function readOnly(t)
    local proxy = {}
    local metatable = {
        --__metatable = "no indexing allowed",
        __index = t,
        __newindex = function(_, k, v)
            if TBUG or Zgoo then return end -- don't show message edits when Torchbug or Zgoo are running
            d("attempt to update read-only table")
            --error("<-- This malicious Addon tried to overwrite protected data! Screenshot the Error and report the Addon! Remove it Immediately afterwards!", 2)
        end,
    }
    setmetatable(proxy, metatable)
    return proxy
end

-- remove GetNamesTable function so others addons can not alter the data anymore
lib.GetNamesTable = nil

-- make the Lib read-only
_G[lib_name] = readOnly(lib)