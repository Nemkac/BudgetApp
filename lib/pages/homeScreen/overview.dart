import 'package:cut_budget/components/homescreen/overview/family_budget_widget.dart';
import 'package:cut_budget/components/homescreen/overview/recent_transactions.dart';
import 'package:cut_budget/components/homescreen/overview/total_balance_widget.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(6, 14, 23, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  TotalBalanceWidget(),
                  SizedBox(height: 24,),
                  FamilyBudegetWidget(),
                  SizedBox(height: 16,),
                ],
              ),
            ),
            RecentTransactionsWidget(),
          ],
        ),
      ),
    );
  }
}