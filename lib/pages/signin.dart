import 'package:fires/pages/Homepage.dart';
import 'package:fires/pages/service/Auth_services.dart';
import 'package:fires/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double text = MediaQuery.textScaleFactorOf(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: text * 36.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.03),
              buttonItem(
                  height, width, text, 'Assets/g.svg', 'Continue With Google',
                  () async {
                authClass.googleSignIn(context);
              }),
              SizedBox(height: height * 0.02),
              buttonItem(height, width, text, 'Assets/p.svg',
                  'Continue With Phone', () {}),
              SizedBox(height: height * 0.05),
              Text(
                'Or',
                style: TextStyle(color: Colors.grey, fontSize: text * 18.0),
              ),
              SizedBox(height: height * 0.05),
              textItem(
                  height, width, text, "Email...", false, _emailcontroller),
              SizedBox(height: height * 0.03),
              textItem(
                  height, width, text, "Password...", true, _passcontroller),
              SizedBox(height: height * 0.04),
              colorbutton(height, width, text),
              SizedBox(height: height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'If you don,t already have an account?',
                    style:
                        TextStyle(color: Colors.green, fontSize: text * 16.0),
                  ),
                  SizedBox(width: width * 0.02),
                  InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => Signup()),
                            (route) => false);
                      },
                      child: Text('SignUp',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: text * 20,
                              fontWeight: FontWeight.bold)))
                ],
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: text * 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// button.....
  Widget colorbutton(double height, double width, double text) {
    return InkWell(
      onTap: () async {
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailcontroller.text, password: _passcontroller.text);
          print(userCredential.user);
          setState(() {
            circular = false;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => HomePage()),
                (route) => false);
          });
        } catch (e) {
          final snackbar = SnackBar(
              content: Text(e.toString()), backgroundColor: Colors.green);
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: width * 0.9,
        height: height * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.blue),
        child: Center(
          child: circular
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: text * 25.0),
                ),
        ),
      ),
    );
  }

  //google and phone button.....
  Widget buttonItem(double height, double width, double text, String imagepath,
      String buttonName, tabs) {
    return InkWell(
      onTap: tabs,
      child: Container(
        width: width * 0.9,
        height: height * 0.1,
        child: Card(
          elevation: 8.0,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(width: 2, color: Colors.green),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(imagepath,
                  height: height * 0.06, width: width * 0.03),
              SizedBox(width: width * 0.05),
              Text(
                buttonName,
                style: TextStyle(color: Colors.grey, fontSize: text * 17.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //textformfield....
  Widget textItem(double height, double width, double text, String label,
      bool obss, TextEditingController controller) {
    return Container(
      color: Colors.black,
      width: width * 0.9,
      height: height * 0.08,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: text * 17.0),
        obscureText: obss,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: text * 22.0,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(width: 2, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
