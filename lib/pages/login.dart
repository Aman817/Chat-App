import 'package:Chat_App/widgets/custombutton.dart';
import 'package:Chat_App/widgets/customtextinput.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChatterLogin extends StatefulWidget {
  @override
  _ChatterLoginState createState() => _ChatterLoginState();
}

class _ChatterLoginState extends State<ChatterLogin> {
  String email;
  String password;
  bool loggingin = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loggingin,
      child: Scaffold(
        backgroundColor: Color(0XFFF2ECEC),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'heroicon',
                    child: Image.asset(
                      "assets/images/login.png",
                      alignment: Alignment.center,
                      height: 200,
                      width: 300,
                    ),
                  ),
                  Hero(
                    tag: 'HeroTitle',
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  CustomTextInput(
                    hintText: 'Email',
                    leading: Icons.mail,
                    obscure: false,
                    keyboard: TextInputType.emailAddress,
                    userTyped: (val) {
                      email = val;
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  CustomTextInput(
                    hintText: 'Password',
                    leading: Icons.lock,
                    obscure: true,
                    userTyped: (val) {
                      password = val;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: 'loginbutton',
                    child: CustomButton(
                      text: 'login',
                      accentColor: Colors.white,
                      mainColor: Colors.deepPurple,
                      onpress: () async {
                        if (password != null && email != null) {
                          setState(() {
                            loggingin = true;
                          });
                          try {
                            final loggedUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (loggedUser != null) {
                              setState(() {
                                loggingin = false;
                              });
                              Navigator.pushNamed(context, '/chat');
                            }
                          } catch (e) {
                            setState(() {
                              loggingin = false;
                            });
                            EdgeAlert.show(context,
                                title: 'Login Failed',
                                description: e.toString(),
                                gravity: EdgeAlert.BOTTOM,
                                icon: Icons.error,
                                backgroundColor: Colors.deepPurple[900]);
                          }
                        } else {
                          EdgeAlert.show(context,
                              title: 'Uh oh!',
                              description:
                                  'Please enter the email and password.',
                              gravity: EdgeAlert.BOTTOM,
                              icon: Icons.error,
                              backgroundColor: Colors.deepPurple[900]);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: Text(
                        'or create an account',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.deepPurple),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
