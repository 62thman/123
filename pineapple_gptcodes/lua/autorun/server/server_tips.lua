--[[
local tips = {
    "팁 1: 경찰이 되면 무기 면허를 발급할 수 있습니다!",
    "팁 2: 상점 주인은 강도에 대비해 항상 문을 잠그세요!",
    "팁 3: 스폰 지역에 프롭을 놓으면 경고를 받을 수 있습니다.",
    "팁 4: 다른 직업의 플레이어와 협력하면 더 많은 돈을 벌 수 있습니다!",
    "팁 5: 마약 제작은 돈을 벌 수 있지만 위험할 수 있습니다.",
    "팁 6: 건축 시 프롭을 고정하여 안전하게 만드세요!",
    "팁 7: 은행 강도는 많은 돈을 벌 수 있지만 경찰을 조심하세요.",
    "팁 8: 의사는 부상당한 플레이어를 치료할 수 있습니다.",
    "팁 9: 시장은 세금을 설정하여 경제를 관리할 수 있습니다.",
    "팁 10: 무기 상인은 무기를 판매하여 많은 이익을 얻을 수 있습니다.",
    "팁 11: 건설 작업 시 프롭 제한에 유의하세요!",
    "팁 12: 경찰은 수상한 활동을 조사하고 체포할 수 있습니다.",
    "팁 13: 차고를 임대하여 차량을 안전하게 보관하세요.",
    "팁 14: ATM을 이용해 돈을 안전하게 보관하세요.",
    "팁 15: 경매를 통해 아이템을 높은 가격에 판매할 수 있습니다.",
    "팁 16: 다른 플레이어의 역할을 존중하며 즐기세요!"
}

-- 무작위 팁을 모든 플레이어에게 전송하는 함수
local function SendRandomTip()
    -- 무작위 팁 선택
    local randomTip = tips[math.random(#tips)]

    -- 모든 플레이어에게 채팅 메시지 전송
    for _, ply in ipairs(player.GetAll()) do
        ply:ChatPrint(randomTip)
    end
end

-- 10분마다 팁을 전송하는 타이머 설정
timer.Create("SendTipTimer", 600, 0, function()
    SendRandomTip()
end)
]]