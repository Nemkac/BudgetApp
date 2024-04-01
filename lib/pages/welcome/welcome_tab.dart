import 'package:flutter/material.dart';
import 'package:cut_budget/pages/welcome/get_started_sso.dart';

enum WelcomeType { streamline, transparent_cost, family_budget }

extension WelcomeTypeDesc on WelcomeType {
  String getHeadline() {
    switch (this) {
      case WelcomeType.streamline:
        return 'Streamline Your\nFinances';

      case WelcomeType.transparent_cost:
        return 'Transparent\nCost Tracking';
      case WelcomeType.family_budget:
        return 'Family Budget\nManagement';
    }
  }

  String getSubtext() {
    switch (this) {
      case WelcomeType.streamline:
        return 'Effortless expense tracking.\nSimplify financial management.';
      case WelcomeType.transparent_cost:
        return 'Snap receipts, auto-import transactions.\nReal-time balance check.';
      case WelcomeType.family_budget:
        return 'Manage finances together\nAchieve goals faster';
    }
  }
}

class WelcomeCommon extends StatelessWidget {
  final WelcomeType welcomeType;

  const WelcomeCommon({super.key, required this.welcomeType});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              welcomeType.getHeadline(),
              style: const TextStyle(
                fontFamily: 'Manrope',
                color: Color.fromRGBO(28, 27, 29, 1),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                welcomeType.getSubtext(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromRGBO(110, 108, 117, 1), // Boja teksta
                  fontSize: 16.0, // Veličina fonta
                  fontWeight: FontWeight.normal, // Debljina teksta
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext builder) {
                      return const GetStartedSSO();
                    });
              },
              child: Container(
                width: 361,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6372FC), Color(0xFF5665E9)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}
