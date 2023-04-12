import 'package:flutter/material.dart';
import 'package:votekaro/pages/voting_page.dart';
import 'package:votekaro/pages/sign_in_page.dart';
import 'package:votekaro/services/firebase_authentication_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isUserSignedIn = false;

  @override
  void initState() {
    super.initState();

    // Check the authentication status of the user on app startup
    setState(() {
      _isUserSignedIn =
          FirebaseAuthenticationService().checkAuthenticationStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show the voting page if the user is signed in, otherwise show the sign-in page
    return _isUserSignedIn ? const VotingPage() : SignInPage();
  }
}
