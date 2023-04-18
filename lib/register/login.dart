import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather/home/weather.dart';
import 'package:weather/register/signup.dart';
import 'package:weather/register/signupcontroller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _username!,
          password: _password!,
        );
        // User is logged in, navigate to WeatherPage
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: WeatherPage(),
            duration: Duration(milliseconds: 500),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('No user found with the provided email.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('The password is incorrect.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/image/login.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*0.05,
            top: MediaQuery.of(context).size.width*0.45,
          ),
          child: const Text(
            "Welcome\nBack",
            style: TextStyle(
              fontFamily: 'OoohBaby',
              color: Colors.white,
              fontSize: 33,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Set the background color to transparent
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45,right: 35,left: 35),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your username' : null,
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter your password' : null,
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff4c505b),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () async {
                                if(_formKey.currentState!.validate() ){
                                  _formKey.currentState!.save();
                                  try {
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: _username!,
                                      password: _password!,
                                    );
                                    // User is logged in, navigate to WeatherPage
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: WeatherPage(),
                                        duration: Duration(milliseconds: 500),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Login Failed'),
                                            content: Text('No user found with the provided email.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else if (e.code == 'wrong-password') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Login Failed'),
                                            content: Text('The password is incorrect.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyRegister()));}, child: Text('Sign Up',style: TextStyle(decoration: TextDecoration.underline , fontSize: 18,color: Color(0xff4c505b)),)),
                        TextButton(onPressed: (){}, child: Text('Forgot Password',style: TextStyle(decoration: TextDecoration.underline , fontSize: 18,color: Color(0xff4c505b)),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),)
      ],
    );
  }
}
