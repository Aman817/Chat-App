import 'package:Chat_App/pages/chatterScreen.dart';
import 'package:Chat_App/pages/googlemap.dart';
import 'package:Chat_App/pages/login.dart';
import 'package:Chat_App/pages/signup.dart';
import 'package:Chat_App/pages/splash.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatter',
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ChatterHome(),
        '/login': (context) => ChatterLogin(),
        '/signup': (context) => ChatterSignUp(),
        '/chat': (context) => ChatterScreen(),
        '/googlemap': (context) => GooglePage(),
      },
    );
  }
}
