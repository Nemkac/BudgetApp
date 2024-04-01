import 'package:cut_budget/components/Button.dart';
import 'package:cut_budget/pages/familyBudget/invite_sent.dart';
import 'package:flutter/material.dart';

class InviteMemberForm extends StatefulWidget {
  const InviteMemberForm({super.key});

  @override
  State<InviteMemberForm> createState() => _InviteMemberFormState();
}

class _InviteMemberFormState extends State<InviteMemberForm> {
  TextEditingController inviteEmailController = TextEditingController();
  bool selectedBudget = false;

  void _toggleSelectedBudget(bool? value) {
    setState(() {
      selectedBudget = value ?? false;
    });
  }
  
  void _openInviteSentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        return const InviteSentModal();
      }
    );
  }


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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Invite members',
              style: TextStyle(
                fontFamily: 'Manrope',
                color: Color.fromRGBO(28, 27, 29, 1),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8,),
            const Text(
              '5 invites remaining',
              style: TextStyle(
                fontFamily: 'Manrope',
                color: Color.fromRGBO(110, 108, 117, 1),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 32,),
            TextField(
              controller: inviteEmailController,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color.fromRGBO(232, 231, 233, 1))
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Email Address',
              ),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32,),
            const Text(
              'Select your budget(s) to share',
              style: TextStyle(
                fontFamily: 'Manrope',
                color: Color.fromRGBO(28, 27, 29, 1),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Checkbox(value: selectedBudget, onChanged: _toggleSelectedBudget),
                const Text(
                  'Budget name #1',
                  style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromRGBO(28, 27, 29, 1),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(height: 32,),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromRGBO(233, 247, 255, 1),
              ),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Choose to share your budget(s) or keep them private. This member can always create a new budget-right out of thin air.',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color.fromRGBO(13, 70, 102, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32,),
            Button(
              iconPath: '', 
              buttonText: 'Invite', 
              buttonColor: const LinearGradient(
                colors: [Color(0xFF6372FC), Color(0xFF5665E9)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              onPressedCallback: () {
                _openInviteSentModal(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}