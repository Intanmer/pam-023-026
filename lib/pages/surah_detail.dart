import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurahDetailPage extends StatefulWidget {
  final String surahNumber;
  final String surahName;
  final String translation;
  final String revelationPlace;
  final int ayatCount;

  const SurahDetailPage({
    Key? key,
    required this.surahNumber,
    required this.surahName,
    required this.translation,
    required this.revelationPlace,
    required this.ayatCount,
  }) : super(key: key);

  @override
  _SurahDetailPageState createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  List<dynamic> ayatList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAyatData();
  }

  Future<void> fetchAyatData() async {
    try {
      final response = await http.get(
        Uri.parse('https://equran.id/api/surat/${widget.surahNumber}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          ayatList = data['ayat'];
          isLoading = false;
        });
      } else {
        throw Exception('Gagal mengambil data ayat');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
      ),
      body: Container(
        color: Colors.teal, // Set background color to teal
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: ayatList.length,
                itemBuilder: (context, index) {
                  final ayat = ayatList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            ayat['ar'], // Ayat in Arabic
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ayat['tr'], // Transliteration
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ayat['idn'], // Indonesian translation
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
