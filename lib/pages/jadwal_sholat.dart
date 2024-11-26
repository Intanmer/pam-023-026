import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilepraktikum/data/jadwal_sholat.dart';
import 'package:mobilepraktikum/pages/jadwal_sholat_bulanan.dart';
import 'package:mobilepraktikum/services/api.dart';

class JadwalSholatPage extends StatefulWidget {
  @override
  _JadwalSholatPageState createState() => _JadwalSholatPageState();
}

class _JadwalSholatPageState extends State<JadwalSholatPage> {
  late Future<List<JadwalSalat>> jadwalSalat;
  final PrayerTimeApi api = PrayerTimeApi();

  @override
  void initState() {
    super.initState();
    jadwalSalat = api.fetchJadwalSalat();
  }

  String formatTanggal(String tanggal) {
    DateTime dateTime = DateTime.parse(tanggal);
    return DateFormat('d MMMM y').format(dateTime);
  }

  void _navigateToMonthlySchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlySchedulePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String todayString = DateFormat('d MMMM y').format(today);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00695C), Color(0xFF004D40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Wilayah: Sleman, DIY',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                todayString,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<JadwalSalat>>(
                future: jadwalSalat,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.white)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Tidak ada data tersedia',
                            style: TextStyle(color: Colors.white)));
                  } else {
                    List<JadwalSalat> allJadwalSalat = snapshot.data!;
                    String todayString =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());

                    List<JadwalSalat> jadwalHariIni = allJadwalSalat
                        .where((jadwal) => jadwal.tanggal == todayString)
                        .toList();

                    if (jadwalHariIni.isEmpty) {
                      return const Center(
                          child: Text('Jadwal tidak tersedia untuk hari ini',
                              style: TextStyle(color: Colors.white)));
                    }

                    return ListView.builder(
                      itemCount: jadwalHariIni.length,
                      itemBuilder: (context, index) {
                        JadwalSalat jadwal = jadwalHariIni[index];
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(prayer['label']!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                        Text(prayer['value']!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ElevatedButton(
                                    onPressed: _navigateToMonthlySchedule,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    child: const Text(
                                      'Lihat Jadwal Bulan Ini',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
