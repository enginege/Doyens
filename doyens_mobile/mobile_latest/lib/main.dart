import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';

bool loginStatus = false;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCwLAdx1n1GvqLzy1myEL7IQ-TFKfyXuow",
        authDomain: "doyens-f8945.firebaseapp.com",
        projectId: "doyens-f8945",
        storageBucket: "doyens-f8945.appspot.com",
        messagingSenderId: "1035596811759",
        appId: "1:1035596811759:web:9828f6dd092dfd34a17a1a",
        measurementId: "G-ZEQXWGK1EE"),
  );
  runApp(FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("Firebase connecting success!");
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme(),
              routes: routes,
              home: SplashScreen());
        } else {
          return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Center(
                child: Text('Connecting to firebase...'),
              ));
        }
      }));
}
