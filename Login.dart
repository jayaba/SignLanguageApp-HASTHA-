import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/SignUp.dart';
import 'HomePage.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 String _email,_password;
  // Map<String,String> _authData={
  //   'email':'',
  //   'password':'',
  // };
//
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
      // Navigator.pushReplacementNamed(context, "HomePage");
       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
       // Navigator.pushReplacementNamed(context ,"/");
      }
    });
  }
   @override
   void initState(){
     super.initState();
     this.checkAuthentification();
   }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

    }
    try {
      UserCredential user=await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => SignUp()));
    } catch (e) {
      showError(e.message);
      print(e);
    }
  }


    showError(String errormessage) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error Loading'),
              content: Text(errormessage),
              actions: <Widget>[
                FlatButton(onPressed: () {
                  Navigator.of(context).pop();
                },
                    child: Text('Ok'))
              ],
            );
          }
      );
    }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }



    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80.0),
                Container(

                  height: 400,

                  child: Image(image: AssetImage("images/login.png"),
                    fit: BoxFit.contain
                    ,),

                ),
                SizedBox(height: 40.0),
                Container(
                  margin: EdgeInsets.fromLTRB(50.0, 30.0, 50, 30),

                  color: Colors.white38,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input.isEmpty)
                                  return 'Please enter valid Email';
;                              },
                              decoration: InputDecoration(
                                labelText: 'enter your Email',

                                prefixIcon: Icon(Icons.email),
                                labelStyle: TextStyle(fontSize: 15.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                               onSaved: (input) => _email = input),



                          ),



                        SizedBox(height: 60.0),
                        Container(margin: EdgeInsets.fromLTRB(10.0, 30.0, 0,
                            30),
                          color: Colors.white38,

                          child: TextFormField(
                              validator: (input) {
                                if (input.length < 6)
                                  return 'Please provide atleast 6 Character';
                              },
                              decoration: InputDecoration(
                                  labelText: 'enter your Password',
                                  prefixIcon: Icon(Icons.lock),
                                  labelStyle: TextStyle(fontSize: 15.0,
                                    letterSpacing: 1.0,


                                  )
                              ),
                              obscureText: true,

                                onSaved:
                                    (input) => _password = input
                                ,


                              ),




                        ),

                        RaisedButton(onPressed: login,
                          child: Text('Login', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,

                          ),
                          ),
                          padding: EdgeInsets.fromLTRB(96, 17, 96, 17),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular((20.0))),
                        ),


                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    }
  }


