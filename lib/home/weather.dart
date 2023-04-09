import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'date.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
{
  var _highTemp;
  var _lowTemp;
  var _temp;
  var _temp1;

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  void _getWeatherData() async {
    var response =
    await http.get(Uri.https('api.weatherbit.io', '/v2.0/forecast/daily', {
      'lat': '15.4589',
      'lon': '75.0078',
      'key': 'ff81b333db694538b210e492254e7e61',
    }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _highTemp = data['data'][0]['high_temp'];
        _lowTemp = data['data'][0]['low_temp'];
        _temp = data['data'][0]['temp'];
        _temp1 = data['data'][1]['temp'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            if (_temp != null && _temp>28 )
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/image/sunny.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (_temp != null && _temp >= 26 && _temp < 28)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/image/sunny.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (_temp != null && _temp < 10)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/rainy.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 80, bottom: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Dharwad",
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '$_temp°C',
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.wb_cloudy_outlined),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'H:$_highTemp°C',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'L:$_lowTemp°C',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            DatePage(),
            Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.04, // Set the position from the left edge
                  top: MediaQuery.of(context).size.height * 0.51,// Set the position from the top edge
                  child: MediaQuery.of(context).size.width < 600
                      ? Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  )
                      : Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.52, // Set the position from the left edge
                  top: MediaQuery.of(context).size.height * 0.51, // Set the position from the top edge
                  child: MediaQuery.of(context).size.width < 600
                      ? Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  )
                      : Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.04, // Set the position from the left edge
                  top: MediaQuery.of(context).size.height * 0.73, // Set the position from the top edge
                  child: MediaQuery.of(context).size.width < 600
                      ? Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  )
                      : Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.52, // Set the position from the left edge
                  top: MediaQuery.of(context).size.height * 0.73, // Set the position from the top edge
                  child: MediaQuery.of(context).size.width < 600
                      ? Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  )
                      : Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
