import 'package:flutter/material.dart';



class FuelConsumptionPage extends StatefulWidget {
  const FuelConsumptionPage({Key? key}) : super(key: key);

  @override
  _FuelConsumptionPageState createState() => _FuelConsumptionPageState();
}

class _FuelConsumptionPageState extends State<FuelConsumptionPage> {
  final distanceController = TextEditingController();
  String? _fuelType;
  final fuelConsumptionController = TextEditingController();
  String? _carModel;

  double? _distance;
  double? _fuelConsumption;

  void calculateFuelConsumption() {
    setState(() {
      _distance = double.tryParse(distanceController.text);
      _fuelConsumption = double.tryParse(fuelConsumptionController.text);
    });

    if (_distance != null && _fuelConsumption != null) {
      final fuelAmount = (_distance! * (_fuelConsumption!)) / 1000;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Fuel Consumption',
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'CO',
                  style: TextStyle(fontSize: 18),
                ),
                TextSpan(
                  text: '2',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 0.7, // Adjust this value to fine-tune the subscript position
                  ),
                ),
                TextSpan(
                  text: '  Amount is ${fuelAmount.toStringAsFixed(2)} KG',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),

          // content: Text(
          //   'CO Amount is ${fuelAmount.toStringAsFixed(2)} KG',
          //   style: TextStyle(
          //     color: Colors.grey[800],
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18,
          //   ),
          // ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }


  Widget buildFuelTypeDropDown() {
    return Container(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1.0, color: Colors.grey.shade400),
          )
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: '  Fuel Type',
        ),
        value: _fuelType,
        onChanged: (value) {
          setState(() {
            _fuelType = value;
            if (_fuelType == 'Diesel' && _carModel == 'Three-Wheeler') {
              fuelConsumptionController.text = '132.2';
            } else if (_fuelType == 'Diesel' && _carModel == 'Four-Wheeler') {
              fuelConsumptionController.text = '173.58';
            } else if (_fuelType == 'Petrol' && _carModel == 'Two-Wheeler') {
              fuelConsumptionController.text = '39.04';
            } else if (_fuelType == 'Petrol' && _carModel == 'Three-Wheeler') {
              fuelConsumptionController.text = '113.5';
            } else if (_fuelType == 'Petrol' && _carModel == 'Four-Wheeler') {
              fuelConsumptionController.text = '179.94';
            } else {
              fuelConsumptionController.text = '';
            }
          });
        },
        items: _carModel == 'Two-Wheeler'
            ? [
          DropdownMenuItem(
              value: 'Petrol',
              child: Row(
                children: [
                  Icon(Icons.local_gas_station_sharp),
                  const SizedBox(width: 8),
                  Text('Petrol')
                ],
              ))
        ]
            : [
          DropdownMenuItem(
              value: 'Diesel',
              child: Row(
                children: [
                  Icon(Icons.local_gas_station),
                  const SizedBox(width: 8),
                  Text('Diesel')
                ],
              )),
          DropdownMenuItem(
              value: 'Petrol',
              child: Row(
                children: [
                  Icon(Icons.local_gas_station_sharp),
                  const SizedBox(width: 8),
                  Text('Petrol')
                ],
              )),
        ],

      ),
    );
  }

  Widget buildCarModelDropDown() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(width: 1.0, color: Colors.grey.shade400),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: '  Vehicle segment',
        ),
        value: _carModel,
        onChanged: (value) {
          setState(() {
            _carModel = value;
            if (_fuelType == 'Diesel' && _carModel == 'Three-Wheeler') {
              fuelConsumptionController.text = '132.2';
            } else if (_fuelType == 'Diesel' && _carModel == 'Four-Wheeler') {
              fuelConsumptionController.text = '173.58';
            } else if (_fuelType == 'Petrol' && _carModel == 'Two-Wheeler') {
              fuelConsumptionController.text = '39.04';
            } else if (_fuelType == 'Petrol' && _carModel == 'Three-Wheeler') {
              fuelConsumptionController.text = '113.5';
            } else if (_fuelType == 'Petrol' && _carModel == 'Four-Wheeler') {
              fuelConsumptionController.text = '179.94';
            } else {
              fuelConsumptionController.text = '';
            }
          });
        },
        items: [
          DropdownMenuItem(
            value: 'Two-Wheeler',
            child: Row(
              children: [
                Icon(Icons.directions_bike_sharp),
                const SizedBox(width: 8),
                Text('Two-Wheeler'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Three-Wheeler',
            child: Row(
              children: [
                Icon(Icons.directions_bus),
                const SizedBox(width: 8),
                Text('Three-Wheeler'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'Four-Wheeler',
            child: Row(
              children: [
                Icon(Icons.directions_car_filled_outlined),
                const SizedBox(width: 8),
                Text('Four-Wheeler'),
              ],
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.height * 0.01,
              right: MediaQuery.of(context).size.height * 0.02,
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.transparent, Colors.white10])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 16),
                buildCarModelDropDown(),
                const SizedBox(height: 16),

                const SizedBox(height: 16),
                buildFuelTypeDropDown(),
                const SizedBox(height: 16),

                SizedBox(height: MediaQuery.of(context).size.height*0.03),
                Column(
                  children: [
                    TextFormField(
                      controller: distanceController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: ' Distance (km)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 10.0,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,), // Set the height of the gap to 10.0
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: '    CO2 emission factor (g/km)',
                        ),
                        controller: fuelConsumptionController,
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                ElevatedButton(
                  onPressed: calculateFuelConsumption,
                  child: Icon(
                    Icons.send_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.indigo,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.all(15),
                    elevation: 4,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}