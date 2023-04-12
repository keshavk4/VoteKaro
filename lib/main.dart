import 'package:flutter/material.dart';
import 'package:votekaro/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensure that Flutter has initialized all bindings before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase app
  await Firebase.initializeApp();
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoteKaro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
