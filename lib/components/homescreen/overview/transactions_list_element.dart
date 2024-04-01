import 'package:flutter/material.dart';

class TransactionsListElement extends StatefulWidget {
  const TransactionsListElement({Key? key});

  @override
  State<TransactionsListElement> createState() => _TransactionsListElementState();
}

class _TransactionsListElementState extends State<TransactionsListElement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Image.asset(
                'assets/Category.png',
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(6, 14, 23, 1),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Username',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(6, 14, 23, 1),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    ' • Description',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(138, 135, 146, 1),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            '- € 9.99',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 49, 49, 1)
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
        const Divider(
          color: Color.fromRGBO(243, 243, 244, 1), // Možete promeniti boju dividera po želji
          thickness: 1, // Debljina dividera
          height: 1, // Visina dividera
        ),
      ],
    );
  }
}
