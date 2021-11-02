import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'screens.dart';
import 'package:flash_chat/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/1.jpg"), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/salogo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    //Calls a keyboard for input type email
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ))),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password',
                      hintStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        //Implement registration functionality.
                        // print(email);
                        // print(password);
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
