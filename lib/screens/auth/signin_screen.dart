import 'package:bytelogik_task/common/custom_button.dart';
import 'package:bytelogik_task/common/custom_textfield.dart';
import 'package:bytelogik_task/common/suggesion_auth.dart';
import 'package:bytelogik_task/models/user_model.dart';
import 'package:bytelogik_task/screens/auth/signup_screen.dart';
import 'package:bytelogik_task/screens/counter_screen.dart';
import 'package:bytelogik_task/services/auth_service.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final mailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoggedIn = false;
  final AuthService authService = AuthService();

  @override
  void dispose() {
    mailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  login() async {
    var res = await authService.signIn(
      UserModel(email: mailCtrl.text, password: passCtrl.text),
    );
    if (res == true) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => CounterScreen()),
        (route) => false,
      );
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 63, 141),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: wd * 0.02,
              right: wd * 0.02,
              top: ht * 0.07,
            ),
            child: Text(
              "BYTELOGIK",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: wd * 0.02,
              right: wd * 0.02,
              top: ht * 0.02,
            ),
            child: Text(
              "Sign in.",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),

          Expanded(
            child: Container(
              height: ht * 0.8,
              width: wd,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ht * 0.06,
                      left: wd * 0.02,
                      right: wd * 0.02,
                      bottom: ht * 0.02,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/images/sign-in.png",
                            fit: BoxFit.cover,
                            width: wd * 0.7,
                          ),
                        ),
                        CustomTextfield(
                          wd: wd,
                          ht: ht,
                          ctrl: mailCtrl,
                          obscure: false,
                          name: "Email",
                          icon: Icons.email,
                        ),
                        CustomTextfield(
                          wd: wd,
                          ht: ht,
                          ctrl: passCtrl,
                          name: "Password",
                          icon: Icons.password,
                        ),
                        SizedBox(height: ht * 0.04),
                        customButton(ht * 1.15, wd * 1.5, "Sign In", () {
                          if (formKey.currentState!.validate()) {
                            login();
                            print("Sign In");
                          }
                        }),
                        SizedBox(height: ht * 0.03),
                        suggestAuth(
                          () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          "Don't have a account? ",
                          "Sign Up",
                        ),
                        SizedBox(height: ht * 0.02),
                        isLoggedIn
                            ? Text(
                                "Username or Password is Incorrect!",
                                style: TextStyle(color: Colors.redAccent),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
