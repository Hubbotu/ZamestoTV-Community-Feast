local addonName, addon = ...
local listener = CreateFrame("Frame")
listener:RegisterEvent("CHAT_MSG_MONSTER_SAY")
listener:SetScript("OnEvent", function(self, event, text, monsterName)
    if event == "CHAT_MSG_MONSTER_SAY" then
        local mapID = C_Map.GetBestMapForUnit("player")
        if mapID ~= 2024 then return end

        for _, data in pairs(addon.db) do
            local announce = data.announce
            if announce and announce[GetLocale()] and (announce[GetLocale()] == text) then
                if C_Map.CanSetUserWaypointOnMap(mapID) then
                    local point = UiMapPoint.CreateFromCoordinates(2024, data.coordX / 100, data.coordY / 100)
                    C_Map.SetUserWaypoint(point)
                    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
                end
                if (C_AddOns.IsAddOnLoaded("TomTom")) then
                    addon.uid = TomTom:AddWaypoint(2024, data.coordX / 100, data.coordY / 100, { title = data.name[GetLocale()] })
                end
            end
        end
    end
end)