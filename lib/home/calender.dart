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
  late Map<DateTime, double> _hardcodedValues; // add this map

  @override
  void initState() {
    super.initState();

    _daysInMonth = _getDaysInMonth(DateTime.now());

    // initialize the hardcoded values map with some example values
    _hardcodedValues = {
      _daysInMonth[0]: 10.0,
      _daysInMonth[5]: 20.0,
      _daysInMonth[10]: 30.0,
    };
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

    final editing = ValueNotifier<bool>(_hardcodedValues[date] != null);

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
                        initialValue: _hardcodedValues[date]?.toStringAsFixed(
                            2), // use the hardcoded value if available
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
                            _hardcodedValues[date] = 0;
                          } else {
                            final newValue = num.tryParse(value);
                            if (newValue != null &&
                                newValue.toStringAsFixed(2) == value) {
                              setState(() {
                                _hardcodedValues[date] =
                                    newValue.toInt() as double;
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
              image: AssetImage("Assets/image/back1.jpg"),
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
