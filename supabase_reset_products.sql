-- =====================================================
-- สคริปต์รีเซ็ตตาราง products สำหรับ Supabase
-- วิธีใช้: ไปที่ Supabase Dashboard > SQL Editor > New Query > Copy & Run
-- =====================================================

-- ลบตารางเก่า (รวมถึง foreign keys ถ้ามี)
DROP TABLE IF EXISTS products CASCADE;

-- สร้างตารางใหม่
CREATE TABLE products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  price NUMERIC(12, 2) NOT NULL DEFAULT 0,
  image_url TEXT DEFAULT 'https://via.placeholder.com/150',
  specs JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- เปิด RLS (Row Level Security) - ถ้าใช้
-- ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Policy สำหรับให้ทุกคนอ่านได้ (anon) - ปรับตามต้องการ
-- CREATE POLICY "Allow public read" ON products FOR SELECT USING (true);

-- Policy สำหรับให้ทุกคน insert/update/delete - สำหรับ dev; ควรจำกัดใน production
-- CREATE POLICY "Allow public write" ON products FOR ALL USING (true);

-- Realtime สำหรับ products (ถ้าใช้)
ALTER PUBLICATION supabase_realtime ADD TABLE products;

-- ใส่ข้อมูลตัวอย่าง
INSERT INTO products (name, category, price, specs, image_url) VALUES
  ('Intel Core i5-13400F', 'CPU', 1890000, '{"socket":"LGA1700","cores":"10-Core / 16-Thread","generation":"Gen 13"}', 'https://via.placeholder.com/150'),
  ('AMD Ryzen 5 7600', 'CPU', 2150000, '{"socket":"AM5","cores":"6-Core / 12-Thread","generation":"Zen 4"}', 'https://via.placeholder.com/150'),
  ('ASUS B760M Plus WiFi', 'Motherboard', 1250000, '{"socket":"LGA1700","supported-ram":"DDR5"}', 'https://via.placeholder.com/150'),
  ('Gigabyte B650 AORUS Elite', 'Motherboard', 1850000, '{"socket":"AM5","supported-ram":"DDR5"}', 'https://via.placeholder.com/150'),
  ('NVIDIA RTX 4060 8GB', 'GPU', 3990000, '{"vram":"8GB GDDR6"}', 'https://via.placeholder.com/150'),
  ('G.Skill Ripjaws 32GB DDR5', 'RAM', 890000, '{"capacity":"32GB","ram-type":"DDR5","bus-speed":"5600 MHz"}', 'https://via.placeholder.com/150'),
  ('Samsung 980 Pro 1TB NVMe', 'Storage', 1650000, '{"storage-type":"M.2 NVMe","storage-capacity":"1TB"}', 'https://via.placeholder.com/150'),
  ('Corsair RM750 80+ Gold', 'PSU', 1450000, '{"wattage":"750W","80plus":"80 Plus Gold"}', 'https://via.placeholder.com/150'),
  ('Lian Li O11 Dynamic', 'Case', 1890000, '{}', 'https://via.placeholder.com/150'),
  ('Cooler Master Hyper 212', 'CPU Cooler', 490000, '{"cooler-type":"Air","socket":"LGA1700"}', 'https://via.placeholder.com/150');
