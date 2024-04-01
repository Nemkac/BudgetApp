// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:cut_budget/amplifyconfiguration.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cut_budget/components/Button.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cut_budget/pages/emailSignIn/check_your_email.dart';
//mport 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class ContinueWithEmail extends StatefulWidget {
  const ContinueWithEmail({super.key});

  @override
  _ContinueWithEmailState createState() => _ContinueWithEmailState();
}

class _ContinueWithEmailState extends State<ContinueWithEmail> {
  TextEditingController emailController = TextEditingController();

  String generateRandomPassword(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
  }

  Future<void> _sendMagicLink() async {
    try {
      final String email = emailController.text.trim();
      final String randomPassword = generateRandomPassword(30);
      
      final Map<AuthUserAttributeKey, String> userAttributes = {
        AuthUserAttributeKey.email: email,
        AuthUserAttributeKey.name: email,
      };
      await Amplify.Auth.signUp(
        username: email, 
        password: randomPassword,
        options: SignUpOptions(userAttributes: userAttributes),
      );
      print('Magic link sent successfully to $email');
    } catch (e) {
      // await Amplify.Auth.signIn(
      //   username: emailController.text.trim(),
      //   password: null,
      // );
      print('Error sending magic link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        toolbarHeight: 59,
        backgroundColor: const Color.fromRGBO(6, 14, 23, 1),
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage('assets/icon-back.png'),
            size: 24,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 56,
            color: const Color.fromRGBO(6, 14, 23, 1),
          ),
          Container(
            height: 123,
            color: const Color.fromRGBO(6, 14, 23, 1),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Log in easily without a password',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromRGBO(28, 27, 29, 1),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text(
                    'We’ll send you an email with a magic link that’ll log you in right away.',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(110, 108, 117, 1),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromRGBO(232, 231, 233, 1),
                        width: 1,
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email Address',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 34),
            child: Button(
              iconPath: '',
              buttonText: 'Send Magic Link',
              buttonColor: const LinearGradient(
                colors: [Color(0xFF6372FC), Color(0xFF5665E9)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              nextPage: const CheckYourEmailState(),
              onPressedCallback: _sendMagicLink,
            ),
          ),
        ],
      ),
    );
  }
}