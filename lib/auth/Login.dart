import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashscreen/splashscreen.dart';
import '../Home.dart';
import '../model/ScopeManage.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  static final AppModel appModel = AppModel();
  static final String route = 'Login-route';

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((res) {
      print(res);
      if (res != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(appModel: Login.appModel, uid: res.uid),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              //builder: (context) => Signup(),
              ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      backgroundColor: Colors.white,
      image: Image.asset('../assets/logo.png'),
      photoSize: 300,
    );
  }
}
