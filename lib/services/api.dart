import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobilepraktikum/data/jadwal_sholat.dart';

class PrayerTimeApi {
  // Fungsi untuk mengambil data dari API
  Future<List<JadwalSalat>> fetchJadwalSalat() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/sleman/2024/11.json'));

    if (response.statusCode == 200) {
      // Jika API berhasil mengembalikan data, parse JSON
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => JadwalSalat.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
