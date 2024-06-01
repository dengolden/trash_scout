import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_scout/screens/main_screen.dart';
import 'package:trash_scout/screens/sign_up_screen.dart';
import 'package:trash_scout/services/auth_service.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/custom_button.dart';
import 'package:trash_scout/shared/widgets/custom_textform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String _error = '';

// User Login
  Future<void> loginUser() async {
    showDialog(
      context: context,
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
      await _authService.loginUser(
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Conditional Error
      setState(() {
        switch (e.code) {
          case 'wrong-password':
            _error = 'Password yang dimasukkan salah.';
            break;
          case 'user-not-found':
            _error = 'Pengguna dengan email ini tidak ditemukan.';
            break;
          case 'invalid-email':
            _error = 'Email yang dimasukkan tidak valid.';
            break;
          default:
            _error = 'Terjadi kesalahan. Silakan coba lagi.';
            break;
        }
        Navigator.pop(context);
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 170,
                    left: 16,
                    right: 16,
                  ),
                  width: double.infinity,
                  height: 155,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login_asset.png'),
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
                          'Masuk ke Akun Anda',
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
                            formTitle: 'Email',
                            hintText: 'Masukan Email',
                            textInputType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          const SizedBox(height: 20),
                          CustomTextform(
                            formTitle: 'Kata Sandi',
                            hintText: 'Masukan Kata Sandi',
                            obscureText: true,
                            controller: _passwordController,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.topRight,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Lupa kata sandi',
                              style: mediumTextStyle.copyWith(
                                color: darkGreenColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        onPressed: () {
                          loginUser();
                        },
                        buttonText: 'Masuk',
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
                            'Belum punya akun? ',
                            style: mediumTextStyle.copyWith(
                              color: lightGreyColor,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Daftar',
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
