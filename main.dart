import 'package:flutter/material.dart';
import 'package:flutter_app/Login.dart';
import 'package:flutter_app/Start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'HomePage.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';


 main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


        theme:ThemeData(

          primaryColor: Colors.orange
        ) ,
        debugShowCheckedModeBanner: false,
        home: Start(),
      );

  }
}
