hook.Add("playerWalletChanged", "DistributeTaxRevenue", function(ply, amount)
    -- 금액이 감소한 경우(세금 징수일 때만 처리)
    if amount >= 0 then return end

    local taxCollected = math.abs(amount) -- 징수된 세금 (양수로 변환)
    local players = player.GetAll()

    -- 각 직업별 보상 설정
    local policeReward = math.min(math.floor(taxCollected * 0.025), 250)
    local swatReward = math.min(math.floor(taxCollected * 0.05), 500)
    local chiefReward = math.min(math.floor(taxCollected * 0.10), 1000)
    local mayorReward = math.min(math.floor(taxCollected * 0.25), 2500)

    for _, target in ipairs(players) do
        if target:Team() == TEAM_POLICE and policeReward > 4 then
            target:addMoney(policeReward)
            target:ChatPrint("징수된 세금으로부터 " .. policeReward .. "$ 를 받았습니다")
        end
    end
    for _, target in ipairs(players) do
        if target:Team() == TEAM_SWAT and swatReward > 4 then
            target:addMoney(swatReward)
            target:ChatPrint("징수된 세금으로부터 " .. swatReward .. "$ 를 받았습니다")
        end
    end
    for _, target in ipairs(players) do
        if target:Team() == TEAM_CHIEF and chiefReward > 4 then
            target:addMoney(chiefReward)
            target:ChatPrint("징수된 세금으로부터 " .. chiefReward .. "$ 를 받았습니다")
        end
    end
    for _, target in ipairs(players) do
        if target:Team() == TEAM_MAYOR and mayorReward > 444 then
            target:addMoney(mayorReward)
            target:ChatPrint("징수된 세금으로부터 " .. mayorReward .. "$ 를 받았습니다")
        end
    end
end)
