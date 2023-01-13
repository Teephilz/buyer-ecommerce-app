


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:taiwo_ecommerce_app/widgets/my_button.dart';
import 'package:taiwo_ecommerce_app/widgets/notification_button.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import 'home_screen.dart';


class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late File pickedImage;
  late String imageUrl;
  late String userImage;

  @override
  void initState() {
    pickedImage= File("");
    imageUrl= "";
    userImage="";
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();


  Future<void> getImage({required ImageSource source}) async {
    final PickedFile? _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      pickedImage = File(_image.path);
    }
  }

  Future<void> myDialogBox() {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Pick from Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library_outlined),
                    title: Text("Pick from Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }


  Future<void> uploadImage({required File image}) async {
    User? user = FirebaseAuth.instance.currentUser;
    Reference storageReference = FirebaseStorage.instance.ref().child(
        "UserImage/${user?.uid}");
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot snapshot= await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("User").doc(user?.uid).update({
      "UserImage": imageUrl
    });
    
    
  }


  Future<void> userDetailUpdate() async{
    User? user = FirebaseAuth.instance.currentUser;
    if (
    _usernameTextController.text.isEmpty &&
        _phoneTextController.text.isEmpty &&
        _addressTextController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fill in all details correctly");
    }
    else if( _addressTextController.text.length > 40){
      Fluttertoast.showToast(msg: "Enter address not more than 40 characters");
    }
    else {
      FirebaseFirestore.instance.collection("User").doc(user?.uid).update({
        "Username": _usernameTextController.text,
        "UserPhoneNumber": _phoneTextController.text,
        "UserAddress": _addressTextController.text
      });
    }
  }


  Widget _buildSingleContainer(
      {required String startText, required String endText}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
      ),
      child: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(startText, style: TextStyle(
                  fontSize: 17, color: Colors.black45
              ),),
            ),
            Expanded(
              child: Text(endText, style: TextStyle(
                  fontSize: 17, color: Colors.black,
                  fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),

      ),
    );
  }


  Widget _buildSingleTextFormField({required String name, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: name,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 1,),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 1,),

          )
      ),
    );
  }

  bool edit = false;

  Widget _buildTextFormFieldpart() {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    productProvider.getUserData();
    List<UserModel>usermodel = productProvider.getUsermodelList;

    return
      Column(
          children: usermodel.map((e){
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSingleTextFormField(name: "Username", controller: _usernameTextController),
                  SizedBox(height: 5,),
                  _buildSingleContainer(startText: "Email",
                      endText: e.useremail),
                  SizedBox(height: 5,),
                  _buildSingleContainer(startText: "Gender",
                      endText: e.usergender),
                  SizedBox(height: 5,),
                  _buildSingleTextFormField(name: "PhoneNumber", controller: _phoneTextController),

                  SizedBox(height: 5,),
                  _buildSingleTextFormField(name: "Address", controller: _addressTextController)

                ],

              ),
            );}).toList()
      );
  }



  Widget _buildContainerPart() {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    productProvider.getUserData();
    List<UserModel>usermodel = productProvider.getUsermodelList;

    return Column(
        children: usermodel.map((e) {
          userImage= e.userImage;
          _usernameTextController = TextEditingController(text: e.username);
          _phoneTextController=TextEditingController(text: e.userPhonenumber);
          _addressTextController=TextEditingController(text:e.userAddress);


          return Container(
            height: 300,
            child: Column(
              children: [
                _buildSingleContainer(startText: "Name",
                    endText: e.username),
                _buildSingleContainer(startText: "Email",
                    endText: e.useremail),
                _buildSingleContainer(startText: "Gender",
                    endText: e.usergender),
                _buildSingleContainer(startText: "Phone Nunmber",
                    endText: e.userPhonenumber),
                _buildSingleContainer(startText: "Address",
                    endText: e.userAddress),

              ],
            ),
          );}).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.white60.withOpacity(0.9),
        appBar: AppBar(
          leading: edit == false ? IconButton(
              icon: Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }) : IconButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
              icon: Icon(Icons.close_outlined, color: Colors.white,)),

          title: edit == false? Text("Profile",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),):Container(),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
            edit == false ? NotificationButton() :
                GestureDetector(onTap: (){
                  uploadImage(image: pickedImage);
                  setState(() {
                    edit = false;
                  });
                },
                    child: Row(
                  children: [
                    Text("Upload Image", style: TextStyle(color: Colors.white,
                        fontSize: 17, fontWeight: FontWeight.bold),),
                    Icon(Icons.check, color: Colors.white,)
                  ],
                ))
          ],

        ),
        body:
        SingleChildScrollView(
          child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Container(
                              height: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                      maxRadius: 75,
                                      backgroundImage: userImage ==""? AssetImage("images/userimage.png")
                                    :  NetworkImage(userImage)
                                       as ImageProvider

                                  )
                                ],
                              ),
                            ),
                          ),
                          edit == true ? Padding(
                            padding: const EdgeInsets.only(left: 170, top: 140),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  myDialogBox();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Icon(Icons.camera_alt_rounded,
                                    color: Colors.black,),
                                ),
                              ),
                            ),
                          ) : Container()

                          ///it means that if you want to edit the pen icon will show and if not,
                          ///             it will return an empty container i.e
                        ],
                      ),
                    ),

                    Container(
                        height: 330,
                        width: double.infinity,
                        child: edit == true
                            ? _buildTextFormFieldpart()
                            : _buildContainerPart()
                    ),
                    edit == false ? MyButton(buttonName: "Edit Profile",
                      onPressed: () {
                        setState(() {
                          edit = true;
                        });
                      },
                    ) : MyButton(buttonName: "Save Edits",
                      onPressed: () {
                        userDetailUpdate();
                        setState(() {
                          edit = false;
                        });
                      },
                    )


                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
