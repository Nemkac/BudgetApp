import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: const Color.fromRGBO(6, 14, 23, 1),
    );
  }
}