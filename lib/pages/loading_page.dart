import 'package:flutter/material.dart';
import 'package:votekaro/pages/voting_page.dart';
import 'package:votekaro/services/firebase_authentication_service.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage(
      {Key? key,
      required this.email,
      required this.password,
      required this.isSignIn})
      : super(key: key);

  // Initializing email, password, and isSignIn variables
  final String email;
  final String password;
  final bool isSignIn;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

// _LoadingPageState widget which extends State
class _LoadingPageState extends State<LoadingPage> {

  // Overriding initState() method to set up the widget
  @override
  void initState() {
    super.initState();

    // If user is signing in
    if (widget.isSignIn) {
      // Sign in user with given email and password
      FirebaseAuthenticationService()
          .signInWithEmailAndPassword(widget.email, widget.password)
          .then((value) => {
                // If sign in is successful, navigate to the VotingPage widget
                if (value)
                  {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const VotingPage()))),
                  }
                // If sign in is unsuccessful, pop with an error message
                else
                  { Navigator.pop(context, "Invalid credentials"), }
              });
    } else {
      FirebaseAuthenticationService()
          .signUpWithEmailAndPassword(widget.email, widget.password)
          .then((value) => {
                if (value)
                  {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const VotingPage()))),
                  }
                else
                  { Navigator.pop(context, "Failed to sign up") }
              });
    }
  }

  // Overriding build() method to build the widget tree
  @override
  Widget build(BuildContext context) {
    // Returning a loading screen with a circular progress indicator
    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
