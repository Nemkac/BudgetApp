import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cut_budget/amplifyconfiguration.dart';
import 'package:flutter/material.dart';
import 'package:cut_budget/pages/welcome/welcome_tab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await configureAmplify();
  configureAmplify();
  runApp(CutBudgetMain());
}

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyAPI()]);
    await Amplify.configure(amplifyconfig);
    log('Amplify initialized successfully');
  } catch (e) {
    log('Failed to initialize Amplify: $e');
  }
}

class CutBudgetMain extends StatelessWidget {
  const CutBudgetMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        children: const [
          WelcomeCommon(welcomeType: WelcomeType.streamline),
          WelcomeCommon(welcomeType: WelcomeType.transparent_cost),
          WelcomeCommon(welcomeType: WelcomeType.family_budget),
        ],
      ),
    );
  }
}
