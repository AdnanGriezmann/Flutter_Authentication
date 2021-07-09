import 'package:fires/pages/service/Auth_services.dart';
import 'package:fires/pages/signup.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () async {
              await authClass.logout();
               Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => Signup()),
                (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
