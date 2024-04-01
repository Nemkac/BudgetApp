import 'package:flutter/material.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({super.key});

  @override
  State<MemberCard> createState() => _MemberCartState();
}

class _MemberCartState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(243, 243, 244, 1),
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      padding: const EdgeInsets.all(16),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Username',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: Color.fromRGBO(55, 54, 58, 1),
            ),
          ),
          SizedBox(height: 4,),
          Text(
            'User email address',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              color: Color.fromRGBO(138, 135, 146, 1),
            ),
          ),
        ],
      ),
    );
  }
}