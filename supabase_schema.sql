-- ═══════════════════════════════════════════════════════════════════════════
-- Exam Papers App — Supabase Schema + Seed Data
-- Run this entire file once in the Supabase SQL Editor.
-- Project: https://hsvgjgnfrtufrfswwoeu.supabase.co
-- ═══════════════════════════════════════════════════════════════════════════


-- ─────────────────────────────────────────────────────────────────────────────
-- 1. TABLES
-- ─────────────────────────────────────────────────────────────────────────────

-- Exams
CREATE TABLE IF NOT EXISTS exams (
  id           TEXT        PRIMARY KEY,
  name         TEXT        NOT NULL,
  short_name   TEXT        NOT NULL,
  description  TEXT        DEFAULT '',
  conducted_by TEXT        DEFAULT 'UPSC',
  color_value  INTEGER     NOT NULL,   -- Flutter Color.value (ARGB int)
  icon_name    TEXT        NOT NULL,   -- key from IconMapper in the app
  total_papers INTEGER     DEFAULT 0,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- Years available per exam
CREATE TABLE IF NOT EXISTS exam_years (
  id           SERIAL      PRIMARY KEY,
  exam_id      TEXT        NOT NULL REFERENCES exams(id) ON DELETE CASCADE,
  year         INTEGER     NOT NULL,
  paper_count  INTEGER     DEFAULT 0,
  is_latest    BOOLEAN     DEFAULT FALSE,
  UNIQUE (exam_id, year)
);

-- Categories per exam (e.g. "Prelims GS1", "CDS Maths")
CREATE TABLE IF NOT EXISTS categories (
  id           TEXT        PRIMARY KEY,
  exam_id      TEXT        NOT NULL REFERENCES exams(id) ON DELETE CASCADE,
  name         TEXT        NOT NULL,
  description  TEXT        DEFAULT '',
  icon_name    TEXT        NOT NULL,
  paper_count  INTEGER     DEFAULT 0
);

-- Individual question papers
CREATE TABLE IF NOT EXISTS papers (
  id               TEXT        PRIMARY KEY,
  exam_id          TEXT        NOT NULL REFERENCES exams(id) ON DELETE CASCADE,
  year             INTEGER     NOT NULL,
  category_id      TEXT        NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  category_name    TEXT        DEFAULT '',
  title            TEXT        NOT NULL,
  pdf_url          TEXT,
  download_url     TEXT,
  file_size_mb     NUMERIC(5,2),
  language         TEXT        DEFAULT 'English',
  total_questions  INTEGER,
  total_marks      INTEGER,
  duration_minutes INTEGER,
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. ROW LEVEL SECURITY  (public read — no auth required for browsing)
-- ─────────────────────────────────────────────────────────────────────────────

ALTER TABLE exams      ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_years ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE papers     ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read exams"      ON exams      FOR SELECT USING (true);
CREATE POLICY "Public read exam_years" ON exam_years FOR SELECT USING (true);
CREATE POLICY "Public read categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Public read papers"     ON papers     FOR SELECT USING (true);

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. INDEXES
-- ─────────────────────────────────────────────────────────────────────────────

CREATE INDEX IF NOT EXISTS idx_exam_years_exam_id ON exam_years (exam_id);
CREATE INDEX IF NOT EXISTS idx_categories_exam_id ON categories (exam_id);
CREATE INDEX IF NOT EXISTS idx_papers_exam_year   ON papers (exam_id, year, category_id);

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. SEED DATA — Exams
--    color_value = Flutter Color(0xFFRRGGBB).value
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO exams (id, name, short_name, description, conducted_by, color_value, icon_name, total_papers) VALUES
  ('upsc',                 'UPSC Civil Services',  'UPSC',    'Union Public Service Commission Civil Services Exam', 'UPSC', -14318069, 'account_balance', 120),
  ('cds',                  'CDS',                  'CDS',     'Combined Defence Services Examination',              'UPSC', -8638917,  'military_tech',   48),
  ('geo_scientist',        'Geo Scientist',         'Geo Sci', 'Combined Geo-Scientist Examination',                 'UPSC', -16678262, 'terrain',         36),
  ('capf',                 'CAPF',                 'CAPF',    'Central Armed Police Forces Examination',            'UPSC', -2348514,  'shield',          24),
  ('nda',                  'NDA',                  'NDA',     'National Defence Academy Examination',               'UPSC', -2654210,  'star',            60),
  ('engineering_services', 'Engineering Services', 'ESE',     'Engineering Services Examination',                  'UPSC', -16543214, 'engineering',     48)
ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. SEED DATA — Years  (2010–2025 for each exam)
-- ─────────────────────────────────────────────────────────────────────────────

DO $$
DECLARE
  exam_ids TEXT[] := ARRAY['upsc','cds','geo_scientist','capf','nda','engineering_services'];
  counts   INTEGER[] := ARRAY[8,4,3,2,4,4];
  eid TEXT;
  cnt INTEGER;
  yr INTEGER;
  idx INTEGER := 1;
BEGIN
  FOREACH eid IN ARRAY exam_ids LOOP
    cnt := counts[idx];
    FOR yr IN REVERSE 2025..2010 LOOP
      INSERT INTO exam_years (exam_id, year, paper_count, is_latest)
      VALUES (eid, yr, cnt, yr = 2025)
      ON CONFLICT (exam_id, year) DO NOTHING;
    END LOOP;
    idx := idx + 1;
  END LOOP;
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 6. SEED DATA — Categories
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO categories (id, exam_id, name, description, icon_name, paper_count) VALUES
  -- UPSC
  ('upsc_prelims_gs1',   'upsc', 'Prelims — GS Paper I',   'History, Geography, Polity, Economy & Environment',      'assignment',  15),
  ('upsc_prelims_csat',  'upsc', 'Prelims — CSAT',          'Civil Services Aptitude Test (Paper II)',                 'calculate',   15),
  ('upsc_mains_gs1',     'upsc', 'Mains — GS Paper I',      'Indian Heritage, History & Geography',                   'history_edu', 10),
  ('upsc_mains_gs2',     'upsc', 'Mains — GS Paper II',     'Governance, Constitution & International Relations',     'policy',      10),
  ('upsc_mains_gs3',     'upsc', 'Mains — GS Paper III',    'Economy, Environment, Technology & Disaster',            'eco',         10),
  ('upsc_mains_gs4',     'upsc', 'Mains — GS Paper IV',     'Ethics, Integrity & Aptitude',                           'balance',     10),
  ('upsc_mains_essay',   'upsc', 'Mains — Essay',           'Essay Paper (250 marks)',                                 'edit_note',   10),
  -- CDS
  ('cds_english',  'cds', 'English',          'English Language comprehension & grammar',       'translate',  8),
  ('cds_maths',    'cds', 'Mathematics',      'Arithmetic, Algebra, Trigonometry & Geometry',   'functions',  8),
  ('cds_gk',       'cds', 'General Knowledge','Current Affairs, History, Science & Geography',  'public',     8),
  -- Geo Scientist
  ('geo_paper1', 'geo_scientist', 'Geology — Paper I',   'General Geology & Geophysics',             'landscape', 5),
  ('geo_paper2', 'geo_scientist', 'Geology — Paper II',  'Geomorphology & Remote Sensing',            'water',     5),
  ('geo_paper3', 'geo_scientist', 'Geology — Paper III', 'Economic Geology & Mineral Resources',      'science',   5),
  -- CAPF
  ('capf_paper1', 'capf', 'Paper I — General Ability', 'General Studies, Reasoning & Awareness',         'menu_book', 5),
  ('capf_paper2', 'capf', 'Paper II — GS & Essay',     'General Studies, Essay & Comprehension',         'edit',      5),
  -- NDA
  ('nda_maths', 'nda', 'Mathematics',         'Algebra, Matrices, Calculus, Statistics',   'calculate', 10),
  ('nda_gat',   'nda', 'General Ability Test','English & General Knowledge',               'quiz',      10),
  -- Engineering Services
  ('ese_prelims_gst', 'engineering_services', 'Prelims — GST',        'General Studies & Engineering Aptitude',            'settings',               5),
  ('ese_civil',       'engineering_services', 'Civil Engineering',     'Structural, Geotechnical & Environmental Engg.',    'apartment',              5),
  ('ese_mechanical',  'engineering_services', 'Mechanical Engineering','Thermodynamics, Manufacturing & Design',            'precision_manufacturing', 5),
  ('ese_electrical',  'engineering_services', 'Electrical Engineering','Power Systems, Machines & Control',                 'bolt',                   5),
  ('ese_electronics', 'engineering_services', 'Electronics & Telecom', 'Analog, Digital, Signals & Communications',         'developer_board',        5)
ON CONFLICT (id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- 7. SEED DATA — Sample Papers  (3 sets × latest 3 years for every category)
--    Replace pdf_url / download_url with real storage paths when uploading PDFs.
-- ─────────────────────────────────────────────────────────────────────────────

DO $$
DECLARE
  cat RECORD;
  yr  INTEGER;
  i   INTEGER;
  sets TEXT[] := ARRAY['Set A','Set B','Set C'];
BEGIN
  FOR cat IN SELECT id, exam_id, name FROM categories LOOP
    FOR yr IN SELECT year FROM exam_years
              WHERE exam_id = cat.exam_id
              ORDER BY year DESC
              LIMIT 3 LOOP
      FOR i IN 1..3 LOOP
        INSERT INTO papers (
          id, exam_id, year, category_id, category_name,
          title, pdf_url, download_url,
          file_size_mb, language,
          total_questions, total_marks, duration_minutes
        ) VALUES (
          cat.exam_id || '_' || yr || '_' || cat.id || '_' || i,
          cat.exam_id,
          yr,
          cat.id,
          cat.name,
          yr || ' Question Paper — ' || sets[i],
          'https://storage.supabase.co/' || cat.exam_id || '/' || yr || '/' || cat.id || '/paper_' || i || '.pdf',
          'https://storage.supabase.co/' || cat.exam_id || '/' || yr || '/' || cat.id || '/paper_' || i || '.pdf',
          2.4 + (i - 1) * 0.6,
          'English',
          100 + (i - 1) * 20,
          200 + (i - 1) * 50,
          120
        )
        ON CONFLICT (id) DO NOTHING;
      END LOOP;
    END LOOP;
  END LOOP;
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Done. Verify with:
--   SELECT COUNT(*) FROM exams;       -- 6
--   SELECT COUNT(*) FROM exam_years;  -- 96 (6 exams × 16 years)
--   SELECT COUNT(*) FROM categories;  -- 22
--   SELECT COUNT(*) FROM papers;      -- 198 (22 categories × 3 years × 3 sets)
-- ─────────────────────────────────────────────────────────────────────────────
