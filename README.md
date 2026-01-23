URUTAN PEMBUATAN 1. DOMAIN LAYER || PALING KRUSIAL
A. ENTITIES
B. REPOSITORIES (abstract)
C. USECASE
FLOWNYA :
KITA MAU MENGGUNAKAN USE CASE APA NANTI -> DIA AKAN MANGGIL REPOSITORY -> DAN REPOSITORY NYA MENGEMBALIKAN DATA ENTITAS NYA

URUTAN PEMBUATAN 2. DATA LAYER
Datanya diadakan dulu dan nanti akan di tampilan ke UI
A. MODEL
B. REPOSITORY (implementation) -> APA BEDANYA DENGAN REPOSITORY DOMAIN LAYER ? "YAITU DIA CLASS BIASA YANG BIASA DISEBUT CLASS IMPLEMENTASINYA | JADI REPOSITORY DI DATA LEYER ADALAH IMPLEMENTASI DARI DOMAIN LAYER"
C. DATA SOURCE
FLOWNYA :
BIKIN MODELNYA DULU JADI DI DOMAIN KITA SUDAH ADA ENTITAS CUMA TIDAK ADA FROM JSON TO JSONNYA NAH CONVERTNYA INI ADA DI DATA LAYER MODEL YANG TUGASNYA
MERUBAH JSON KE DART MODEL(INI MIRIP CUMA ADA TAMBAHAN FROM JSON TO JSON) DIMANA DI MODEL LAYER INI KITA MENGEKSTRENSI BUKAN ERQUATABLE LAGI MELAINKAN KELAS
ENTTITAS PADA DOMAIN LAYER KARENA DIA MENJADI INDUK DARI MODEL YANG ADA DI DATA LAYER.
SAAT KITA EKSTENSI SI ORANGTUA NYA YAITU ENTITAS MAKA AKAN MUNCUL MERAH KARENA KITA HARUS LEMPAR DATA NYA KE ORANG TUANYA MENGGUNAKAN METODE SUPER ->
BIKIN DATASOURCE MENENTUKAN PEMANGGILAN DATANYA DARI MANA APAKAH BE ATAU INTERNET MAUPUN LOCAL

# 📦 Data Layer – Penjelasan Lengkap & Terstruktur

Dokumentasi ini menjelaskan **urutan pembuatan Data Layer** dalam arsitektur **Clean Architecture**, sesuai dengan rangkuman materi yang telah dipelajari, dengan bahasa yang diperjelas dan konteks yang disempurnakan agar mudah dipahami dan siap digunakan sebagai **README.md**.

---

## 🎯 Tujuan Data Layer

**Data Layer** bertanggung jawab untuk:

- Menyediakan data ke aplikasi
- Mengambil data dari berbagai sumber (API, database lokal, cache, dll)
- Mengonversi data mentah (JSON, response API) menjadi bentuk yang bisa dipakai oleh **Domain Layer**

> ⚠️ **Catatan penting**:
> Data **selalu disiapkan terlebih dahulu di Data Layer**, lalu **diteruskan ke Domain Layer**, dan akhirnya **ditampilkan di UI (Presentation Layer)**.

---

## 🧱 Urutan Pembuatan Data Layer

### 1️⃣ Model

### 2️⃣ Repository (Implementation)

### 3️⃣ Data Source

Urutan ini **wajib diperhatikan** karena masing-masing saling bergantung.

---

## 🅰️ MODEL (Data Layer)

### 📌 Fungsi Model

Model di **Data Layer** memiliki tugas utama:

- Mengonversi data **JSON ↔ Dart Object**
- Menjadi penghubung antara **data mentah** dan **Entity di Domain Layer**

### 🧠 Perbedaan Entity vs Model

| Domain Layer               | Data Layer                 |
| -------------------------- | -------------------------- |
| **Entity**                 | **Model**                  |
| Murni logika bisnis        | Mengurus data & format     |
| Tidak tahu JSON            | Tahu `fromJson` & `toJson` |
| Biasanya pakai `Equatable` | Tidak perlu `Equatable`    |

### 🔗 Relasi Entity & Model

- **Entity** berada di **Domain Layer**
- **Model** berada di **Data Layer**
- **Model mewarisi (extends) Entity**

Artinya:

> Entity adalah **induk (parent)**, Model adalah **anak (child)**

### ⚠️ Kenapa Harus `extends Entity`?

Agar:

- Model **bisa langsung digunakan sebagai Entity**
- Repository tidak perlu konversi ulang
- Domain tetap bersih dari JSON

### 🔴 Kenapa Muncul Error (Merah)?

Saat Model meng-extends Entity:

- Constructor Entity **wajib diisi**
- Maka data harus dikirim ke induknya

Solusinya menggunakan **`super(...)`**

📌 Artinya:

> Data yang diterima Model akan **dilempar ke Entity** melalui constructor `super`

---

## 🅱️ REPOSITORY (Implementation – Data Layer)

### ❓ Apa Bedanya Repository Domain & Data Layer?

#### 📘 Repository (Domain Layer)

- Berupa **abstract class / interface**
- Berisi **kontrak** (method apa saja yang harus ada)
- Tidak tahu data dari mana

#### 📕 Repository (Data Layer)

- Berupa **class biasa (implementation)**
- Mengimplementasikan repository domain
- Berisi **logika pengambilan data sesungguhnya**

> ✅ **Kesimpulan penting**:
> Repository di Data Layer adalah **implementasi nyata** dari Repository di Domain Layer

### 📌 Tugas Repository Implementation

- Menentukan **sumber data** (API / local)
- Memanggil **Data Source**
- Mengembalikan **Entity** ke Domain Layer

Repository **tidak peduli UI**, dan **UI tidak tahu Data Source**.

---

## 🅲 DATA SOURCE

### 📌 Fungsi Data Source

Data Source bertugas:

- Mengambil data dari **sumber tertentu**
- Fokus pada **1 jenis sumber data**

### 📂 Jenis Data Source

- **Remote Data Source** → API / Backend / Internet
- **Local Data Source** → Database, SharedPreferences, Cache

### 🧠 Prinsip Penting

- Data Source **tidak tahu Repository**
- Repository yang memanggil Data Source
- Satu Data Source = satu sumber data

---

## 🔄 FLOW DATA SECARA KESELURUHAN

```text
API / Local Data
        ↓
Data Source
        ↓
Repository (Implementation)
        ↓
Entity (Domain Layer)
        ↓
Use Case
        ↓
UI / Presentation Layer
```

### 📌 Ringkasan Flow

1. **Entity sudah ada di Domain Layer** (tanpa JSON)
2. **Model dibuat di Data Layer** untuk konversi JSON
3. Model **extends Entity**
4. Data diisi ke Entity lewat `super`
5. **Data Source** mengambil data mentah
6. **Repository Implementation** mengolah & meneruskan
7. UI hanya menerima data siap pakai

---

## 🧩 Kesimpulan Akhir

- Domain Layer = logika bisnis (bersih & abstrak)
- Data Layer = urusan data (JSON, API, database)
- Model adalah jembatan Entity ↔ JSON
- Repository Data Layer = implementasi nyata
- Data Source = sumber data spesifik

> ✨ Dengan struktur ini, aplikasi menjadi:
>
> - Mudah dirawat
> - Mudah dites
> - Mudah dikembangkan
> - Tidak saling bergantung antar layer

---

📌 **Dokumentasi ini siap digunakan sebagai `README.md`**
Jika ingin versi **lebih singkat**, **ditambahkan diagram**, atau **contoh folder structure**, saya bisa bantu lanjutkan.
