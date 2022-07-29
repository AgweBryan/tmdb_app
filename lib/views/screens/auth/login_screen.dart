import 'package:flutter/material.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/views/screens/auth/signup_screen.dart';
import 'package:tmdb_app/views/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TMDB',
                style: TextStyle(
                    fontSize: 35,
                    color: buttonColor,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  icon: Icons.email,
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _passwordController,
                  isObscure: obscureText,
                  icon: Icons.lock,
                  labelText: 'Password',
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                leading: obscureText
                    ? Icon(
                        Icons.check_box_outline_blank,
                        color: buttonColor,
                      )
                    : Icon(
                        Icons.check_box,
                        color: buttonColor,
                      ),
                title: Text('Show password?'),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => authController.loginUser(
                    _emailController.text, _passwordController.text),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen())),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: buttonColor,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
