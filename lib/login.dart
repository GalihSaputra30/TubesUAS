import 'package:flutter/material.dart';
import 'func_/func_login.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController ctl_user = TextEditingController();
  TextEditingController ctl_pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 600,
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: ctl_user,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: ctl_pwd,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
              
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                       login(context, ctl_user.text, ctl_pwd.text);
                      },
                      child: Text("Login"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
