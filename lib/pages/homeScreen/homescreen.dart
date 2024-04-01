import 'package:cut_budget/pages/homeScreen/categories.dart';
import 'package:cut_budget/pages/homeScreen/insights.dart';
import 'package:cut_budget/pages/homeScreen/overview.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: const Color.fromRGBO(6, 14, 23, 1),
          elevation: 0,
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(101, 116, 255, 1),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            isScrollable: false,
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromRGBO(138, 135, 146, 1),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Overview',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Insights',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Overview(),
            Insights(),
            Categories(),
          ],
        ),
      ),
    );
  }
}