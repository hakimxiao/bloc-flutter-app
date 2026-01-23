# DOKUMENTASI PENGUJIAN UNIT TEST & CODE COVERAGE FLUTTER

## 1. Pengertian

### 1.1 Unit Test
Unit Test adalah proses pengujian perangkat lunak yang dilakukan untuk menguji unit terkecil dari sebuah kode program (biasanya berupa fungsi atau method) secara terpisah. Tujuan dari unit test adalah memastikan bahwa setiap bagian kecil dari aplikasi berjalan sesuai dengan yang diharapkan.

Pada Flutter, unit test biasanya digunakan untuk:
- Menguji fungsi logika
- Menguji service atau datasource
- Menguji business logic tanpa melibatkan UI


### 1.2 Code Coverage
Code Coverage adalah metrik yang digunakan untuk mengukur seberapa besar bagian kode aplikasi (khususnya kode di folder `lib/`) yang telah dieksekusi saat proses pengujian.

Hasil code coverage biasanya ditampilkan dalam bentuk persentase (%), misalnya:
- 70% coverage berarti 70% baris kode telah diuji
- 30% sisanya belum diuji

Flutter secara default menghasilkan laporan coverage dalam format **LCOV**.


### 1.3 LCOV
LCOV adalah format standar untuk menyimpan data hasil code coverage. File LCOV biasanya bernama:
```
lcov.info
```

File ini berisi informasi:
- File mana yang diuji
- Baris kode mana yang dieksekusi
- Jumlah eksekusi tiap baris

LCOV **bukan laporan visual**, melainkan data mentah yang perlu dikonversi ke bentuk HTML agar mudah dibaca.


---

## 2. Tools yang Digunakan

1. **Flutter Test**
   - Digunakan untuk menjalankan unit test

2. **LCOV (format output)**
   - Format bawaan Flutter untuk coverage

3. **Coverde**
   - Tool Dart modern untuk:
     - Membaca file `lcov.info`
     - Menghitung persentase coverage
     - Menghasilkan laporan HTML
     - Digunakan sebagai alternatif `genhtml`

Coverde dipilih karena:
- Mudah digunakan di Windows
- Tidak bergantung pada Chocolatey
- Cocok untuk Flutter & Dart


---

## 3. Struktur Folder yang Digunakan

Struktur dasar project Flutter:

```
blog_app/
│
├── lib/
│   └── utils/
│       └── math_utils.dart
│
├── test/
│   └── my_test.dart
│
├── coverage/
│   ├── lcov.info
│   └── html/
│       └── index.html
│
└── pubspec.yaml
```

Keterangan:
- `lib/` → kode utama aplikasi (yang dihitung coverage-nya)
- `test/` → file unit test
- `coverage/` → hasil code coverage


---

## 4. Langkah-Langkah Pengujian

### 4.1 Membuat Kode yang Akan Diuji
Contoh file di folder `lib/`:

`lib/utils/math_utils.dart`
- Berisi fungsi sederhana
- Digunakan untuk memastikan coverage tidak kosong


### 4.2 Membuat Unit Test
File test harus:
- Berada di folder `test/`
- Memiliki fungsi `void main()`
- Memanggil kode dari folder `lib/`

Jika test tidak memanggil kode di `lib/`, maka coverage akan bernilai 0%.


### 4.3 Menjalankan Unit Test dan Coverage
Perintah:

```bash
flutter test --coverage
```

Hasil:
- Semua test dijalankan
- File `coverage/lcov.info` otomatis dibuat


---

## 5. Menghasilkan Laporan HTML (Visual)

Karena file `lcov.info` tidak mudah dibaca, maka perlu dikonversi menjadi laporan HTML.

### 5.1 Install Coverde

```bash
dart pub global activate coverde
```

Pastikan folder Pub Cache sudah terdaftar di PATH:
```
C:\Users\<username>\AppData\Local\Pub\Cache\bin
```


### 5.2 Generate HTML Report

```bash
coverde report --input coverage/lcov.info --output coverage/html
```


### 5.3 Membuka Hasil Coverage
Buka file berikut di browser:
```
coverage/html/index.html
```

Isi laporan HTML:
- Persentase total coverage
- Daftar file di folder `lib/`
- Baris kode berwarna:
  - Hijau → sudah diuji
  - Merah → belum diuji


---

## 6. Hal yang Diuji

Pada proses ini, yang diuji adalah:
- Fungsi atau logic di folder `lib/`
- Eksekusi baris kode saat unit test berjalan

Yang **tidak dihitung**:
- File di folder `test/`
- Kode yang tidak pernah dipanggil oleh test


---

## 7. Manfaat Pengujian & Code Coverage

1. Menjamin kualitas kode
2. Mengurangi bug pada aplikasi
3. Memastikan fungsi berjalan sesuai spesifikasi
4. Memudahkan maintenance kode
5. Menjadi bukti pengujian pada laporan KP / skripsi
6. Membantu developer mengetahui bagian kode yang belum diuji


---

## 8. Catatan Penting

- Coverage kecil di awal adalah hal yang normal
- Coverage tinggi tidak selalu berarti test berkualitas, namun coverage rendah menandakan kurangnya pengujian
- Fokus utama adalah **kualitas test**, bukan hanya persentase


---

## 9. Kesimpulan

Pengujian unit test dan code coverage pada Flutter dilakukan dengan memanfaatkan fitur bawaan Flutter (`flutter test --coverage`) yang menghasilkan file LCOV. File tersebut kemudian diproses menggunakan tool Coverde untuk menghasilkan laporan HTML yang informatif dan mudah dipahami.

Pendekatan ini merupakan praktik yang umum digunakan baik dalam lingkungan akademik maupun industri perangkat lunak.

---

(Dokumen ini dapat disimpan sebagai `dokumentasi.txt` atau disesuaikan menjadi laporan resmi sesuai kebutuhan.)

