-- 저장 경로: garrysmod/addons/myaddon/lua/autorun/cl_entityinfo.lua

-- 설정
local ENTITY_CONFIG = {
    {
        class = "microwave",
        description = "일정 금액을 지불하고 음식을 소환합니다.",
    },
    {
        class = "spawned_shipment",
        description = "상자 위에 표시된 무기를 지급합니다.",
    },
    {
        class = "sent_arc_pinmachine",
        description = "현장에서 카드거래를 할 때에 사용되는 카드기입니다.",
    },
    {
        class = "st_food_neu_fridge",
        description = "상호작용하여 선택한 음식을 조리합니다.",
    },
    {
        class = "st_food_neu_vendor",
        description = "100$로 물을 구매할 수 있는 자판기입니다.",
    },
    {
        class = "ellas_gun_license_buyer",
        description = "이 엔티티로 건 라이센스를 구매할 수 있습니다.",
    },
    {
        class = "itemstore_bank",
        description = "보관중인 엔티티를 금고에 저장할 수 있습니다.",
    },
    {
        class = "dirty_laundry_cart",
        description = "세탁이 필요한 옷을 꺼내는 통입니다.",
    },
    {
        class = "clean_laundry_cart",
        description = "세탁이 완료된 옷을 담고 상호작용시 돈을 지급합니다.",
    },
    {
        class = "cloth",
        description = "옷의 상태에 따라 세탁해야 하거나 바구니에 넣어 보수를 받을 수 있습니다.",
    },
    {
        class = "washing_machine",
        description = "세탁이 필요한 옷을 넣을 시 작동합니다.",
    },
    {
        class = "blender",
        description = "재료를 2개 담을 시 조합법에 따라 다양한 능력의 음료를 제조합니다.",
    },
    {
        class = "business_npc",
        description = "플레이어가 별도의 사업을 개시할 수 있도록 돕는 NPC입니다.",
    },
    {
        class = "st_brewery",
        description = "양조용 재료와 물을 넣어 술을 제조할 수 있습니다.",
    },
    {
        class = "stcasino_coinflip",
        description = "2인 이상이 필요한 동전 뒤집기 게임입니다.",
    },
    {
        class = "stcasino_doublenothing",
        description = "확률에 따라 넣은 돈의 2배씩 배율이 상승하는 게임입니다.",
    },
    {
        class = "stcasino_gascash",
        description = "GUESS와 TARGET의 숫자가 일치하면 돈을 받는 게임입니다.",
    },
    {
        class = "stcasino_jackspot",
        description = "확률에 따라 위에 표시된 당첨금을 받을 수 있는 슬롯머신 게임입니다.",
    },
    {
        class = "stcasino_ragingrubies",
        description = "일정 조건을 달성할 경우 상금을 받을 수 있는 슬롯머신 게임입니다.",
    },
    {
        class = "stcasino_wildcall",
        description = "수화기로 두자리 숫자를 맞히는 게임입니다.",
    },
    {
        class = "stnarc_chem_lab",
        description = "불량식품 재료가 충족되면 불량식품을 만드는 기계입니다.",
    },
    {
        class = "trash_trashcan",
        description = "거지로 상호작용시 쓰레기를 수집하여 재활용센터에 판매할 수 있습니다.",
    },
    {
        class = "trash_dumpster",
        description = "거지로 상호작용시 쓰레기를 수집하여 재활용센터에 판매할 수 있습니다.",
    },
    {
        class = "weed_npc",
        description = "정성스레 키운 화분의 식물을 판매할 수 있습니다.",
    },
    {
        class = "seed_ent",
        description = "텃밭에 접촉시키면 작물을 키우는 씨앗입니다.",
    },
    {
        class = "moneyjuice_extractor",
        description = "현금을 넣어야 영양제를 채울 수 있습니다.",
    },
    {
        class = "moneytree_pot",
        description = "돈이 자라는 마법 돈나무입니다.",
    },
    {
        class = "regularprinter",
        description = "돈을 제작하는 머니 프린터입니다.",
    },
    {
        class = "stone",
        description = "채광용 곡괭이를 사용하여 돌을 캘 수 있습니다.",
    },
    {
        class = "tree",
        description = "벌목용 도끼를 사용하여 벌목을 할 수 있습니다.",
    },
    {
        class = "darkrp_laws",
        description = "도시 내에서 지켜야 할 법을 나열한 법판입니다.",
    },
    {
        class = "gmt_tetris",
        description = "테트리스를 플레이할 수 있는 게임기입니다.",
    }
}

-- 설정 끝
local displayDistance = 256 -- 표시 거리 (유닛)
local lookDuration = 3 -- 설명 표시까지 걸리는 시간 (초)
local displayOffset = Vector(0, 10, 10) -- 크로스헤어 우측 오프셋

local targetEntity = nil
local lookStartTime = 0

-- HUD Paint Hook
hook.Add("HUDPaint", "EntityInfoHUD", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    -- 트레이스 설정
    local trace = ply:GetEyeTrace()
    local ent = trace.Entity

    -- 조건: 유효한 엔티티, 거리가 설정 값 이내, 목록에 있는 클래스일 경우
    if IsValid(ent) and ply:GetPos():Distance(ent:GetPos()) <= displayDistance then
        for _, config in ipairs(ENTITY_CONFIG) do
            if ent:GetClass() == config.class then
                if targetEntity ~= ent then
                    targetEntity = ent
                    lookStartTime = CurTime() -- 새로운 엔티티를 볼 때 시간 초기화
                end

                -- 소유자 정보 표시
                local text = "[" .. config.class .. "]"
                local screenPos = (trace.HitPos + displayOffset):ToScreen()

                draw.SimpleText(text, "DebugOverlay", screenPos.x, screenPos.y, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                -- 설명 표시 (3초 이상 바라볼 경우)
                if CurTime() - lookStartTime >= lookDuration then
                    local descText = "설명: " .. config.description
                    draw.SimpleText(descText, "DebugOverlay", screenPos.x, screenPos.y + 14, Color(255, 255, 100), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end

                return
            end
        end
    end

    -- 엔티티를 더 이상 보지 않으면 초기화
    targetEntity = nil
    lookStartTime = 0
end)
