// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/Screens/homePage.dart';
import 'package:flutter_app2/Screens/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            )
          );
        }

        if(snapshot.connectionState == ConnectionState.done){
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder : (context, snapshot){
              if(snapshot.connectionState == ConnectionState.active){
                Object? user = snapshot.data;

                if(user == null){
                  return LoginPage();
                }else{
                  return HomePage();
                }
              }

              return Scaffold(
                body: Center(
                  child: Text("Checking authentication ...."),
                )
              );
            },
          );
        }

        return Scaffold(
            body: Center(
              child: Text("Connecting to app"),
            ),
        );
      },
    );
  }
}
