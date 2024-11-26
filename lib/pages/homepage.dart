// homepage.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilepraktikum/data/ayat.dart';
import 'package:mobilepraktikum/services/api_surah.dart';
import 'surah_detail.dart';
import 'doa.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ApiService apiService = ApiService();
  List<Surah> surahs = [];
  bool isLoading = true;
  String errorMessage = '';
  Set<String> favoriteSurahIds = {};

  @override
  void initState() {
    super.initState();
    fetchSurahs();
    fetchFavoriteSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      final fetchedSurahs = await apiService.fetchSurahs();
      setState(() {
        surahs = fetchedSurahs;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Gagal mengambil data. Silakan coba lagi.';
      });
    }
  }

  Future<void> fetchFavoriteSurahs() async {
    final snapshot = await _firestore.collection('favorites').get();
    setState(() {
      favoriteSurahIds = snapshot.docs.map((doc) => doc.id).toSet();
    });
  }

  Future<void> toggleFavorite(String surahId, Surah surahData) async {
    final collection = _firestore.collection('favorites');
    if (favoriteSurahIds.contains(surahId)) {
      await collection.doc(surahId).delete();
      setState(() {
        favoriteSurahIds.remove(surahId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('${surahData.namaLatin} telah dihapus dari favorit.')),
      );
    } else {
      final completeData = {
        'nama_latin': surahData.namaLatin,
        'arti': surahData.arti,
        'jumlah_ayat': surahData.jumlahAyat,
        'nomor': surahData.nomor,
      };
      await collection.doc(surahId).set(completeData);
      setState(() {
        favoriteSurahIds.add(surahId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('${surahData.namaLatin} telah ditambahkan ke favorit.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A8366), Color(0xFF165D45)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DoaPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.teal, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.menu_book,
                            size: 48, color: Colors.white),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Daily Blessings',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text('Doa Harian, Berkah Tanpa Batas.',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Text('Al-Qur\'an',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 16),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage.isNotEmpty
                        ? Center(child: Text(errorMessage))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: surahs.length,
                            itemBuilder: (context, index) {
                              final surah = surahs[index];
                              final surahId = surah.nomor.toString();
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3)),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(surah.namaLatin,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  subtitle: Text(
                                      '${surah.arti} - ${surah.jumlahAyat} ayat',
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          favoriteSurahIds.contains(surahId)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          toggleFavorite(surahId, surah);
                                        },
                                      ),
                                      Text(
                                        surah.nomor.toString(),
                                        style: const TextStyle(
                                            color: Colors.teal,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SurahDetailPage(
                                          surahNumber: surah.nomor.toString(),
                                          surahName: surah.nama,
                                          translation: surah.arti,
                                          revelationPlace: surah.tempatTurun,
                                          ayatCount: surah.jumlahAyat,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
