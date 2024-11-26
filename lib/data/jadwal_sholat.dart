class JadwalSalat {
  final String imsyak;
  final String shubuh;
  final String dzuhur;
  final String ashr;
  final String magrib;
  final String isya;
  final String dhuha;
  final String terbit;
  final String tanggal;

  JadwalSalat({
    required this.imsyak,
    required this.shubuh,
    required this.dzuhur,
    required this.ashr,
    required this.magrib,
    required this.isya,
    required this.dhuha,
    required this.terbit,
    required this.tanggal,
  });

  factory JadwalSalat.fromJson(Map<String, dynamic> json) {
    return JadwalSalat(
      imsyak: json['imsyak'],
      shubuh: json['shubuh'],
      dzuhur: json['dzuhur'],
      ashr: json['ashr'],
      magrib: json['magrib'],
      isya: json['isya'],
      dhuha: json['dhuha'],
      terbit: json['terbit'],
      tanggal: json['tanggal'],
    );
  }
}
