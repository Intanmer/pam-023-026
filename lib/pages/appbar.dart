import 'package:flutter/material.dart';

// Kelas AppColors untuk mendefinisikan warna yang akan digunakan dalam aplikasi
class AppColors {
  static const Color black = Color(0xff2D3D49); // Warna hitam khusus
  static const Color primary = Color(0xFF4CA4DF); // Warna utama aplikasi
}

// Kelas AppFonts untuk mendefinisikan gaya teks pada aplikasi
class AppFonts {
  final BuildContext context; // Konteks untuk mendapatkan informasi tema atau media dari aplikasi

  AppFonts(this.context); // Konstruktor untuk menerima context

  TextStyle get appbarTitle {
    // Gaya teks untuk judul AppBar
    return const TextStyle(
      color: AppColors.primary, // Warna teks sesuai warna utama
      fontFamily: 'QuicksandBold', // Font kustom yang digunakan untuk judul
      fontSize: 18, // Ukuran font
    );
  }
}

// Fungsi myAppBar untuk membuat AppBar kustom
AppBar myAppBar(
  BuildContext context, {
  String title = '', // Judul yang ditampilkan di AppBar
  List<Widget>? actions, // Daftar widget pada sisi kanan AppBar
  bool leading = false, // Menentukan apakah ada tombol kembali
  VoidCallback? leadingAction, // Fungsi yang dipanggil saat tombol kembali ditekan
  ImageProvider? image, // Gambar kustom jika diperlukan untuk leading
  bool automaticImplyLeading = true, // Menentukan apakah icon kembali otomatis muncul
}) {
  return AppBar(
    centerTitle: true, // Mengatur agar judul di tengah
    title: Text(
      title,
      style: AppFonts(context).appbarTitle, // Menerapkan gaya teks dari AppFonts
    ),
    actions: actions, // Widget untuk sisi kanan AppBar
    elevation: 0, // Menghilangkan bayangan AppBar
    automaticallyImplyLeading: automaticImplyLeading, // Kontrol otomatis pada tombol kembali
    backgroundColor: Colors.transparent, // Latar belakang transparan
    leading: leading
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary), // Ikon tombol kembali dengan warna utama
            onPressed: leadingAction ?? () {
              Navigator.pop(context); // Aksi default untuk kembali ke halaman sebelumnya
            },
          )
        : null, // Jika `leading` false, tidak ada tombol kembali
  );
}
