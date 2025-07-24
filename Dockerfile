# ใช้ Python เวอร์ชั่น 3.10 เป็น Image พื้นฐาน
FROM python:3.10-slim

# ตั้งค่า Environment Variable สำหรับ Port ที่ Cloud Run จะใช้
ENV PORT 8080

# ตั้งค่า Working Directory ภายใน Container
WORKDIR /app

# คัดลอกไฟล์ requirements.txt เข้าไปใน Container
# ไฟล์นี้จะระบุว่าโปรเจกต์ของคุณต้องใช้ Library อะไรบ้าง
COPY requirements.txt .

# ติดตั้ง Library ที่จำเป็น
RUN pip install --no-cache-dir -r requirements.txt

# คัดลอกไฟล์โค้ดทั้งหมดในโปรเจกต์เข้าไปใน Container
COPY . .

# คำสั่งสำหรับรันแอปพลิเคชันของคุณเมื่อ Container เริ่มทำงาน
# แนะนำให้ใช้ gunicorn สำหรับ Production
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
