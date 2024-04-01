import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:collection/collection.dart';
import 'package:cut_budget/pages/homeScreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  String? _userInitials;
  String? userImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    loadBudget();
  }

  Future<void> _loadUserInfo() async {
    try {
      final userAttributes = await Amplify.Auth.fetchUserAttributes();

      final givenName = userAttributes.firstWhereOrNull((attribute) =>
          attribute.userAttributeKey == AuthUserAttributeKey.givenName);
      final familyName = userAttributes.firstWhereOrNull((attribute) =>
          attribute.userAttributeKey == AuthUserAttributeKey.familyName);
      final userImageUrl = userAttributes.firstWhereOrNull((attribute) =>
          attribute.userAttributeKey == AuthUserAttributeKey.picture);
      _userInitials =
          '${givenName?.value[0]}${familyName?.value[0]}'.toUpperCase();
      print("User initals: $_userInitials");
    } catch (e) {
      print("User not logged In");
    }
  }

  Future<void> loadBudget() async {
    try{
      final response = await Amplify.API.get('https://tqtdyh7b97.execute-api.eu-north-1.amazonaws.com/budget').response;
      //final response = await Amplify.API.get('/budgets').response;
      log(response.decodeBody());
    } catch(e){
      log('Error fetching budget: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: const Color.fromRGBO(6, 14, 23, 1),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: userImageUrl != null
              ? ClipOval(
                  child: Image.network(
                    userImageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
              : Text(
                  _userInitials ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
      body: Obx(
        () => controller.screens[controller.index.value],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 64,
          indicatorColor: Colors.transparent,
          elevation: 0,
          selectedIndex: controller.index.value,
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          onDestinationSelected: (index) => controller.index.value = index,
          destinations: [
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/Home.png'),
                size: 20,
                color: controller.index.value == 0 ? Colors.black : Colors.grey,
              ),
              label: controller.index.value == 0 ? 'Home' : '',
            ),
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/budget.png'),
                size: 20,
                color: controller.index.value == 1 ? Colors.black : Colors.grey,
              ),
              label: controller.index.value == 1 ? 'Budget' : '',
            ),
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/pie.png'),
                size: 20,
                color: controller.index.value == 2 ? Colors.black : Colors.grey,
              ),
              label: controller.index.value == 2 ? 'Analytics' : '',
            ),
            NavigationDestination(
              icon: ImageIcon(
                const AssetImage('assets/wallet.png'),
                size: 20,
                color: controller.index.value == 3 ? Colors.black : Colors.grey,
              ),
              label: controller.index.value == 3 ? 'Wallet' : '',
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> index = 0.obs;
  final screens = [
    const Homescreen(),
    Container(color: Colors.orange),
    Container(color: Colors.blue),
    Container(color: Colors.purple),
  ];
}
