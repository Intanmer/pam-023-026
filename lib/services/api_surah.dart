// api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobilepraktikum/data/ayat.dart';

class ApiService {
  final String baseUrl = 'https://equran.id/api/surat';

  Future<List<Surah>> fetchSurahs() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Surah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load surahs');
    }
  }
}
