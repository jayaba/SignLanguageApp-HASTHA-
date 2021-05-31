import 'package:flutter/material.dart';
import 'package:flutter_app/Login.dart';
import 'package:flutter_app/SignUp.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'Login.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  navigateToLogin()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
  }
  navigateToSignIn()async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:<Widget> [
            SizedBox(height: 97.0,),
            Container(
              height: 400,
              child: Image(image: AssetImage("images/start.png"),
              fit: BoxFit.contain,),

            ),
            SizedBox(height: 20.0,),
            RichText(text: TextSpan(
              text: 'Welcome to',style: TextStyle(fontSize: 27.0,fontWeight: FontWeight.bold,color: Colors.black
            ),

              children: <TextSpan>[
                TextSpan(
                  text: '  HASTHA ',style: TextStyle(
                  fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent,
                )
                )
              ]
            ),
            ),
SizedBox(height: 15.0,),
Text('Sign language is the noblest gift God has given to deaf people.',style: TextStyle(color: Colors.blueAccent,fontSize: 15.0),),
          SizedBox(height:50.0),
          Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(onPressed: navigateToLogin,
              child: Text('Login',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.white),
              
              ),
padding: EdgeInsets.fromLTRB(100, 17, 100, 17),
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((20.0))),
              ),


SizedBox(height: 30.0,),
              RaisedButton(onPressed: navigateToSignIn,
                child: Text('SignUp',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.white),

                ),
                padding: EdgeInsets.fromLTRB(96, 17, 96, 17),
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((20.0))),
              ),
              
              

              
              


            ],



          ),
            SizedBox(height: 40.0,),
            SignInButton(

              Buttons.Google,
              text: 'Sign up with Google',
              onPressed: (){},

            )

          ],
        ),
      ),
    );
  }
}
