import 'package:cut_budget/components/Button.dart';
import 'package:cut_budget/pages/familyBudget/budget_members.dart';
import 'package:flutter/material.dart';

class InviteSentModal extends StatefulWidget {
  const InviteSentModal({super.key});

  @override
  State<InviteSentModal> createState() => _InviteSentModalState();
}

class _InviteSentModalState extends State<InviteSentModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invite Sent',
              style: TextStyle(
                fontFamily: 'Manrope',
                color: Color.fromRGBO(28, 27, 29, 1),
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'We’ve sent the pigeon! juan.hermosa@gmail.com has been invited to join your group. You are currently sharing {Budget Name}',
              style: TextStyle(
                fontFamily: 'Manrope',
                color: Color.fromRGBO(110, 108, 117, 1),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'This invite will expire in 14 days. You can cancel or resent it at any time.',
              style: TextStyle(
                fontFamily: 'Manrope',
                color: Color.fromRGBO(110, 108, 117, 1),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 64,
            ),
            Button(
                iconPath: '', 
                buttonText: 'Got It!', 
                buttonColor: LinearGradient(
                  colors: [Color(0xFF6372FC), Color(0xFF5665E9)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                nextPage: BudgetMembers(),
              ),
          ],
        ),
      ),
    );
  }
}