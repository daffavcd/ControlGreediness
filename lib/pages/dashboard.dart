import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'history.dart';
import 'income.dart';
import 'outcome.dart';
import 'setting.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Color.fromARGB(73, 0, 170, 20),
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
                  "This Month Summary",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: <Widget>[
                  Text(
                    "Outcome : Rp. 500.000",
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color.fromARGB(255, 196, 6, 6),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Income : Rp. 500.000",
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color.fromARGB(255, 4, 151, 22),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // CHART HERE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(3),
                            onTap: () {
                              // NAVIGATWE
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Income(),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 170, 19),
                                      radius: 40,
                                      child: Icon(
                                        Icons.add,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 70.0,
                                      ), //CircleAvatar
                                    ),
                                    //CircleAvatar
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      "Add Income",
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(3),
                            onTap: () {
                              // NAVIGATWE
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Outcome(),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 223, 11, 11),
                                      radius: 40,
                                      child: Icon(
                                        Icons.remove,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 70.0,
                                      ), //CircleAvatar
                                    ), //CircleAvatar
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      "Add Outcome",
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(3),
                            onTap: () {
                              // NAVIGATWE
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const History(),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 235, 156, 9),
                                      radius: 40,
                                      child: Icon(
                                        Icons.receipt,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 50.0,
                                      ), //CircleAvatar
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      "History",
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ), //Column
                              ), //Padding
                            ), //SizedBox
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.black,
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(3),
                            onTap: () {
                              // NAVIGATWE
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Setting(),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 173, 151, 151),
                                      radius: 40,
                                      child: Icon(
                                        Icons.settings,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 50.0,
                                      ), //CircleAvatar
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ), //SizedBox
                                    Text(
                                      "Settings",
                                      style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ), //SizedBox
                        ),
                      ),
                    ],
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
