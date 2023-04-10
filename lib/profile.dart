import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          CircleAvatar(
            radius: 64.0,
            backgroundImage: AssetImage('Assets/image/profile.jpg'),
          ),
          SizedBox(height: 16.0),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Software Engineer',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16.0),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('john.doe@example.com'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+1 (123) 456-7890'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('New York, NY'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
