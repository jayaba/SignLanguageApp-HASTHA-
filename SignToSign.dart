import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_app/Login.dart';


import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_app/Login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
class SignToSign extends StatefulWidget {
  @override
  _SignToSignState createState() => _SignToSignState();
}

class _SignToSignState extends State<SignToSign> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

//lo ad model
  loadModel() async {
    await Tflite.loadModel(
      model: "images/model_unquant.tflite",
      labels: "images/labels.txt",
      numThreads: 1,
    );
  }

//identify image
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

//get image
  pickImageCam() async {
    var imageOpen = await ImagePicker.pickImage(source: ImageSource.camera);

    if (imageOpen == null) return null;
    setState(() {
      _loading = true;
      _image = imageOpen;
    });
    classifyImage(_image);
  }

  pickImagePhone() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Hasthe Sign Language Recognition System",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading
                ? Container(
              height: 300,
              width: 300,
            )
                : Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null ? Container() : Image.file(_image),
                  SizedBox(
                    height: 20,
                  ),
                  _image == null
                      ? CircleAvatar(radius: 150, backgroundColor: Colors.transparent,)
                      : _outputs != null
                      ? Text(
                    _outputs[0]["label"],
                    style: TextStyle(
                        color: Colors.black, fontSize: 20),
                  )
                      : Container(child: Text(""))
                ],
              ),
            ),Container(
              child: (Text(
                'No selected images ',
                style: TextStyle(
                  color: Colors.deepOrange,fontSize: 15,
                ),
              )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            RaisedButton(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular((20.0))),
              padding: EdgeInsets.fromLTRB(96, 17, 96, 17),
              color: Colors.blue,
             // tooltip: 'Pick Image',
              onPressed: pickImageCam,
              child: Icon(
                Icons.add_a_photo,
                size: 20,
                color: Colors.white,

              ),
             // backgroundColor: Colors.lightBlue,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 42),
              child:   RaisedButton(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular((20.0))),
                padding: EdgeInsets.fromLTRB(96, 17, 96, 17),
                color: Colors.blue,
                onPressed: pickImagePhone,
                child: Icon(
                  Icons.add_photo_alternate_sharp,
                  size: 20,
                  color: Colors.white,
                ),
              //  backgroundColor: Colors.lightBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}



































// import 'package:flutter/material.dart';
// import 'dart:io';
//
// import 'package:flutter_app/Login.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
//
// class SignToSign extends StatefulWidget {
//   @override
//   _SignToSignState createState() => _SignToSignState();
// }
//
// class _SignToSignState extends State<SignToSign> {
// List _outputs;
//   File _image;
//   bool loading=true;
//   final imagePicker=ImagePicker();
//
//   Future getImageCam() async{
//     final image=await imagePicker.getImage(source: ImageSource.camera);
//     setState(() {
// _image=File(image.path);
//     });
//   }
//
//   Future getImageGal() async{
//     final image=await imagePicker.getImage(source: ImageSource.gallery);
//     setState(() {
//       _image=File(image.path);
//     });
//   }
//
//
//   //
//   @override
//   void initState() {
//
//     super.initState();
//     loading=true;
//
//     loadModel().then((value) {
//       setState(() {
//         loading = false;
//       });
//     });
//     }
//
// loadModel() async {
//   await Tflite.loadModel(
//     model: "images/model_unquant.tflite",
//     labels: "images/labels.txt",
//     numThreads: 1,
//   );
// }
// classifyImage(File image) async {
//   var output = await Tflite.runModelOnImage(
//       path: image.path,
//       imageMean: 0.0,
//       imageStd: 255.0,
//       numResults: 2,
//       threshold: 0.2,
//       asynch: true
//   );
//   setState(() {
//     loading = false;
//     _outputs = output;
//   });
// }
//   //
//   // @override
//   // void dispose()async {
//   //
//   //   super.dispose();
//   //   await Tflite.close();
//   //
//   //
//   // }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlueAccent,
//         centerTitle: true,
//         title: Text('Hastha Sign Recognition System',
//
//         style: TextStyle(
//           color: Colors.white
//         ),),
//       ),
// body:SingleChildScrollView(child:Container(
//   color: Colors.white,
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       loading ? Container(
//         height: 300,
//         width: 300,
//       ):
//       Container(
//         margin: EdgeInsets.all(20),
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image == null ? Container() : Image.file(_image),
//             SizedBox(
//               height: 20,
//             ),
//             _image == null ? Container() : _outputs != null ?
//             Text(_outputs[0]["label"],style: TextStyle(color: Colors.black,fontSize: 20),
//             ) : Container(child: Text(""))
//           ],
//         ),
//       ),
//       SizedBox(
//         height: MediaQuery.of(context).size.height * 0.01,
//       ),
//       FloatingActionButton(
//         tooltip: 'Pick Image',
//         onPressed: getImageGal,
//         child: Icon(Icons.add_a_photo,
//           size: 20,
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.amber,
//       ),
//     ],
//   ),
// ),)
//
//
//     );
// // body:  SingleChildScrollView(
// //   child:Container(
// //     child: Column(
// //         children: <Widget>[
// //           SizedBox(height: 80.0),
// //           Container(
// //
// //           height: 400,
// //
// //           child: Image(image: AssetImage("images/signtosign2.png"),
// //           fit: BoxFit.contain,),
// //              ),
// //           SizedBox(height: 20,),
// //           Container(
// // //padding: EdgeInsets.fromLTRB(10, 0, 20, 10),
// //             child: _image==null?Text('No Image Selected Yet,Click below to add images '):Image.file(_image),
// //
// //           ),
// //           SizedBox(height: 30,),
// //           Container(child:RaisedButton(
// //
// //             onPressed: getImageCam,
// //             color: Colors.lightBlue,
// //             shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular((20.0))),
// //             padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
// //             child:
// //             Icon(Icons.camera_alt),
// //
// //
// //           ),),
// //
// //           SizedBox(height: 40,),
// //           Container(child:RaisedButton(
// //
// //             onPressed: getImageGal,
// //             color: Colors.lightBlue,
// //             shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular((20.0))),
// //             padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
// //             child:
// //             Icon(Icons.file_upload),
// //
// //
// //           ),)
// //         ]),
// //   ),
// // )
//
//
//
//     // body: Container(
//       //   padding: EdgeInsets.fromLTRB(1, 35, 1, 1),
//       //   child:
//       //   Image(image: AssetImage("images/signtosign2.png",),
//       //
//       //   ),
//       //
//       // ),
//
//
//
//
//
//       // body: Center(
//       //
//       //     child: _image==null?Text('No Image Selected'):Image.file(_image),
//       //   ),
//       //
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: getImage,
//       //   backgroundColor: Colors.blue,
//       //   child: Icon(Icons.camera_alt),
//       // ),
//     //);
//   }
// }
