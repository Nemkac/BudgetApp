import 'package:cut_budget/pages/homeScreen/homescreen.dart';
import 'package:flutter/material.dart';

class AllDone extends StatelessWidget {
  final String firstName;

  const AllDone({Key? key, required this.firstName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Homescreen(),
        ),
      );
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
            Text(
              'Hello $firstName',
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