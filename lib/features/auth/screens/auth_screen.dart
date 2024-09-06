import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_text_widget.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum Auth {
  signin,
  signup,
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final GlobalKey _signupformKey = GlobalKey<FormState>();
  final GlobalKey _signinformKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void signUpUser() {
    _authService.signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      context: context,
    );
  }

  void signInUser() {
    _authService.signInUser(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(
                      () {
                        _auth =
                            val!; //this means that it will never pass on a null value
                      },
                    );
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signupformKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomTextField(
                            controller: _nameController,
                            hintText: 'Name',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomButton(
                            text: 'Create Account',
                            onTap: () {
                              if ((_signupformKey.currentState! as FormState)
                                  .validate()) signUpUser();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: const Text(
                  'Sign-In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(
                      () {
                        _auth =
                            val!; //this means that it will never pass on a null value
                      },
                    );
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signinformKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomButton(
                            text: 'Sign-In',
                            onTap: () {
                              signInUser();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
