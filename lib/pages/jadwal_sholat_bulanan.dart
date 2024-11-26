import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilepraktikum/data/jadwal_sholat.dart';
import 'package:mobilepraktikum/services/api.dart';

class MonthlySchedulePage extends StatefulWidget {
  @override
  _MonthlySchedulePageState createState() => _MonthlySchedulePageState();
}

class _MonthlySchedulePageState extends State<MonthlySchedulePage> {
  late Future<List<JadwalSalat>> jadwalSalat;
  final PrayerTimeApi api = PrayerTimeApi();

  @override
  void initState() {
    super.initState();
    jadwalSalat = api.fetchJadwalSalat(); // Ambil semua jadwal salat
  }

  String formatTanggal(String tanggal) {
    DateTime dateTime = DateTime.parse(tanggal);
    return DateFormat('d MMMM y').format(dateTime); // Format tanggal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat Bulan Ini'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00695C), Color(0xFF004D40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<JadwalSalat>>(
          future: jadwalSalat,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada data tersedia',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              List<JadwalSalat> allJadwalSalat = snapshot.data!;
              return ListView.builder(
                itemCount: allJadwalSalat.length,
                itemBuilder: (context, index) {
                  JadwalSalat jadwal = allJadwalSalat[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatTanggal(jadwal.tanggal),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          ...[
                            {'label': 'Imsyak', 'value': jadwal.imsyak},
                            {'label': 'Shubuh', 'value': jadwal.shubuh},
                            {'label': 'Terbit', 'value': jadwal.terbit},
                            {'label': 'Dhuha', 'value': jadwal.dhuha},
                            {'label': 'Dzuhur', 'value': jadwal.dzuhur},
                            {'label': 'Ashr', 'value': jadwal.ashr},
                            {'label': 'Maghrib', 'value': jadwal.magrib},
                            {'label': 'Isya', 'value': jadwal.isya},
                          ].map((prayer) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    prayer['label']!,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  Text(
                                    prayer['value']!,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
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
