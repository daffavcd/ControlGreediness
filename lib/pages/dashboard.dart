import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:fl_chart/fl_chart.dart';

import '../helpers/transactionHelper.dart';
import 'package:intl/intl.dart';

import 'history.dart';
import 'income.dart';
import 'outcome.dart';
import 'setting.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({required this.histories});
  final List histories;

  @override
  Widget build(BuildContext context) {
    return LineChart(sampleData1);
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 3,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_Income,
        lineChartBarData1_Outcome,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Rp 10k';
        break;
      case 2:
        text = 'Rp 50k';
        break;
      case 3:
        text = 'Rp 100k';
        break;
      case 4:
        text = 'Rp 500k';
        break;
      case 5:
        text = 'Rp 1000k';
        break;
      case 6:
        text = 'Rp 10000k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('AUG', style: style);
        break;
      case 1:
        text = const Text('SEP', style: style);
        break;
      case 2:
        text = const Text('OCT', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: const Color.fromARGB(255, 2, 172, 22).withOpacity(0.2),
              width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_Income => LineChartBarData(
        isCurved: true,
        color: const Color.fromARGB(255, 0, 255, 30),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: _getIncomeSpots(),
      );

  LineChartBarData get lineChartBarData1_Outcome => LineChartBarData(
        isCurved: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: _getOutcomeSpots(),
      );

  List<FlSpot> _getIncomeSpots() {
    List<FlSpot> incomeSpots = [];

    // Sort the histories list by date
    histories.sort((a, b) {
      final dateA = DateFormat("yMMMMd", "en_US").parse(a.date);
      final dateB = DateFormat("yMMMMd", "en_US").parse(b.date);
      return dateA.compareTo(dateB);
    });

    for (int i = 0; i < histories.length; i++) {
      final history = histories[i];
      if (history.type == "Income") {
        final incomeValue = double.parse(history.amount);
        double mappedValue;
        double monthInNumber;

        // Convert the date to a DateTime object
        final transactionDate =
            DateFormat("yMMMMd", "en_US").parse(history.date);

        // Extract the month as a double
        monthInNumber = transactionDate.month.toDouble();

        if (incomeValue <= 10000) {
          mappedValue = 1; // Represents 0-10000
        } else if (incomeValue <= 50000) {
          mappedValue = 2; // Represents 10000-50000
        } else if (incomeValue <= 100000) {
          mappedValue = 3; // Represents 'Rp 100k'
        } else if (incomeValue <= 500000) {
          mappedValue = 4; // Represents 'Rp 500k'
        } else if (incomeValue <= 1000000) {
          mappedValue = 5; // Represents 'Rp 1000k'
        } else {
          mappedValue = 6; // Represents 'Rp 10000k'
        }
        // CHANGE THE MINUS (-8.0) TO ADJUSTING THE LEAST OF THREE MONTH THAT YOU WANT (ASUMING I WANTT THE STARTING CHART TO BE AUGUST)
        // THE LIBRARY IS TOO LIMITED, IT"S ONLY PROVIDE STATIC GODDAMMINT
        incomeSpots.add(FlSpot(monthInNumber - 8.0, mappedValue));
      }
    }

    // print(incomeSpots);
    return incomeSpots;
  }

  List<FlSpot> _getOutcomeSpots() {
    List<FlSpot> outcomeSpots = [];

    // Sort the histories list by date
    histories.sort((a, b) {
      final dateA = DateFormat("yMMMMd", "en_US").parse(a.date);
      final dateB = DateFormat("yMMMMd", "en_US").parse(b.date);
      return dateA.compareTo(dateB);
    });

    for (int i = 0; i < histories.length; i++) {
      final history = histories[i];
      if (history.type == "Outcome") {
        final outcomeValue = double.parse(history.amount);
        double mappedValue;
        double monthInNumber;

        // Convert the date to a DateTime object
        final transactionDate =
            DateFormat("yMMMMd", "en_US").parse(history.date);

        // Extract the month as a double
        monthInNumber = transactionDate.month.toDouble();

        if (outcomeValue <= 10000) {
          mappedValue = 1; // Represents 0-10000
        } else if (outcomeValue <= 50000) {
          mappedValue = 2; // Represents 10000-50000
        } else if (outcomeValue <= 100000) {
          mappedValue = 3; // Represents 'Rp 100k'
        } else if (outcomeValue <= 500000) {
          mappedValue = 4; // Represents 'Rp 500k'
        } else if (outcomeValue <= 1000000) {
          mappedValue = 5; // Represents 'Rp 1000k'
        } else {
          mappedValue = 6; // Represents 'Rp 10000k'
        }
        // CHANGE THE MINUS (-8.0) TO ADJUSTING THE LEAST OF THREE MONTH THAT YOU WANT (ASUMING I WANTT THE STARTING CHART TO BE AUGUST)
        // THE LIBRARY IS TOO LIMITED, IT"S ONLY PROVIDE STATIC GODDAMMINT
        outcomeSpots.add(FlSpot(monthInNumber - 8.0, mappedValue));
      }
    }
    // print(outcomeSpots);

    return outcomeSpots;
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List histories = [];
  String totalOutcome = "0";
  String totalIncome = "0";

  TransactionHelper transactionHelper = TransactionHelper();

  Future initialize() async {
    double incomeTotal = 0;
    double outcomeTotal = 0;

    try {
      var transactions = await transactionHelper.fetchTransactions();

      // Get the current date
      final now = DateTime.now();

      for (var transaction in transactions) {
        // Parse the transaction date string into a DateTime object
        final transactionDate =
            DateFormat("yMMMMd", "en_US").parse(transaction.date);
        // print(transactionDate);
        // Check if the transaction date is in the current month and year
        if (transactionDate.month == now.month &&
            transactionDate.year == now.year) {
          if (transaction.type == "Income") {
            incomeTotal += double.parse(transaction.amount);
            // print(incomeTotal);
          } else {
            outcomeTotal += double.parse(transaction.amount);
          }
        }
      }

      setState(() {
        histories = transactions;
        totalIncome = formatAmount(incomeTotal);
        totalOutcome = formatAmount(outcomeTotal);
      });
    } catch (e) {
      print(e);
    }
  }

  String formatAmount(double amount) {
    final formatter = NumberFormat("#,##0.00", "id_ID");
    return formatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

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
                    "Outcome : Rp. $totalOutcome",
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
                    "Income : Rp. $totalIncome",
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
            Text(
              'Recent Activity Chart',
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 6),
                child: _LineChart(histories: histories),
              ),
            ),
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
