-- ══════════════════════════════════════════════
--  徒步预约系统 · Supabase 数据库初始化 SQL
--  在 Supabase 后台 → SQL Editor 里粘贴并运行
-- ══════════════════════════════════════════════

-- 1. 活动表
CREATE TABLE activities (
  id               UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name             TEXT NOT NULL,
  activity_time    TIMESTAMPTZ NOT NULL,
  location         TEXT NOT NULL,
  difficulty       TEXT NOT NULL DEFAULT '中等',
  cost             NUMERIC(10,2) DEFAULT 0,
  max_participants INTEGER NOT NULL,
  meeting_point    TEXT NOT NULL,
  notes            TEXT,
  is_accepting     BOOLEAN DEFAULT TRUE,
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 预约表
CREATE TABLE reservations (
  id                UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  activity_id       UUID REFERENCES activities(id) ON DELETE CASCADE NOT NULL,
  name              TEXT NOT NULL,
  phone             TEXT NOT NULL,
  emergency_contact TEXT NOT NULL,
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 开放公开读写权限（前端页面密码保护管理功能）
ALTER TABLE activities  ENABLE ROW LEVEL SECURITY;
ALTER TABLE reservations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow all activities"   ON activities   FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow all reservations" ON reservations FOR ALL USING (true) WITH CHECK (true);
