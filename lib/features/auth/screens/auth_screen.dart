import 'package:ec/common/widgets/custom_button.dart';
import 'package:ec/common/widgets/custom_textfield.dart';
import 'package:ec/constants/global_variables.dart';
import 'package:ec/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        context: context);
  }

  void signInUser() {
    authService.signInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome').text.xl3.bold.make(),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: Text('註冊新用戶').text.xl.bold.make(),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: EdgeInsets.all(24.0),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: '姓名',
                          controller: _nameController,
                        ),
                        SizedBox().p12(),
                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                        ),
                        SizedBox().p12(),
                        CustomTextField(
                          hintText: '密碼',
                          controller: _passwordController,
                        ),
                        SizedBox().p12(),
                        CustomButton(
                          btnText: '註冊',
                          onTab: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundColor,
                title: Text('登入').text.xl.bold.make(),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: EdgeInsets.all(24.0),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                        ),
                        SizedBox().p12(),
                        CustomTextField(
                          hintText: '密碼',
                          controller: _passwordController,
                        ),
                        SizedBox().p12(),
                        CustomButton(
                          btnText: '登入',
                          onTab: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
