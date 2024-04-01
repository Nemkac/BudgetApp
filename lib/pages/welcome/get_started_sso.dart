import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cut_budget/pages/loading/signIn_loading.dart';
import 'package:cut_budget/pages/navigation_menu.dart';
import 'package:cut_budget/pages/profileDetails/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:cut_budget/components/Button.dart';
import 'package:cut_budget/pages/emailSignIn/continue_with_email.dart';

class GetStartedSSO extends StatefulWidget {
  const GetStartedSSO({super.key});

  @override
  State<GetStartedSSO> createState() => _GetStartedSSOState();
}

class _GetStartedSSOState extends State<GetStartedSSO> {
  Future<void> continueWithGoogle() async {
    try {
      SignInResult signInResult =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);

      if (signInResult.isSignedIn) {
        final currentUserAttributes = await Amplify.Auth.fetchUserAttributes();
        final hasGivenName = currentUserAttributes.any((attribute) =>
            attribute.userAttributeKey == AuthUserAttributeKey.givenName);
        final hasFamilyName = currentUserAttributes.any((attribute) =>
            attribute.userAttributeKey == AuthUserAttributeKey.familyName);

        if (hasGivenName && hasFamilyName) {
          //Navigator.pushReplacementNamed(context, '/');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationMenu(),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileDetails(),
              ));
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> continueWithFacebook() async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.facebook);
    } catch (e) {
      print('Error signing in with facebook $e');
    }
  }

  Future<void> continueWithX() async {
    try {
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.twitter);
    } catch (e) {
      print('Error signing in with X $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Get started with Cut',
            style: TextStyle(
              fontFamily: 'Manrope',
              color: Color.fromRGBO(28, 27, 29, 1),
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Please choose how you want to continue setting up your account',
            style: TextStyle(
              fontFamily: 'Manrope',
              color: Color.fromRGBO(110, 108, 117, 1),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 32,
          ),
          const Button(
            iconPath: 'assets/IconMail.png',
            iconColor: Colors.white,
            buttonText: 'Continue with Email',
            buttonColor: LinearGradient(
              colors: [Color(0xFF6372FC), Color(0xFF5665E9)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            nextPage: ContinueWithEmail(),
          ),
          const SizedBox(
            height: 16,
          ),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Or Continue With',
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(143, 143, 143, 1)),
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: Color.fromRGBO(232, 232, 232, 1),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Button(
            iconPath: 'assets/apple.png',
            iconColor: Colors.white,
            buttonText: 'Continue with Apple',
            buttonColor: Color.fromRGBO(0, 0, 0, 1),
          ),
          const SizedBox(
            height: 16,
          ),
          Button(
            iconPath: 'assets/google.png',
            buttonText: 'Continue with Google',
            buttonColor: const Color.fromRGBO(255, 255, 255, 1),
            borderColor: const Color.fromRGBO(232, 231, 233, 1),
            textColor: const Color.fromRGBO(28, 27, 29, 1),
            onPressedCallback: () async {
              try {
                // var currentUser = await Amplify.Auth.getCurrentUser();
                SignInResult signInResult = await Amplify.Auth.signInWithWebUI(
                    provider: AuthProvider.google);

                if (signInResult.isSignedIn) {
                  final currentUserAttributes =
                      await Amplify.Auth.fetchUserAttributes();
                  final hasGivenName = currentUserAttributes.any((attribute) =>
                      attribute.userAttributeKey ==
                      AuthUserAttributeKey.givenName);
                  final hasFamilyName = currentUserAttributes.any((attribute) =>
                      attribute.userAttributeKey ==
                      AuthUserAttributeKey.familyName);

                  if (hasGivenName && hasFamilyName) {
                    //Navigator.pushReplacementNamed(context, '/');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationMenu(),
                        ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileDetails(),
                        ));
                  }
                }
              } catch (e) {
                print('Error signing in with Google: $e');
              }
            },
            nextPage: const SignInLoading(socialMediaName: 'Google'),
          ),
          const SizedBox(
            height: 16,
          ),
          Button(
            iconPath: 'assets/X.png',
            iconColor: Colors.white,
            buttonText: 'Continue with X',
            buttonColor: const Color.fromRGBO(0, 0, 0, 1),
            onPressedCallback: continueWithX,
          ),
          const SizedBox(
            height: 16,
          ),
          Button(
            iconPath: 'assets/facebook.png',
            iconColor: Colors.white,
            buttonText: 'Continue with Facebook',
            buttonColor: const Color.fromRGBO(24, 119, 242, 1),
            nextPage: const ProfileDetails(),
            onPressedCallback: continueWithFacebook,
          ),
        ],
      ),
    );
  }
}
