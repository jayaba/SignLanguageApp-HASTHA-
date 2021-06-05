import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/SignToSign.dart';
import 'package:flutter_app/Start.dart';
import 'SignToSign.dart';
import 'SignToSign.dart';
import 'SignToSign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/SignToSign.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  User user;
  bool isloggedin=false;

  navigateToSignToSign()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignToSign()));
  }

  chechAuthentification()async{
    _auth.authStateChanges().listen((user) {
      if(user==null){
        Navigator.of(context).pushReplacementNamed("start");
       // Navigator.push(context,MaterialPageRoute(builder: (context)=>Start()));
      }
    });

  }
  getUser()async{
    User firebaseUser=await  _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser=await _auth.currentUser;
if(firebaseUser!=null){
  setState(() {
    this.user=firebaseUser;
    this.isloggedin=true;
  });
}
  }

  @override
  void initState() {
    super.initState();
    this.chechAuthentification();
    this.getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: !isloggedin
              ? CircularProgressIndicator()
              : Column(
            children: <Widget>[
              SizedBox(height: 40.0),
              Container(
                height: 300,
                child: Image(
                  image: AssetImage("images/afterlogin1.png"),
                  fit: BoxFit.contain,
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(0.0, 40.0, 20, 10),
                child: Text(
                  "Hello ",

                  style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.w300,
                      color: Colors.blue[400]),
                ),

              ),
                SizedBox(height: 1.0,),
                Container(
                  padding: EdgeInsets.fromLTRB(130.0, 0.0, 20, 10),
                  child: Text(
                    'There',
                    style: TextStyle(
                        fontSize: 95,
                        fontWeight: FontWeight.w200,
                        color: Colors.blue[400]),
                  ),
                ),


              Container(
                padding: EdgeInsets.fromLTRB(0.0, 40.0, 20, 10),
                child: Text(
                  "You're logged in ${user.email} ",

                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.green[500]),
                ),

              ),

SizedBox(height: 30,),
              Container(
                child: RaisedButton(
                  child: Text('Voice to Sign',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 1.0),

                  ),

                  onPressed: (){},
                  padding: EdgeInsets.fromLTRB(96, 17, 96, 17),

                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((20.0))),
                  ),
                ),
SizedBox(height: 40,),
              Container(
                child: RaisedButton(
                  child: Text('Sign to Sign ',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 1.0),

                  ),

                  onPressed:navigateToSignToSign,
                  padding: EdgeInsets.fromLTRB(96, 17, 96, 17),

                  color: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((20.0))),
                ),
              ),






              // RaisedButton(
              //   padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
              //  // onPressed: signOut,
              //   child: Text('Signout',
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20.0,
              //           fontWeight: FontWeight.bold)),
              //   color: Colors.orange,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20.0),
              //   ),
              // )
            ],
          ),
        ));

  }
}

