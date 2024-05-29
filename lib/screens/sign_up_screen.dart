import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_scout/screens/login_screen.dart';
import 'package:trash_scout/services/auth_service.dart';
import 'package:trash_scout/services/firestore_service.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/custom_button.dart';
import 'package:trash_scout/shared/widgets/custom_textform.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  String _error = '';

  Future<void> signUpUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: darkGreenColor,
          ),
        );
      },
    );

    setState(() {
      _error = '';
    });

    try {
      UserCredential userCredential =
          await _authService.signUpWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      //Mengupdate display name
      await _authService.updateDisplayName(
        userCredential.user,
        _nameController.text,
      );

      await _firestoreService.saveUserData(
        userCredential.user?.uid ?? '',
        _nameController.text,
        _emailController.text,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'weak-password':
            _error = 'Password terlalu lemah.';
            break;
          case 'email-already-in-use':
            _error = 'Email sudah digunakan oleh akun lain.';
            break;
          case 'invalid-email':
            _error = 'Email yang dimasukkan tidak valid.';
            break;
          default:
            _error = 'Terjadi kesalahan. Silakan coba lagi.';
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 60,
                    left: 16,
                    right: 16,
                  ),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/sign_up_asset.png'),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(
                    top: 23,
                    left: 16,
                    right: 16,
                    bottom: 66,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Buat Akun Anda',
                          style: boldTextStyle.copyWith(
                            fontSize: 26,
                            color: blackColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextform(
                            formTitle: 'Nama',
                            hintText: 'Masukan Nama',
                            controller: _nameController,
                          ),
                          const SizedBox(height: 8),
                          CustomTextform(
                            formTitle: 'Email',
                            hintText: 'Masukan Email',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 8),
                          CustomTextform(
                            formTitle: 'Kata Sandi',
                            hintText: 'Masukan Kata Sandi',
                            obscureText: true,
                            controller: _passwordController,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      CustomButton(
                        onPressed: () {
                          signUpUser();
                        },
                        buttonText: 'Daftar',
                      ),
                      if (_error.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _error,
                            style: regularTextStyle.copyWith(
                              color: redColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun? ',
                            style: mediumTextStyle.copyWith(
                              color: lightGreyColor,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Masuk',
                              style: semiBoldTextStyle.copyWith(
                                color: darkGreenColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
