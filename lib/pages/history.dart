import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'dashboard.dart';
import 'package:flutter/services.dart';

import '../helpers/transactionHelper.dart';
import '../models/transaction.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List histories = [];

  TransactionHelper transactionHelper = TransactionHelper();

  Future initialize() async {
    try {
      var transactions = await transactionHelper.fetchTransactions();

      // SORT BY DATE
      transactions.sort((a, b) {
        final dateA = DateFormat("yMMMMd", "en_US").parse(a.date);
        final dateB = DateFormat("yMMMMd", "en_US").parse(b.date);
        return dateB.compareTo(dateA);
      });

      setState(() {
        histories = transactions;
      });
    } catch (e) {
      print(e);
    }
  }

  String formatAmount(String amount) {
    var doubleFormatted = double.parse(amount);
    final formatter = NumberFormat("#,##0.00", "id_ID");
    return formatter.format(doubleFormatted);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: const Color.fromARGB(73, 0, 170, 20),
      useDefaultLoading: false,
      overlayOpacity: 0.4,
      overlayWidget: const Center(
        child: SpinKitWanderingCubes(
          color: Color.fromARGB(255, 0, 170, 19),
          size: 50.0,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "History Cash Flow",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 16.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: histories.length,
                        itemBuilder: (context, index) {
                          final transaction = histories[index];
                          return Card(
                            elevation: 3.0, // Adjust the elevation as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the border radius as needed
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8.0),
                              child: ListTile(
                                trailing: CircleAvatar(
                                  backgroundColor: transaction.type == "Income"
                                      ? const Color.fromARGB(255, 4, 151, 22)
                                      : const Color.fromARGB(255, 223, 11, 11),
                                  radius: 25,
                                  child: Icon(
                                    transaction.type == "Income"
                                        ? Icons.add
                                        : Icons.remove,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    size: 50.0,
                                  ), //CircleAvatar
                                ),
                                title: Text(
                                  "${transaction.type == 'Income' ? '[+] ' : '[-] '}Rp ${formatAmount(transaction.amount)}",
                                  style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      transaction.description,
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      transaction.date,
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 3, 201, 26),
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    ),
                  );
                },
                child: Text(
                  '<< Back',
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
