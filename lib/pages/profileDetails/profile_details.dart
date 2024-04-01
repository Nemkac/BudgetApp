import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cut_budget/pages/finishProfile/all_done.dart';
import 'package:cut_budget/pages/finishprofile/error.dart';
import 'package:collection/collection.dart';


class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool isButtonEnabled = false;
  bool agreedUsersTermsOfService = false;
  
  @override
  void initState() {
    super.initState();
    fetchUserData();
    emailController.text = 'example@email.com';
    firstNameController.addListener(updateButtonState);
    lastNameController.addListener(updateButtonState);
  }

  void fetchUserData() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final emailAttribute = attributes.firstWhereOrNull((attribute) => attribute.userAttributeKey == AuthUserAttributeKey.email);
      if (emailAttribute != null) {
        emailController.text = emailAttribute.value;
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  void updateButtonState() {
    setState(() {
      isButtonEnabled = firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty && agreedUsersTermsOfService;
    });
  }

  void _toggleAgreement(bool? value) {
    setState(() {
      agreedUsersTermsOfService = value ?? false;
      updateButtonState();
    });
  }

  void finishProfileSetup(BuildContext context, TextEditingController firstNameController, TextEditingController lastNameController) async {
    if (isButtonEnabled) {
      try {
        await Amplify.Auth.updateUserAttribute(userAttributeKey: AuthUserAttributeKey.givenName, value: firstNameController.text);
        await Amplify.Auth.updateUserAttribute(userAttributeKey: AuthUserAttributeKey.familyName, value: lastNameController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllDone(firstName: firstNameController.text),
          ),
        );
      } catch (e) {
        print('Error updating user attributes: $e');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Error(),
          ),
        );
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile Details',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromRGBO(28, 27, 29, 1),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromRGBO(232, 231, 233, 1),
                        width: 1,
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(243, 243, 244, 1),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromRGBO(232, 231, 233, 1),
                        width: 1,
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromRGBO(232, 231, 233, 1),
                        width: 1,
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty,
                          child: Checkbox(
                            value: agreedUsersTermsOfService,
                            onChanged: _toggleAgreement,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'I’ve read and agree with the User Terms of Service.',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        color: Color.fromRGBO(55, 54, 58, 1),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      'I understand that my personal data will be processed in accordance with Cut’s Privacy Statement.',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        color: Color.fromRGBO(55, 54, 58, 1),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Read more',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        color: Color.fromRGBO(101, 116, 255, 1),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 34),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                side: BorderSide.none,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                finishProfileSetup(context, firstNameController, lastNameController);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                height: 64.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: isButtonEnabled
                      ? const LinearGradient(
                          colors: [
                              Color(0xFF6372FC),
                              Color(0xFF5665E9)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : const LinearGradient(
                          colors: [
                              Color.fromRGBO(173, 176, 202, 1), 
                              Color.fromRGBO(173, 176, 202, 1)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Finish',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.white,
                              fontSize: 16.0, 
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}