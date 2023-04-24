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
  Map<DateTime, double> _values = {};

  @override
  void initState() {
    super.initState();
    _daysInMonth = _getDaysInMonth(DateTime.now());

    // Set fixed values for specific dates
    _values[DateTime(2023, 4, 1)] = 3.65;
    _values[DateTime(2023, 4, 2)] = 53;
    _values[DateTime(2023, 4, 3)] = 2;
    _values[DateTime(2023, 4, 4)] = 55;
    _values[DateTime(2023, 4, 5)] = 22;
    _values[DateTime(2023, 4, 6)] = 2;
    _values[DateTime(2023, 4, 7)] = 55;
    _values[DateTime(2023, 4, 8)] = 22;
    _values[DateTime(2023, 4, 9)] = 2;
    _values[DateTime(2023, 4, 10)] = 55;
    _values[DateTime(2023, 4, 11)] = 22;
    _values[DateTime(2023, 4, 12)] = 2;
    _values[DateTime(2023, 4, 13)] = 55;
    _values[DateTime(2023, 4, 14)] = 22;
    _values[DateTime(2023, 4, 15)] = 2;
    _values[DateTime(2023, 4, 16)] = 55;
    _values[DateTime(2023, 4, 17)] = 22;
    _values[DateTime(2023, 4, 18)] = 2;
    _values[DateTime(2023, 4, 19)] = 55;
    _values[DateTime(2023, 4, 20)] = 22;
    _values[DateTime(2023, 4, 21)] = 2;
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    var firstDayOfMonth = DateTime(month.year, month.month, 1);
    var lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    return List.generate(lastDayOfMonth.day - firstDayOfMonth.day + 1,
        (i) => DateTime(month.year, month.month, i + 1));
  }

  Widget _buildDateBox(DateTime date) {
    final now = DateTime.now();
    final isToday = date.isAtSameMomentAs(now);
    final isBeforeToday = date.isBefore(now);

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
                        enabled: (isToday || isBeforeToday) &&
                            !isEditing, // Enable if it's today or before today and not already editing
                        initialValue: _values[date]?.toStringAsFixed(2),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                            replacementString: '',
                          ),
                        ],
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          if (value == null || value.isEmpty) {
                            _values[date] = 0;
                          } else {
                            final newValue = num.tryParse(value);
                            if (newValue != null &&
                                newValue.toStringAsFixed(2) == value) {
                              setState(() {
                                _values[date] = newValue.toDouble();
                              });
                            }
                          }
                        },
                        onEditingComplete: () {
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/image/bck.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        'Hello, ${widget.userName}!',
                        style: TextStyle(fontSize: 24),
                      ),
                      Spacer(),
                      Text(
                        DateFormat('MMMM').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
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
