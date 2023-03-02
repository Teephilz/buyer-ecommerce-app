import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taiwo_ecommerce_app/screens/forgot_password.dart';
import 'package:taiwo_ecommerce_app/screens/sign_up_page.dart';
import 'package:taiwo_ecommerce_app/widgets/reusable_field_widget.dart';

import 'home_screen.dart';
class LogInScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>_scaffoldkey= GlobalKey<ScaffoldState>();

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}


class _LogInScreenState extends State<LogInScreen> {

  final GlobalKey<ScaffoldState>_scaffoldkey= GlobalKey<ScaffoldState>();
  TextEditingController _passwordTextController= TextEditingController();
  TextEditingController _emailTextController= TextEditingController();

  bool isHiddenPassword= true;




 Future<void> SignIn ()async {
    if (_emailTextController.text.isEmpty &&
        _passwordTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter both email address and password");
    } else if (_emailTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter your email address");

    } else if (_passwordTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter password");
    }

    else{
      try{
        showDialog(context: context,
            builder:(context){
              return Center(child: CircularProgressIndicator());
            });
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailTextController.text.trim(),
            password: _passwordTextController.text.trim());
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        } on FirebaseAuthException catch(e){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: e.message.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height,
       decoration: BoxDecoration(
         gradient: LinearGradient(
           colors: [
             Colors.deepOrangeAccent,
             Colors.orangeAccent
           ],
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter
         )
       ),

       child:
        SingleChildScrollView(
          child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.1, 20, 0),
          child: Column(
            children:<Widget>[
              Text("Welcome ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
              Image.asset("images/woman.jpg",
              fit: BoxFit.fitWidth,
              width: 240,
              height: 240,
             ),
              
              SizedBox(
                height: 30,
              ),

              reUsableTextFormField(
                controller: _emailTextController,
                text: "Enter Email",
                icon: Icons.email,
                isObscure: false,
                isPassword: false,
              ),
            SizedBox(
              height: 20,
            ),

              reUsableTextFormField(
                controller: _passwordTextController,
                text: "Enter Password",
                icon: Icons.lock,
                isObscure: true,
                isPassword: true,
              ),

              SizedBox(
                height: 10,
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                      },
                        child: Text("Forgot Password?",
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              
              signInsignUpButton(context, true, (){
             SignIn();
              }),

              signUpOption()
            
            ]

          ),),
        ),

        ),
      );
  }

  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
        style: TextStyle(color: Colors.white70),),
        GestureDetector(
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),

          ),
        )
      ],
    );
  }
}
