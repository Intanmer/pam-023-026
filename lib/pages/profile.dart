import 'package:flutter/material.dart';

// Kelas utama AnggotaKelompok untuk halaman daftar anggota
class AnggotaKelompok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anggota Kelompok')), // Judul di AppBar
      body: Container(
        color: const Color(0xFFE8F5E9), // Warna latar belakang halaman
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount:
              anggotaData.length, // Jumlah item sesuai dengan data anggota
          itemBuilder: (context, index) {
            final anggota = anggotaData[index];
            return Center(
              child: _buildProfileCard(
                name: anggota['name']!, // Nama anggota
                nim: anggota['nim']!, // NIM anggota
                birthPlace: anggota['birthPlace']!, // Tempat dan tanggal lahir
                className: anggota['className']!, // Kelas
                imagePath: anggota['imagePath']!, // Path gambar profil
              ),
            );
          },
        ),
      ),
    );
  }

  // Fungsi untuk membuat kartu profil anggota
  Widget _buildProfileCard({
    required String name,
    required String nim,
    required String birthPlace,
    required String className,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0), // Jarak antar kartu
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar kartu profil
        borderRadius: BorderRadius.circular(20), // Sudut melengkung kartu
        border: Border.all(color: Colors.green, width: 2), // Border hijau
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna bayangan
            spreadRadius: 2, // Radius penyebaran bayangan
            blurRadius: 5, // Blur radius untuk bayangan
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imagePath), // Gambar profil
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center, // Teks nama di tengah
          ),
          const SizedBox(height: 10),
          _buildInfoField('NIM: $nim', Icons.person), // Informasi NIM
          _buildInfoField('Tempat dan Tanggal Lahir: $birthPlace',
              Icons.calendar_today), // Informasi tempat lahir
          _buildInfoField('Kelas: $className', Icons.school), // Informasi kelas
        ],
      ),
    );
  }

  // Fungsi untuk membuat field informasi tambahan dalam kartu profil
  Widget _buildInfoField(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar informasi
        borderRadius: BorderRadius.circular(15), // Sudut melengkung
        border: Border.all(color: Colors.green, width: 2), // Border hijau
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green), // Ikon informasi
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black), // Gaya teks
            ),
          ),
        ],
      ),
    );
  }
}

// Data anggota kelompok dalam bentuk list
final List<Map<String, String>> anggotaData = [
  {
    'name': 'Intan Merlinda',
    'nim': '124220026',
    'birthPlace': 'Bantul, 17 Mei 2004',
    'className': 'SI - C',
    'imagePath': 'images/fotoint.jpg', // Gambar profil Intan
  },
  {
    'name': 'Kesha Azka Afleni',
    'nim': '124220023',
    'birthPlace': 'Sinuruik, 21 September 2003',
    'className': 'SI - C',
    'imagePath': 'images/fotokesha.png', // Gambar profil Kesha
  },
];
