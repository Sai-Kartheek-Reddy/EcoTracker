import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';


class GraphApp extends StatefulWidget {
  @override
  _GraphAppState createState() => _GraphAppState();
}

class _GraphAppState extends State<GraphApp> {
  late List<SalesData> data;
  late int _todayDay;
  late int _daysInMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _todayDay = DateTime.now().day;
    _daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    _selectedDate = DateTime.now();
    data = [
      SalesData(1, 55),
      SalesData(2, 30),
      SalesData(3, 25),
      SalesData(4, 40),
      SalesData(5, 35),
      SalesData(6, 50),
      SalesData(7, 45),
      SalesData(8, 30),
      SalesData(9, 55),
      SalesData(10, 50),
      SalesData(11, 40),
      SalesData(12, 35),
      SalesData(13, 30),
      SalesData(14, 25),
      SalesData(15, 20),
      SalesData(16, 15),
      SalesData(17, 25),
      SalesData(18, 30),
      SalesData(19, 40),
      SalesData(20, 45),
      SalesData(21, 50),
      SalesData(22, 35),
      SalesData(23, 10),
      SalesData(24, 65),
      SalesData(25, 50),
      SalesData(26, 45),
      SalesData(27, 35),
      SalesData(28, 40),
      SalesData(29, 55),
      SalesData(30, 50),
      //SalesData(DateTime.now().day, 0.0) // today's data
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Select Date :',style: TextStyle(fontWeight: FontWeight.w400 , fontSize: 24),),
                        SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(DateFormat.yMd().format(_selectedDate)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 600,
                    child: SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                        minimum: DateTime(DateTime.now().year, DateTime.now().month, 1),
                        maximum: _selectedDate,
                        interval: 7,
                        dateFormat: DateFormat.d(),
                        axisLine: AxisLine(width: 3),
                        title: AxisTitle(text: 'Days'),
                      ),
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 70,
                        interval: 10,
                        axisLine: AxisLine(width: 3),
                        //title: AxisTitle(text: 'Emission in KG'),
                      ),
                      title: ChartTitle(text: 'Monthly Emission values'),
                      series: <LineSeries<SalesData, DateTime>>[
                        LineSeries<SalesData, DateTime>(
                          name: 'Carbon Emission \n${DateFormat.MMMM().format(DateTime.now())}',
                          dataSource: data,
                          xValueMapper: (SalesData sales, _) => DateTime(DateTime.now().year, DateTime.now().month, sales.day),
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          markerSettings: MarkerSettings(isVisible: true),
                        ),
                      ],
                      //legend: Legend(isVisible: false),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final DateTime lastDayOfMonth =
    DateTime(now.year, now.month + 1, 0).add(Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: firstDayOfMonth,
      lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      selectableDayPredicate: (DateTime date) {
        return date.isAfter(firstDayOfMonth.subtract(Duration(days: 1))) &&
            date.isBefore(lastDayOfMonth);
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        data[data.length - 1] = SalesData(_selectedDate.day, 0);
      });
    }
  }
}

class SalesData {
  SalesData(this.day, this.sales);

  final int day;
  final double sales;
}