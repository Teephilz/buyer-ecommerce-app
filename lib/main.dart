import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taiwo_ecommerce_app/provider/category_provider.dart';
import 'package:taiwo_ecommerce_app/provider/order_provider.dart';
import 'package:taiwo_ecommerce_app/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:taiwo_ecommerce_app/provider/user_provider.dart';
import 'package:taiwo_ecommerce_app/screens/home_screen.dart';
import 'package:taiwo_ecommerce_app/screens/login_screen.dart';

import 'provider/cart_provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  runApp(
      const MyApp(
      ));
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProductProvider()),
          ChangeNotifierProvider(create: (context) =>CategoryProvider()),
          ChangeNotifierProvider(create: (context) =>UserProvider()),
          ChangeNotifierProvider(create: (context) =>CartProvider()),
          ChangeNotifierProvider(create: (context) =>OrderProvider()),

        ],
        child:MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.orange,
            ),
            debugShowCheckedModeBanner: false,
            home:StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return LogInScreen();
                  }
                  else if(snapshot.hasData){
                    return HomePage();
                  }
                  else
                    return LogInScreen();
                }
            ))
    );
  }
}
