import 'package:cut_budget/pages/emailSignIn/didnt_get_an_email.dart';
import 'package:flutter/material.dart';
import 'package:cut_budget/components/Button.dart';

class CheckYourEmailState extends StatefulWidget {
  const CheckYourEmailState({super.key});

  @override
  State<CheckYourEmailState> createState() => __CheckYourEmailStateState();
}

class __CheckYourEmailStateState extends State<CheckYourEmailState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        toolbarHeight: 59,
        backgroundColor: const Color.fromRGBO(6, 14, 23, 1),
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage('assets/icon-back.png'),
            size: 24,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            color: const Color.fromRGBO(6, 14, 23, 1),
          ),
          Container(
            height: 123,
            color: const Color.fromRGBO(6, 14, 23, 1),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Check your email!',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromRGBO(28, 27, 29, 1),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text(
                    'We sent an email to anabelle.hermosa@gmail.com with a magic link that’ll log you in.',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(110, 108, 117, 1),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  SizedBox(
                    width: 143,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.all(0.0) 
                            ),
                            onPressed: (){
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true, 
                                builder: (BuildContext builder){
                                return const DidntGetAnEmail();
                              });
                            }, 
                            child: Container(
                              width: 143,
                              height: 64.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: const Color.fromRGBO(240, 241, 255, 1) 
                              ),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, 
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'I didn’t get an email',
                                          style: TextStyle(
                                            fontFamily: 'Manrope',
                                            color: Color.fromRGBO(81, 93, 204, 1),
                                            fontSize: 12.0, 
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 34),
            child: Button(
              iconPath: '',
              buttonText: 'Open Email App',
              buttonColor: LinearGradient(
                colors: [Color(0xFF6372FC), Color(0xFF5665E9)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              nextPage: null,
              //onPressedCallback: _sendMagicLink,
              //() {
                // Funkcija koja ispisuje e-mail u konzoli
                // print('Entered email: ${emailController.text}');
                //_sendMagicLink(context);
              //},
            ),
          ),
        ],
      ),
    );
  }
}