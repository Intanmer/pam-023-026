import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilepraktikum/pages/jadwal_sholat.dart';
import 'package:mobilepraktikum/pages/profile.dart';
import 'package:mobilepraktikum/pages/favorite.dart';
import 'package:mobilepraktikum/pages/homepage.dart';
import 'appbar.dart'; // Import appbar.dart untuk custom app bar
import 'login.dart'; // Import login_page.dart untuk kembali ke halaman login

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

    return Scaffold(
      appBar: myAppBar(
        context,
        title: 'DAILY BLESSING APPS',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: currentIndex,
        builder: (context, index, child) {
          switch (index) {
            case 0:
              return const HomePage();
            case 1:
              return const FavoritePage();
            case 2:
              return JadwalSholatPage();
            case 3:
              return AnggotaKelompok();
            default:
              return const HomePage();
          }
        },
      ),
      bottomNavigationBar: _buildFloatingNavBar(context, currentIndex),
      extendBody: true, // Agar body memperluas area di bawah navbar
    );
  }

  Widget _buildFloatingNavBar(BuildContext context, ValueNotifier<int> currentIndex) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, index, child) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.yellow, // Warna latar navbar
            borderRadius: BorderRadius.circular(30), // Membuat navbar melengkung
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: index,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0, // Menghilangkan bayangan asli BottomNavigationBar
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            iconSize: 28,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            onTap: (index) => currentIndex.value = index,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Jadwal Sholat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

// Fungsi logout
void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage(onTap: null)),
  );
}
