hook.Add("PreDrawHalos", "AddPlayerHalos", function()
    local ply = LocalPlayer()
    local trace = ply:GetEyeTrace()

    if not trace.Entity:IsPlayer() then return end

    local target = trace.Entity
    local teamColor = team.GetColor(target:Team())

    -- Halo Add by Their Team Color
    halo.Add({target}, teamColor, 2, 2, 1, true, false)
end)

hook.Add("HUDPaint", "DisplayPlayerInfo", function()
    local ply = LocalPlayer()
    local trace = ply:GetEyeTrace()

    if not trace.Entity:IsPlayer() then return end

    local target = trace.Entity
    local name = target:Nick() or "Unknown"
    local job = target:getDarkRPVar("job") or "Unemployed"
    local level = target:getDarkRPVar("level") or "N/A"
    local teamColor = team.GetColor(target:Team())

    -- HUD Draw
    draw.RoundedBox(10, ScrW() / 2 - 150, ScrH() - 100, 300, 70, Color(0, 0, 0, 150))
    draw.SimpleText("이름: " .. name, "Trebuchet24", ScrW() / 2, ScrH() - 95, teamColor, TEXT_ALIGN_CENTER)
    draw.SimpleText("직업: " .. job, "Trebuchet18", ScrW() / 2, ScrH() - 70, color_white, TEXT_ALIGN_CENTER)
    draw.SimpleText("레벨: " .. level, "Trebuchet18", ScrW() / 2, ScrH() - 50, color_white, TEXT_ALIGN_CENTER)
end)