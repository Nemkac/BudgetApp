import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InsightCard extends StatefulWidget {
  const InsightCard({super.key});

  @override
  State<InsightCard> createState() => _InsightCardState();
}

class _InsightCardState extends State<InsightCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(232, 231, 233, 1),
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(249, 249, 249, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/household.png', height: 48,),
            const SizedBox(height: 8,),
            const Text(
              'Spending',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.4,
                color: Color.fromRGBO(55, 54, 58, 1)
              ),
            ),
            const SizedBox(height: 8,),
            const Text(
              'You reached __% of your <Budget Name>',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(138, 135, 146, 1)
              ),
            )
            
          ],
        ),
      ),
    );
  }
}