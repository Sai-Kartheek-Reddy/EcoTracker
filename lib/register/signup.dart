import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weather/register/signupcontroller.dart';


class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? _email;
  String? _repassword;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/image/register.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 35 , top: 70),
          child: const Text(
            "Create\nAccount",
            style: TextStyle(color: Colors.white , fontSize: 33,decoration: TextDecoration.none),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Set the background color to transparent
          body: Form(
            key: _formkey,
             child: SingleChildScrollView(
               child: Container(
                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.29,right: 35,left: 35),
                   child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         TextFormField(
                           controller: controller.fullname,
                           decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.black),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.white),
                             ),
                             labelText: 'Username',
                             labelStyle: TextStyle(fontWeight: FontWeight.bold),
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(color: Colors.white)
                             ),
                           ),
                         ),
                         SizedBox(height: 30),
                         TextFormField(
                           controller: controller.email,
                           decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.black),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.white),
                             ),
                             labelText: 'Email',
                             labelStyle: TextStyle(fontWeight: FontWeight.bold),
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(color: Colors.white)
                             ),
                           ),
                         ),
                         SizedBox(height: 30),
                         TextFormField(
                           controller: controller.phoneno,
                           decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.black),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.white),
                             ),
                             labelText: 'Phone Number',
                             labelStyle: TextStyle(fontWeight: FontWeight.bold),
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(color: Colors.white)
                             ),
                           ),
                         ),
                         SizedBox(height: 30),
                         TextFormField(
                           controller: controller.password,
                           obscureText: true,
                           decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.black),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10),
                               borderSide: BorderSide(color: Colors.white),
                             ),
                             labelText: 'Password',
                             labelStyle: TextStyle(fontWeight: FontWeight.bold),
                             contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(color: Colors.white)
                             ),
                           ),
                         ),
                         SizedBox(height: 30),
                         SizedBox(
                           width: double.infinity,
                           child: ElevatedButton(
                             onPressed: () {
                               if(_formKey.currentState == null ){
                                 SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                               }
                             },
                             child: Text('SignUp'),
                           ),
                         )
                       ],
                     ),

                 ),
             ),
          ),)
      ],
    );
  }
}