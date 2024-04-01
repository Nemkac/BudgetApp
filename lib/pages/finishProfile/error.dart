import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/checkmark-circle-02.png',
              width: 56,
              height: 56,
            ),
            const SizedBox(height: 16),
            const Text(
              'Something unexpected happened',
              style: TextStyle(
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