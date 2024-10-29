// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tech_shop_app2/JsonModels/users.dart';
import 'package:tech_shop_app2/screens/signup_screen.dart';
import 'package:tech_shop_app2/SQLite/sqlite.dart';
import 'package:tech_shop_app2/screens/product_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool isVisible = false;
  bool isLoginTrue = false;
  final db = DatabaseHelper();

  final formKey = GlobalKey<FormState>();

  login() async {
    bool response = await db.login(
      Users(usrEmail: email.text, usrPassword: password.text),
    );

    if (response) {
      // If login is successful, navigate to ProductScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductScreen()),
      );
    } else {
      // If login fails, show error message
      setState(() {
        isLoginTrue = true; // Show error message on login page
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text('iTech Shop', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: const Color(0xFF1D1E1E),
        ),
        backgroundColor: const Color(0xFF606868),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Form(
                    key: formKey,
                    child: Column(children: [
                      TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field cannot be empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Email',
                              hintText: 'Enter Email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder()),
                          controller: email),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field cannot be empty";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            prefixIcon: const Icon(Icons.password_rounded),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: const OutlineInputBorder()),
                        controller: password,
                      ),
                    ]))),
            const SizedBox(height: 30),
            Builder(builder: (context) {
              return MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductScreen()));
                  //if (formKey.currentState!.validate()) {
                  //login();
                  //}
                },
                color: Colors.white,
                textColor: Colors.black,
                child: const Text('Login'),
              );
            }),
            const SizedBox(height: 30.0),
            const Text('No account? Sign Up below.'),
            const SizedBox(height: 20.0),
            Builder(builder: (context) {
              return MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                color: const Color(0xFFCBD7D1),
                textColor: Colors.black,
                child: const Text('Sign Up'),
              );
            }),
            isLoginTrue
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Username or password is incorrect",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : const SizedBox(),
          ],
        ));
  }
}
