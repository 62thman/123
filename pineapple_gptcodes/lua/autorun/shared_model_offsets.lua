PS_ItemOffsets = PS_ItemOffsets or {}

-- 특정 모델에 대한 위치, 각도, 크기 조정
PS_ItemOffsets.ModelOffsets = {
    ["models/player/alyx.mdl"] = {
        -- Head (모자)
        head = {
            pos = Vector(0, 0, 5),  -- 머리 위치 오프셋
            ang = Angle(0, 0, 0),    -- 머리 각도
            scale = 1.0              -- 크기
        },
        -- Waist (허리)
        waist = {
            pos = Vector(0, 0, 0),  -- 허리 위치 오프셋
            ang = Angle(0, 0, 0),   -- 허리 각도
            scale = 1            -- 크기
        }
    },
    ["models/player/foohysaurusrex.mdl"] = {
        head = {
            pos = Vector(0, 0, 14),
            ang = Angle(0, 0, 0),
            scale = 1.15
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1
        }
    },
    ["models/player/reimup.mdl"] = {
        head = {
            pos = Vector(0, 0, 1),
            ang = Angle(0, 0, 0),
            scale = 1.2
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1
        }
    },
    ["models/player/glados_p.mdl"] = {
        head = {
            pos = Vector(0, 0, 1),
            ang = Angle(0, 0, 0),
            scale = 1.2
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1
        }
    },
    ["models/akuld/triplebakapack/hatsunemiku.mdl"] = {
        head = {
            pos = Vector(0, 0, 1),
            ang = Angle(0, 0, 0),
            scale = 1.2
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.15
        }
    },
    ["models/akuld/triplebakapack/kasaneteto.mdl"] = {
        head = {
            pos = Vector(0, 0, 1),
            ang = Angle(0, 0, 0),
            scale = 1.2
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.15
        }
    },
    ["models/akuld/triplebakapack/akitaneru.mdl"] = {
        head = {
            pos = Vector(0, 0, 1),
            ang = Angle(0, 0, 0),
            scale = 1.2
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.15
        }
    },
    ["models/captainbigbutt/vocaloid/miku_classic.mdl"] = {
        head = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.05
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.15
        }
    },
    ["models/captainbigbutt/vocaloid/miku_append.mdl"] = {
        head = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.05
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.15
        }
    },
    ["models/player/62nd/drossel.mdl"] = {
        head = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1.45
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1
        }
    },
    ["models/player/cj.mdl"] = {
        head = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = .785
        },
        waist = {
            pos = Vector(0, 0, 0),
            ang = Angle(0, 0, 0),
            scale = 1
        }
    }
}

-- 기본값 (등록되지 않은 모델에 적용)
PS_ItemOffsets.DefaultOffset = {
    head = {
        pos = Vector(0, 0, 0),
        ang = Angle(0, 0, 0),
        scale = 1.0
    },
    waist = {
        pos = Vector(0, 0, 0),
        ang = Angle(0, 0, 0),
        scale = 1.0
    }
}

-- 특정 모델에 대한 오프셋을 반환하는 함수
function PS_ItemOffsets:GetOffset(model, itemType)
    return self.ModelOffsets[model:lower()] and self.ModelOffsets[model:lower()][itemType] or self.DefaultOffset[itemType]
end