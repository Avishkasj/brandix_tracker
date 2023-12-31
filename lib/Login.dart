import 'dart:convert';
import 'dart:core';

import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SlectLine.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Set the loading state
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Send a POST request to the PHP script
      final response = await http.post(
        // Uri.parse('http://192.168.8.126/brandixapi/login.php'),
        Uri.parse('http://api.futuretechbay.com/brandixapi/login.php'),
        body: {
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );

      // Decode the response JSON
      final data = json.decode(response.body);

      // Check if the login was successful
      if (data['success']) {
        // Navigate to the home page
        var uname = data['username'];

        print(uname);
        print("done");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SelectLine()),
        );
      } else {
        // Set the error message
        setState(() {
          _errorMessage = data['message'];
        });

        print("not done");
      }
    } catch (e) {
      // Set the error message
      setState(() {
        _errorMessage = 'please connect device to internet $e';
      });
    } finally {
      // Set the loading state
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image(image: AssetImage('assets/logob.png')),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Welcome To",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "brandix",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      // errorText: 'Error Text',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      // errorText: 'Error Text',
                      border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member? .'),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => register()),
                    // );
                  },
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(110, 20, 110, 0),
              child: ElevatedButton(
                child: _isLoading ? CircularProgressIndicator() : Text('Login'),
                onPressed: _isLoading ? null : _login,
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
