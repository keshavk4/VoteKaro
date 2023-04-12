import 'package:flutter/material.dart';
import 'package:votekaro/pages/loading_page.dart';
import 'package:votekaro/pages/sign_up_page.dart';

// Create a stateless widget for the Sign In page
class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  // Declare form key and text editing controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to submit form data and navigate to LoadingPage
  void _submitForm(BuildContext context) async {
    final result = _formKey.currentState!.validate()
        ? await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoadingPage(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      isSignIn: true,
                    )))
        : null;

    // Show SnackBar message if there's a result
    result != null
        ? ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$result')))
        : null;
  }

  // Build method for the widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with the title and options
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      // Body container with a black background
      body: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // Sign In Textfield and form elements
              children: [
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        return value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)
                            ? 'Invalid Email'
                            : null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        suffixIcon: Icon(Icons.email),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Password input with validation and hidden text
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: Icon(Icons.lock),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Sign In button with gesture detector and styling
                GestureDetector(
                  onTap: () => {
                    _submitForm(context),
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()))
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
