import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'surah_detail.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  Future<void> deleteFavorite(
      BuildContext context, String surahId, String namaLatin) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('favorites').doc(surahId).delete();

    // Tampilkan Snackbar setelah berhasil dihapus
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$namaLatin telah dihapus dari favorit.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A8366), Color(0xFF165D45)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('favorites').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada surah favorit.',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            } else {
              final favoriteDocs = snapshot.data!.docs;
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: favoriteDocs.length,
                itemBuilder: (context, index) {
                  final favorite =
                      favoriteDocs[index].data() as Map<String, dynamic>;

                  // Pastikan data memiliki field yang dibutuhkan
                  final namaLatin =
                      favorite['nama_latin'] ?? 'Nama tidak tersedia';
                  final arti = favorite['arti'] ?? 'Arti tidak tersedia';
                  final jumlahAyat = favorite['jumlah_ayat'] ?? 0;
                  final nomor = favorite['nomor'] ?? '-';

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        namaLatin,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '$arti - $jumlahAyat ayat',
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteFavorite(
                              context, favoriteDocs[index].id, namaLatin);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SurahDetailPage(
                              surahNumber: nomor.toString(),
                              surahName: namaLatin,
                              translation: arti,
                              revelationPlace: '',
                              ayatCount: jumlahAyat,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
