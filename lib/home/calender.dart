import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MonthPage extends StatefulWidget {
  final String userName;

  MonthPage({required this.userName});

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  late List<DateTime> _daysInMonth;
  Map<DateTime, int> _values = {};

  @override
  void initState() {
    super.initState();
    _daysInMonth = _getDaysInMonth(DateTime.now());
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    var firstDayOfMonth = DateTime(month.year, month.month, 1);
    var lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    return List.generate(
        lastDayOfMonth.day - firstDayOfMonth.day + 1,
            (i) => DateTime(month.year, month.month, i + 1));
  }

  Widget _buildDateBox(DateTime date) {
    final editing = ValueNotifier<bool>(_values[date] != null);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(
            DateFormat('EEE dd').format(date),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ValueListenableBuilder(
              valueListenable: editing,
              builder: (context, isEditing, child) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        enabled: !isEditing,
                        initialValue: _values[date]?.toString(),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,4}'),
                            replacementString: '',
                          ),
                        ],
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(() {
                            _values[date] = (value == null ? null : num.parse(value).toInt())!;
                          });
                        },
                        onFieldSubmitted: (_) {
                          editing.value = false;
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Hello, ${widget.userName}!',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.55,),
                  Text(
                    DateFormat('MMMM').format(DateTime.now()),
                    style: TextStyle(fontSize: 24, ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: _daysInMonth
                    .map((date) => Column(
                  children: [
                    // Text(DateFormat('dd').format(date)),
                    _buildDateBox(date),
                  ],
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MonthPage(userName: 'John Doe'),
    );
  }
}
