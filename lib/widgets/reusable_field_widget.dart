import 'package:flutter/material.dart';
class reUsableTextFormField extends StatefulWidget {
  String? text;
  IconData? icon;
  bool? isObscure;
  bool? isPassword;
  TextEditingController? controller;

  reUsableTextFormField({
  this.text, this.icon, this.isObscure, this.isPassword, this.controller
});

  @override
  State<reUsableTextFormField> createState() => _reUsableTextFormFieldState();
}

class _reUsableTextFormFieldState extends State<reUsableTextFormField> {

  void _togglePassword(){
    setState(() {
      widget.isObscure = !widget.isObscure!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return widget.isPassword== false? TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscure!,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(prefixIcon: Icon(widget.icon,color: Colors.white,),
          labelText: widget.text,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)
          )) ,
      keyboardType: TextInputType.emailAddress ,
    )
        :
    TextField(
        controller:widget.controller ,
        obscureText: widget.isObscure! ,
        style: TextStyle(color: Colors.white.withOpacity(0.9)),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock,color: Colors.white,),
          suffixIcon: InkWell(
            onTap: (){
              _togglePassword();
            },
            child:widget.isObscure!? Icon(Icons.visibility,color: Colors.white,
            ): Icon(Icons.visibility_off,color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none)),

          labelText:"Enter password",
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white.withOpacity(0.3),

        ));
  }
}



 Widget signInsignUpButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: ElevatedButton(onPressed: () {
        onTap();
      },
          child: Text(isLogin ? 'LOG IN' : 'SIGN UP',
            style: TextStyle(color: Colors.black87,
                fontWeight: FontWeight.bold, fontSize: 16),),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            }
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
          )
      )
  );
}