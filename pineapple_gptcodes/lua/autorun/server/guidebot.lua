-- 봇 채팅 목록
local botChats = {
    "/advert 안녕하세요, 저는 가이드 봇입니다!",
    "/advert 여기서 무엇을 해야 할지 모르겠다면 도움을 요청하세요!",
    "/advert 시민으로서 규칙을 준수하세요!",
    "/advert 프롭 블록킹은 허용되지 않습니다.",
    "/advert 건물 내 문을 잠그는 것을 잊지 마세요.",
    "/advert 돈을 벌고 싶다면 직업을 바꿔보세요.",
    "/advert 다른 플레이어들과 협력하면 더 재미있습니다!",
    "/advert 의사를 찾아가면 체력을 회복할 수 있습니다.",
    "/advert 시장이나 경찰은 서버의 중요한 직업입니다.",
    "/advert 이 서버의 규칙을 반드시 읽어보세요!",
    "/advert 경찰이 되면 무기 면허를 발급할 수 있습니다!",
	"/advert 상점 주인은 강도에 대비해 항상 문을 잠그세요!",
	"/advert 스폰 지역에 프롭을 놓으면 경고를 받을 수 있습니다.",
	"/advert 마약 제작은 돈을 벌 수 있지만 위험할 수 있습니다.",
	"/advert 은행 강도는 많은 돈을 벌 수 있지만 경찰을 조심하세요.",
	"/advert 의사는 부상당한 플레이어를 치료할 수 있습니다.",
	"/advert 무기 상인은 무기를 판매하여 많은 이익을 얻을 수 있습니다.",
	"/advert 건설 작업 시 프롭 제한에 유의하세요!",
	"/advert 경찰은 수상한 활동을 조사하고 체포할 수 있습니다.",
	"/advert ATM을 이용해 돈을 안전하게 보관하세요.",
	"/advert 다른 플레이어의 역할을 존중하며 즐기세요!",
}

-- 봇 소리 목록 (3가지 소리)
local botSounds = {
    "ambient/levels/labs/electric_explosion1.wav", -- 예시 소리 1
    "ambient/levels/labs/electric_explosion2.wav", -- 예시 소리 2
    "ambient/levels/labs/electric_explosion3.wav"  -- 예시 소리 3
}

-- 봇의 고정된 좌표 설정 (맵별로 다르게 지정)
local guideBotPosition = {
    gm_flatgrass = Vector(0, 0, 0),
    rp_downtown_v4c = Vector(0, 0, -5120),
    rp_construct_v1 = Vector(0, 0, -5120),
    rp_oviscity_gmc5 = Vector(0, 0, -5120)
    --rp_downtown_v4c = Vector(-1874.922241, -2414.572021, -131.968750)
}

-- 가이드 봇 설정
local guideBot = nil
local guideBotModel = "models/player/manatails/dipsy/player.mdl"
local guideBotJobName = "시민"
local guideBotRPName = "파인애플"

-- 봇 소환 함수
local function SpawnGuideBot()
    if not IsValid(guideBot) then
        guideBot = player.CreateNextBot("Guide")
        if IsValid(guideBot) then
            guideBot:SetModel(guideBotModel)
            guideBot:setDarkRPVar("job", guideBotJobName)
            guideBot:setRPName(guideBotRPName)

            -- 맵에 따라 위치와 방향 설정
            guideBot:SetPos(guideBotPosition[game.GetMap()] or Vector(0, 0, 0))
            guideBot:SetAngles(Angle(0, 0, 0))

            guideBot:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR) -- Physics Gun에 잡히지 않도록 설정
            guideBot:StripWeapons()
            guideBot:Give("keys")
            guideBot:SetHealth(200000000)
			guideBot:setRPName(guideBotRPName)

            -- 봇 스폰 후 3초 뒤 점프
            timer.Simple(3, function()
                if IsValid(guideBot) then
                    guideBot:SetVelocity(Vector(0, 0, 300)) -- 점프 실행
                end
            end)

            -- 봇이 랜덤 시간 간격으로 채팅
            timer.Create("GuideBotChat", math.random(320, 640), 0, function()
                if IsValid(guideBot) then
                    local randomChat = botChats[math.random(#botChats)]
                    guideBot:Say(randomChat)
			guideBot:setRPName(guideBotRPName)
                end
            end)

            -- 봇이 랜덤 시간 간격으로 소리 내기
            timer.Create("GuideBotSound", math.random(240, 600), 0, function()
                if IsValid(guideBot) then
                    local randomSound = botSounds[math.random(#botSounds)]
                    guideBot:EmitSound(randomSound) -- 무작위 소리 내기
                end
            end)
        end
    end
end

-- 봇 제거 함수
local function RemoveGuideBot()
    if IsValid(guideBot) then
        guideBot:Remove()
        guideBot = nil
        timer.Remove("GuideBotChat") -- 채팅 타이머 제거
        timer.Remove("GuideBotSound") -- 소리 타이머 제거
    end
end

-- 봇 리스폰 함수
local function RespawnGuideBotAfterDelay(delay)
    timer.Simple(delay, function()
        if not IsValid(guideBot) then
            SpawnGuideBot()
        end
    end)
end

-- 봇의 체력 및 배고픔 초기화 함수
local function ResetGuideBotHealthAndHunger()
    if IsValid(guideBot) then
        -- 체력 및 배고픔 초기화
        guideBot:setDarkRPVar("Energy", 100)
        guideBot:SetHealth(200000000)
		guideBot:setRPName(guideBotRPName)

        -- 봇의 위치와 각도를 지정된 위치로 이동
        guideBot:SetPos(guideBotPosition[game.GetMap()] or Vector(0, 0, 0))
        guideBot:SetAngles(Angle(0, 0, 0))
    end
end

-- 수배 처리 훅 (봇에게 수배를 걸 수 없도록 설정)
hook.Add("playerWanted", "GuideBotWantedBlock", function(ply, target, reason)
    if target == guideBot then
        ply:ChatPrint("가이드 봇에게는 수배를 걸 수 없습니다!") -- 수배 방지 메시지
        return false -- 수배 진행되지 않도록 반환
    end
end)

-- 봇 관리 함수
local function ManageGuideBot()
    if #player.GetAll() <= 6 then
        -- 플레이어 수가 1명 이상 6명 이하일 때만 봇을 스폰
        if not IsValid(guideBot) then
            RespawnGuideBotAfterDelay(5) -- 봇이 사망했을 경우 5초 뒤 리스폰
        end
    else
        -- 플레이어 수가 0명 이하이거나 6명 초과일 경우 봇 제거
        if IsValid(guideBot) then
            RemoveGuideBot()
        end
    end
end

-- 3분마다 봇의 체력과 배고픔을 초기화하고 위치 재설정
timer.Create("GuideBotHealthAndHungerReset", 180, 0, function()
    ResetGuideBotHealthAndHunger()
end)

-- 주기적으로 봇 관리
timer.Create("GuideBotManager", 60, 0, function()
    ManageGuideBot()
end)

-- AFK 및 배고픔 제약 무시
hook.Add("PlayerAFKCheck", "IgnoreGuideBotAFK", function(ply)
    if ply == guideBot then
        return false
    end
end)

hook.Add("HUDPaint", "DisableGuideBotHunger", function()
    if IsValid(guideBot) then
        guideBot:setDarkRPVar("Energy", 100)
    end
end)

hook.Add("PlayerInitialSpawn", "ReassignGuideBotName", function(ply)
    if IsValid(guideBot) then
        guideBot:setRPName(guideBotRPName)  -- 봇의 이름을 "파인애플"로 다시 지정
    end
end)
