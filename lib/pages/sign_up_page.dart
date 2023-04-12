import 'package:flutter/material.dart';
import 'package:votekaro/pages/loading_page.dart';

// Creating a SignUpPage widget which is a Stateless Widget
class SignUpPage extends StatelessWidget {

  // Constructor to initialize the key
  SignUpPage({Key? key}) : super(key: key);

  // Creating global keys for the form and text fields
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  // Submit form function to validate the form data and redirect to LoadingPage widget
  void _submitForm(BuildContext context) async {
    final result = _formKey.currentState!.validate()
        ? await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoadingPage(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      isSignIn: false,
                    )))
        : null;
    // If result is not null, show a Snackbar with the result
    result != null
        ? ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$result')))
        : null;
  }

  // Build function to create the widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Creating the app bar
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),

      // Creating the body of the widget
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Creating a form with text fields for user input
              Form(
                key: _formKey,
                child: Column(children: [
                  // Name text field
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      return value!.isEmpty ? 'Name is required' : null;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: "Name",
                        hintText: "Enter your name",
                        icon: Icon(Icons.person),
                        labelStyle: TextStyle(color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  // Email text field
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
                          labelText: "Email",
                          hintText: "Enter your email",
                          icon: Icon(Icons.email),
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.blue),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )))),
                  // Password text field
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      return value!.isEmpty || value.length < 6
                          ? 'Password length must be greater than 6 digits'
                          : null;
                    },
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        icon: Icon(Icons.lock),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        ))),
                  ),
                  TextFormField(
                    controller: _passwordConfirmController,
                    validator: (value) {
                      return value!.isEmpty || value != _passwordController.text
                          ? 'Password does not match'
                          : null;
                    },
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Enter your password",
                        icon: Icon(Icons.lock),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.blue),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        ))),
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {_submitForm(context)},
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: const Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
