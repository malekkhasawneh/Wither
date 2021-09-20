import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselearning/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Users.dart';
import 'WitherApiScreen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplachScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? imageFile;

  _uploadImage(BuildContext context, ImageSource imageSource) async {
    var picture = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      imageFile = picture!;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showMyDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Take Picture'),
            actions: [
              ListTile(
                title: Text('From Gallery'),
                onTap: () {
                  _uploadImage(context, ImageSource.gallery);
                },
              ),
              ListTile(
                title: Text('From Camera'),
                onTap: () {
                  _uploadImage(context, ImageSource.camera);
                },
              ),
            ],
            scrollable: true,
          );
        });
  }

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retypePassword = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Register'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            imageFile == null
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text('Choose Photo'),
                            )
                                : Image.file(
                              File(imageFile!.path),
                              width: 400,
                              height: 400,
                              errorBuilder: (BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,) {
                                return Icon(
                                  Icons.image,
                                  size: 45,
                                );
                              },
                            ),
                            ElevatedButton(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                child: Icon(Icons.add),
                              ),
                              onPressed: () {
                                _showMyDialog(context);
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: userName,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                              labelText: 'Name',
                              hintText: 'Your Name',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email',
                                hintText: 'example@example.com',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: 'Password',
                                hintText: 'must be more than 6 characters',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: retypePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: 'Re-Password',
                                hintText: '*****',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: phone,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                labelText: 'Phone',
                                hintText: '07-0000',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              addUser.userRegister(
                              name: userName.text,
                              email: email.text,
                              password: password.text,
                              phone: phone.text);
                            },
                            child: Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}

class Login extends StatelessWidget {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ))
          ],
          centerTitle: true,
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: 120),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                              'https://i1.wp.com/www.wzfne.com/wp-content/uploads/2017/09/IMG_3420.jpg?fit=200%2C200&ssl=1')),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            hintText: 'example@example.com',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                              labelText: 'Password',
                              hintText: '*****',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            addUser.userLogin(
                                email: email.text, password: password.text);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                    WitherApp()));
                          },
                          child: Text('Sign In')),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
