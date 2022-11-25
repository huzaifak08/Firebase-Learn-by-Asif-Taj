import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/UI/auth/post/post_screen.dart';
import 'package:firebase_flutter/UI/auth/signup_screen.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScrren extends StatefulWidget {
  const LoginScrren({super.key});

  @override
  State<LoginScrren> createState() => _LoginScrrenState();
}

class _LoginScrrenState extends State<LoginScrren> {
  // Key to handle any empty Text Fields:
  final _formKey = GlobalKey<FormState>();

  // Controllers:
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // Firebase Auhentication:
  final _auth = FirebaseAuth.instance;

  // Loading:
  bool loading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Use TextFields inside the Form to handle empty Text Fields:
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        label: Text('Enter Email'),
                        helperText: 'someone@gmail.com',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Email';
                        } else
                          null;
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Enter Password'),
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Password';
                        } else
                          null;
                      },
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              RoundButton(
                title: 'Login',
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Login Method of Firebase:
                    login();
                  }
                },
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ));
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    // Before Sign In complete do Loading:
    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())

        // When sign in then do this:
        .then(
      (value) {
        // Show loged in email at the toast message:
        Utils().toastMessage(value.user!.email.toString());

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostScreen(),
            ));

        // When Sign in Completes then stop Loading:
        setState(() {
          loading = false;
        });
      },
    )
        // In case of Errors do this:
        .onError(
      (error, stackTrace) {
        Utils().toastMessage(error.toString());

        // When error shows also stop the loading:
        setState(() {
          loading = false;
        });
      },
    );
  }
}
