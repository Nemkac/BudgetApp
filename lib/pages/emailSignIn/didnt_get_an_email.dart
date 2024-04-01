import 'package:flutter/material.dart';
import 'package:cut_budget/components/Button.dart';

class DidntGetAnEmail extends StatelessWidget {
  const DidntGetAnEmail({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: const SizedBox(
        height: 443,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Text(
                'Didn’t get an email?',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromRGBO(28, 27, 29, 1),
                  fontSize: 32.0,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Text(
                'If you did not receive the email, choose one of the options below.',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromRGBO(110, 108, 117, 1),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Button(
                iconPath: '',
                iconColor: Colors.white,
                buttonText: 'Send Again',
                buttonColor: Color.fromRGBO(243, 243, 244, 1),
                textColor: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
            SizedBox(height: 16),              
            Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Button(
                iconPath: '',
                iconColor: Colors.white,
                buttonText: 'Update Email',
                buttonColor: Color.fromRGBO(243, 243, 244, 1),
                textColor: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Button(
                iconPath: '',
                iconColor: Colors.white,
                buttonText: 'Contact Support',
                buttonColor: Color.fromRGBO(243, 243, 244, 1),
                textColor: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}