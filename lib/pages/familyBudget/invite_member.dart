import 'package:cut_budget/pages/familyBudget/invite_member_form.dart';
import 'package:flutter/material.dart';

class InviteMember extends StatelessWidget {
  const InviteMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 59,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage('assets/icon-back.png'),
            size: 24,
            color: Color.fromRGBO(6, 14, 23, 1),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Invite member',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromRGBO(28, 27, 29, 1),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Invite up to 5 people to your subscription without having to share your password.\nEach member of your group gets their own Cut account with the ability to create budgets and share them with other members.\nAs the group manager, you can choose to share your budgets or keep them private.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Color.fromRGBO(110, 108, 117, 1),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 96,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const InviteMemberForm())
                  );
                },
                child: Container(
                  width: double.infinity,
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
      ),
    );
  }
}