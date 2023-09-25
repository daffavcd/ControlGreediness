import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'dashboard.dart';
import 'package:flutter/services.dart';

import 'package:sqflite/sqflite.dart';
import '../helpers/transactionHelper.dart';
import '../models/transaction.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  TransactionHelper transactionHelper = TransactionHelper();

  Future<void> insertIncome() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      final transaction = TransactionModel(
        date: dateController.text,
        amount: amountController.text,
        description: descriptionController.text,
        type: "Income",
      );

      context.loaderOverlay.show();
      await transactionHelper.addItem(transaction);
      context.loaderOverlay.hide();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data successfully added.')),
      );

      amountController.clear();
      dateController.clear();
      descriptionController.clear();

      var transactions = await transactionHelper.fetchTransactions();
      for (var transaction in transactions) {
        print(transaction.toString());
      }
    } catch (e) {
      print(e);
    }
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
                  "Add Income",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 170, 19), // Set border color
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 170, 19), // Set focused border color
                        ),
                      ),
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      hintText: 'Date',
                      filled: true,
                      labelText: 'Pick Date',
                      labelStyle: const TextStyle(
                        color:
                            Color.fromARGB(255, 0, 170, 19), // Set label color
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Color.fromARGB(255, 0, 170, 19),
                        ),
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        log(pickedDate
                            .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat.yMMMMd('en_US').format(pickedDate);
                        log(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        log("Date is not selected");
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the date';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: amountController,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Allow only numeric input
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        // Remove leading zeros
                        final newText = newValue.text.isEmpty
                            ? ''
                            : newValue.text.replaceFirst(RegExp('^0+'), '');
                        return TextEditingValue(
                          text: newText,
                          selection:
                              TextSelection.collapsed(offset: newText.length),
                        );
                      }),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 170, 19), // Set border color
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 170, 19), // Set focused border color
                        ),
                      ),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 0, 170, 19), // Set label color
                      ),
                      hintText: 'Amount',
                      filled: true,
                      labelText: 'Insert Amount',
                      prefixText: "Rp. ",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please insert the amount';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  child: TextFormField(
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 170, 19), // Set border color
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 0, 170, 19), // Set focused border color
                        ),
                      ),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      labelStyle: TextStyle(
                        color:
                            Color.fromARGB(255, 0, 170, 19), // Set label color
                      ),
                      hintText: 'Description',
                      filled: true,
                      labelText: 'Insert Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please insert the description';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 212, 152, 21),
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () {
                            amountController.clear();
                            dateController.clear();
                            descriptionController.clear();
                          },
                          child: Text(
                            'Reset',
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 65, 131, 255),
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              insertIncome();
                            }
                          },
                          child: Text(
                            'Save',
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
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
