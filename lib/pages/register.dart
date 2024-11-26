import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilepraktikum/helper/helper_function.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void registerUser() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text != confirmpasswordController.text) {
      Navigator.pop(context);
      displayMessageToUser("Passwords don't match!", context);
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context); // Menutup dialog loading

        // Menampilkan pop-up setelah registrasi berhasil
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.teal, // Mengubah warna latar belakang
            title: const Text(
              'Success',
              style:
                  TextStyle(color: Colors.white), // Mengubah warna teks judul
            ),
            content: const Text(
              'Registration successful! You can now log in.',
              style:
                  TextStyle(color: Colors.white), // Mengubah warna teks konten
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(onTap: null)),
                  );
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.white), // Mengubah warna teks tombol
                ),
              ),
            ],
          ),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // Menutup dialog loading
        displayMessageToUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004D40),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo dengan lingkaran gradasi
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF80CBC4), Color(0xFF004D40)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Image.asset(
                      'images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Nama aplikasi
                const Text(
                  "Daily Blessing",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),

                const SizedBox(height: 40),

                // TextField untuk email
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                  textColor: Colors.black,
                  prefixIcon: Icons.email, // Ikon email
                ),
                const SizedBox(height: 20),

                // TextField untuk password
                MyTextField(
                  hintText: "Password",
                  obscureText: !_isPasswordVisible,
                  controller: passwordController,
                  textColor: Colors.black,
                  prefixIcon: Icons.lock, // Ikon gembok
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // TextField untuk konfirmasi password
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: !_isConfirmPasswordVisible,
                  controller: confirmpasswordController,
                  textColor: Colors.black,
                  prefixIcon: Icons.lock, // Ikon gembok
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Tombol Register
                MyButton(
                  text: "Register",
                  onTap: registerUser,
                ),

                const SizedBox(height: 20),

                // Teks navigasi ke login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TextField dengan ikon depan
class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Color textColor;
  final Widget? suffixIcon;
  final IconData? prefixIcon;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.textColor,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey[600])
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

// Tombol
class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[600],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
