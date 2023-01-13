import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taiwo_ecommerce_app/widgets/reusable_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'login_screen.dart';
class SignUpScreen extends StatefulWidget {


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();


}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState>_scaffoldkey= GlobalKey<ScaffoldState>();

  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmpasswordTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _genderTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();


  bool isHiddenPassword= true;



  bool passwordConfirmed(){
    if(_passwordTextController.text.trim()
        == _confirmpasswordTextController.text.trim()){
      return true;
    } else{
      return false;
    }
  }



Future <void> SignUp ()async {
  if (
      _usernameTextController.text.isEmpty &&
      _emailTextController.text.isEmpty &&
      _passwordTextController.text.isEmpty &&
          _confirmpasswordTextController.text.isEmpty &&
      _genderTextController.text.isEmpty &&
       _phoneTextController.text.isEmpty &&
      _addressTextController.text.isEmpty) {
    Fluttertoast.showToast(msg: "Fill in all details correctly");
  } else if (_emailTextController.text.isEmpty) {
    Fluttertoast.showToast(msg: "Enter your email address");

  } else if (_passwordTextController.text.isEmpty) {
    Fluttertoast.showToast(msg: "password is empty");
  }
  else if (_passwordTextController.text.length< 6) {
    Fluttertoast.showToast(msg: "password is too short");
  }
  if(_passwordTextController.text.trim()
      != _confirmpasswordTextController.text.trim()){
    Fluttertoast.showToast(msg: "password does not match");
  }
  else{
    try{
      showDialog(context: context,
          builder:(context){
            return Center(child: CircularProgressIndicator());
          });
        UserCredential result= await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailTextController.text.trim(),
            password: _passwordTextController.text.trim());
        Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen()));

        FirebaseFirestore.instance.collection("User").doc(result.user?.uid).set({
          "UserID" : result.user?.uid,
          "Username": _usernameTextController.text.trim(),
          "UserEmail": _emailTextController.text.trim(),
          "UserPhoneNumber": _phoneTextController.text.trim(),
          "UserGender": _genderTextController.text.trim(),
          "UserImage": "",
          "UserAddress": _addressTextController.text.trim()
        }
        );

    } on FirebaseAuthException catch(e){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Sign Up",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),

      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
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

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery
                .of(context)
                .size
                .height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                reUsableTextFormField(
                  controller: _usernameTextController,
                  text: "Enter Username",
                  icon: Icons.person_outline_rounded,
                  isObscure: false,
                  isPassword: false,
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),

               reUsableTextFormField(
                 controller: _confirmpasswordTextController,
                 text: "Confirm Password",
                 icon: Icons.lock,
                 isObscure: true,
                 isPassword: true,
               ),
                SizedBox(
                  height: 20,
                ),
                reUsableTextFormField(
                  controller: _genderTextController,
                  text: "Enter Gender",
                  icon: Icons.person,
                  isObscure: false,
                  isPassword: false,
                ),
                SizedBox(
                  height: 20,
                ),

                reUsableTextFormField(
                  controller: _phoneTextController,
                  text: "Enter Phone number",
                  icon: Icons.phone,
                  isObscure: false,
                  isPassword: false,
                ),
                SizedBox(
                  height: 20,
                ),

                reUsableTextFormField(
                  controller: _addressTextController,
                  text: "Enter address",
                  icon: Icons.perm_contact_cal_rounded,
                  isObscure: false,
                  isPassword: false,
                ),
                SizedBox(
                  height: 20,
                ),

                signInsignUpButton(context, false, () {
                  SignUp();

                }),
                signInOption()


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
          style: TextStyle(color: Colors.white70),),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LogInScreen()));
          },
          child: const Text(
            "Log In",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

          ),
        )
      ],
    );
  }
}
