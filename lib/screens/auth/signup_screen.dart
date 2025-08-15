import 'package:bytelogik_task/common/custom_button.dart';
import 'package:bytelogik_task/common/custom_textfield.dart';
import 'package:bytelogik_task/common/suggesion_auth.dart';
import 'package:bytelogik_task/models/user_model.dart';
import 'package:bytelogik_task/screens/auth/signin_screen.dart';
import 'package:bytelogik_task/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void signup() async {
    var result = await authService.signUp(
      UserModel(
        userName: nameCtrl.text,
        email: emailCtrl.text,
        password: passCtrl.text,
      ),
    );

    if (result == "exists") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
            content: Text("User with this email already exists", style: TextStyle(color: Colors.white),)),
      );
    } else if (result == "success") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SigninScreen()),
            (route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wd = MediaQuery.of(context).size.width;
    const tabletBreakpoint = 600.0;
    final isWide = wd > tabletBreakpoint;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 73, 172),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isWide ? wd * 0.3 : 0.0),
        child: Column(
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
                "Sign up.",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: ht * 0.85,
                width: wd,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ht * 0.04,
                        horizontal: wd * 0.02,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/images/sign-up.png",
                              fit: BoxFit.cover,
                              width: wd * 0.7,
                            ),
                          ),
                          CustomTextfield(
                            wd: wd,
                            ht: ht,
                            ctrl: nameCtrl,
                            name: "User Name",
                            obscure: false,
                            icon: Icons.person,
                          ),
                          CustomTextfield(
                            wd: wd,
                            ht: ht,
                            ctrl: emailCtrl,
                            name: "Email",
                            icon: Icons.mail,
                            obscure: false,
                          ),
                          CustomTextfield(
                            wd: wd,
                            ht: ht,
                            ctrl: passCtrl,
                            name: "Password",
                            icon: Icons.password,
                          ),
                          SizedBox(height: ht * 0.04),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:  isWide ? wd * 0.03 : 0),
                            child: customButton(ht * 1.15, wd * 1.5, "Sign Up", () {
                              if (formKey.currentState!.validate()) {
                                print("Sign Up");
                                signup();
                              }
                            }),
                          ),
                          SizedBox(height: ht * 0.02),
                          suggestAuth(
                            () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigninScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            "Already have a account? ",
                            "Sign In",
                          ),
                        ],
                      ),
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
