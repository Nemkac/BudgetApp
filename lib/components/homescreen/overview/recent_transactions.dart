import 'package:cut_budget/components/homescreen/overview/transactions_list_element.dart';
import 'package:flutter/material.dart';

class RecentTransactionsWidget extends StatefulWidget {
  const RecentTransactionsWidget({super.key});

  @override
  State<RecentTransactionsWidget> createState() => _RecentTransactionsWidgetState();
}

class _RecentTransactionsWidgetState extends State<RecentTransactionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(6, 14, 23, 1),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(110, 108, 117, 1)
                            ),
                          ),
                          Image.asset(
                            'assets/chevron-right.png',
                            height: 14,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const TransactionsListElement(),
                const TransactionsListElement(),
                const TransactionsListElement(),
                const TransactionsListElement(),
                const TransactionsListElement(),
                const TransactionsListElement(),
                const TransactionsListElement(),
                const TransactionsListElement(),
                const TransactionsListElement(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}