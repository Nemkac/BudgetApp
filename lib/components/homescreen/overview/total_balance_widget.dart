import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TotalBalanceWidget extends StatefulWidget {
  const TotalBalanceWidget({super.key});

  @override
  State<TotalBalanceWidget> createState() => _TotalBalanceWidgetState();
}

class _TotalBalanceWidgetState extends State<TotalBalanceWidget> {
  // final balance = 36750.00;
  // final saved = 2850.00;
  // final incomes = 9600.00;
  // final expenses = 4300.00;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 212,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(75, 81, 89, 0.86),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        ' Balance',
                        style: TextStyle(
                          color:
                              Color.fromRGBO(138, 135, 146, 1),
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '€36.750,00',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Image.asset(
                        'assets/eye.png',
                        height: 14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'You saved',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(208, 207, 211, 1),
                        ),
                      ),
                      Text(
                        ' € 2.850,00',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(151, 255, 115, 1),
                        ),
                      ),
                      Text(
                        ' from last month',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(208, 207, 211, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container (
              height: 72,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), 
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/Income.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Incomes',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(110, 108, 117, 1),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '€ 9.600',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(6, 14, 23, 1)
                                        ),
                                      ),
                                      TextSpan(
                                        text: ',00',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
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
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/Expense.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Expenses',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(110, 108, 117, 1),
                                  ),
                                ),
                                const SizedBox(height: 4), 
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '€ 4.300',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(6, 14, 23, 1)
                                        ),
                                      ),
                                      TextSpan(
                                        text: ',00',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}