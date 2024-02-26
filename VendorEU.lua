local addonName, addon = ...
local frameName = "ZAMESTOTV_BUY299"
if not _G[frameName] then
    _G[frameName] = CreateFrame("Frame")
    _G[frameName]:RegisterEvent("MERCHANT_SHOW")
end

local function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

local vendors = {
    ['Arvik'] = {['Skrog Liver Oil'] = true, },
    ['Bukarakikk'] = {['Hunk o\' Blubber'] = true, },
	['Erugosa'] = {['Exquisite Ohn\'ahran Potato'] = true, ['Flaky Pastry Dough'] = true, ['Dark Thaldraszian Cocoa Powder'] = true, ['Four-Cheese Blend'] = true, },
    ['Gracus'] = {['Greenberry'] = true, ['Fresh Dragon Fruit'] = true, ['Juicy Bushfruit'] = true, ['Dried Coldsnap Sagittate'] = true, },
	['Hanu'] = {['Eye of Bass'] = true, },
    ['Head Chef Stacks'] = {['Rations: Scorpid Surprise'] = true, ['Rations: Undermine Clam Chowder'] = true, ['Rations: Westfall Stew'] = true, ['Rations: Dragonbreath Chili'] = true, },
	['Jinkutuk'] = {['Salted Fish Scraps'] = true, },
    ['Junnik'] = {['Thousandbite Piranha Collar'] = true, },
	['Elder Nappa'] = {['Nappa\'s Famous Tea'] = true, },
    ['Norukk'] = {['Norukk\'s "All-Purpose" Fish Powder'] = true, },
	['Qariin Dotur'] = {['Seven Spices Bruffalon'] = true, ['Dragonflame Argali'] = true, ['Thrice-Charred Mammoth Ribs'] = true, ['"Volcano" Duck'] = true, },
    ['Patchu'] = {['Lunker Bits'] = true, },
	['Rokkutuk'] = {['Deepsquid Ink'] = true, },
    ['Tattukiaka'] = {['Fermented Mackerel Paste'] = true, },
	['Tikukk'] = {['Island Crab Jerky'] = true, },
	['Tuukanit'] = {['Piping-Hot Orca Milk'] = true, },
}   

local function p(msg)
    print("[ZAMESTOTV: Community Feast] " .. msg)
end

local frame = _G[frameName]
frame:SetScript("OnEvent", function(self, event, ...)
    if IsShiftKeyDown() then return end
    
    local targetName = UnitName("target")
    if not targetName then return end
    local vendor = vendors[targetName]
    if not vendor then return end

    local numItems = GetMerchantNumItems()
    for i = numItems, 1, -1 do
        local name = GetMerchantItemInfo(i)
        if vendor[name] then
            p("Buying: " .. name)
            pcall(function() BuyMerchantItem(i) end)
        end
    end
    
    local count = 0
    frame:SetScript("OnUpdate", function(self)
        count = count + 1
        if count > 10 then
            CloseMerchant()
            frame:SetScript("OnUpdate", nil)
        end
    end)
end)
