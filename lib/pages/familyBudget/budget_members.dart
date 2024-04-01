import 'package:cut_budget/components/Button.dart';
import 'package:cut_budget/components/familyBudget/member_card.dart';
import 'package:cut_budget/pages/familyBudget/invite_member_form.dart';
import 'package:flutter/material.dart';

class BudgetMembers extends StatefulWidget {
  const BudgetMembers({super.key});

  @override
  State<BudgetMembers> createState() => _BudgetMembersState();
}

class _BudgetMembersState extends State<BudgetMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Family Budget',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            color: Color.fromRGBO(28, 27, 29, 1),
          ),
        ),
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
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Group Manager',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Color.fromRGBO(28, 27, 29, 1)
                    ),
                  ),
                  SizedBox(height: 8,),
                  MemberCard(),
                  SizedBox(height: 24,),
                  Text(
                    'Pending Invites',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Color.fromRGBO(28, 27, 29, 1)
                    ),
                  ),
                  SizedBox(height: 8,),
                  MemberCard(),
                  SizedBox(height: 24,),
                  Text(
                    'Members',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Color.fromRGBO(28, 27, 29, 1)
                    ),
                  ),
                  SizedBox(height: 8,),
                  MemberCard(),
                  SizedBox(height: 8,),
                  MemberCard(),
                  SizedBox(height: 8,),
                  MemberCard(),
                  SizedBox(height: 8,),
                  MemberCard(),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Color.fromRGBO(232, 231, 233, 1),  
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invite members',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Color.fromRGBO(28, 27, 29, 1)
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    'Number of invites remaining',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Color.fromRGBO(110, 108, 117, 1)
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    'This party is just heating up. You’ve got chips, dip,and invites to spare. Who’s next?',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Color.fromRGBO(110, 108, 117, 1)
                    ),
                  ),
                  SizedBox(height: 32,),
                  Button(
                    iconPath: '', 
                    buttonText: 'Invite', 
                    buttonColor: LinearGradient(
                      colors: [Color(0xFF6372FC), Color(0xFF5665E9)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    nextPage: InviteMemberForm(),
                  ),
                  SizedBox(height: 16,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}