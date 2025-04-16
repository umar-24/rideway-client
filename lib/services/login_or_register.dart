import 'package:flutter/material.dart';
import 'package:rideway/features/auth/screen/login_screen.dart';
import 'package:rideway/features/auth/screen/register_screen.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void tooglePges(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(
        onPressed: tooglePges,
      );
    }else{
      return RegisterScreen(
        onPressed: tooglePges,
      );
    }
  }
}