import 'package:flutter/material.dart';

class SignInLoading extends StatefulWidget {
  final String socialMediaName;

  const SignInLoading({Key? key, required this.socialMediaName}) : super(key: key);

  @override
  State<SignInLoading> createState() => _SignInLoadingState();
}

class _SignInLoadingState extends State<SignInLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(101, 116, 255, 1)),
              strokeWidth: 4,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading your ${widget.socialMediaName} account...',
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(110, 108, 117, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}