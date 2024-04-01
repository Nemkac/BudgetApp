import 'package:cut_budget/pages/familyBudget/invite_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FamilyBudegetWidget extends StatefulWidget {
  const FamilyBudegetWidget({super.key});

  @override
  State<FamilyBudegetWidget> createState() => _FamilyBudegetWidgetState();
}

class _FamilyBudegetWidgetState extends State<FamilyBudegetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(75, 81, 89, 0.86),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Family',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                          ),
                        ),
                        TextSpan(
                          text: ' Budget',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'More Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(101, 116, 255, 1),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => const InviteMember()
                        )
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color:Color.fromRGBO(23, 32, 42, 1),
                        borderRadius: BorderRadius.all(Radius.circular(100))
                      ), 
                      child: Image.asset(
                        'assets/plus.png',
                        width: 5,
                        height: 5,
                        color: const Color.fromRGBO(208, 207, 211, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}