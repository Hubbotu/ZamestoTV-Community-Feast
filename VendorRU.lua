local addonName, addon = ...
local frameName = "ZAMESTOTV_BUY199"
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
    ['Арвик'] = {['Печеночный жир скрога'] = true, },
    ['Букаракикк'] = {['Сгусток ворвани'] = true, },
	['Эругоса'] = {['Изысканная он\'арская картошка'] = true, ['Слоеное тесто'] = true, ['Темный тальдразийский какао-порошок'] = true, ['Ассорти из четырех тертых сыров'] = true, },
    ['Грак'] = {['Зеленая ягода'] = true, ['Свежий драконов фрукт'] = true, ['Сочный кустоплод'] = true, ['Сушеный морозный стрелолист'] = true, },
	['Хану'] = {['Глаз окуня'] = true, },
    ['Главный шеф-повар Измельчатор'] = {['Порции: десерт из скорпида'] = true, ['Порции: шахтерская похлебка из моллюсков'] = true, ['Порции: похлебка Западного края'] = true, ['Порции: мясо в соусе "Дыхание дракона"'] = true, },
	['Старейшина Наппа'] = {['Знаменитый чай Наппы'] = true, },
    ['Джунник'] = {['Плечики тысячезубой пираньи'] = true, },
	['Джинкутук'] = {['Куски вяленой рыбы'] = true, },
	['Норукк'] = {['Универсальный рыбный порошок Норукка'] = true, },
    ['Патчу'] = {['Кусочки рыбы-гиганта'] = true, },
	['Куариин Дотур'] = {['Зуброн с семью специями'] = true, ['Пламенный аргали'] = true, ['Трижды жаренные ребра мамонта'] = true, ['"Вулканная" утка'] = true, },
    ['Роккутук'] = {['Чернила глубинного осьминога'] = true, },
	['Таттукиака'] = {['Ферментированная паста из скумбрии'] = true, },
    ['Тикукк'] = {['Вяленый островной краб'] = true, },
	['Тууканит'] = {['Горячее молоко косатки'] = true, },
}   

local function p(msg)
    print("[ZAMESTOTV: Большое пиршество] " .. msg)
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
            p("Купил: " .. name)
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
