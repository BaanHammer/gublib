

local primaryfont = "Rubik Light"

local fontprimaryname = "gubfont_primary"
local function FontPrimary(size, weight, fontfamily)
    local name = fontprimaryname .. "_" .. size
    surface.CreateFont(name, {
        font = fontfamily or primaryfont,
        size = size,
        weight = (weight or 500),
        extended = true,
        italic = true
    })
end


FontPrimary(12, 500)

FontPrimary(16, 500)

FontPrimary(20, 500)

FontPrimary(24, 500)

FontPrimary(30, 500)

local secondaryfont = "Montserrat Light"

local secondaryfontname = "gubfont_secondary"
local function SecondaryFont(size, weight, fontfamily)
    local name = secondaryfontname .. "_" .. size
    surface.CreateFont(name, {
        font = fontfamily or secondaryfont,
        size = size,
        weight = (weight or 500),
        extended = true
    })
end


SecondaryFont(12, 500)

SecondaryFont(16, 500)

SecondaryFont(20, 500)

SecondaryFont(24, 500)

SecondaryFont(30, 500)