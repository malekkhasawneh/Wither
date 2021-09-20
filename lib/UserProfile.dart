import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Users.dart';
class UserProfile extends StatelessWidget {
  XFile? imageFile;

  _uploadImage(BuildContext context, ImageSource imageSource) async {
    var picture = await ImagePicker().pickImage(source: imageSource);
      imageFile = picture!;
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
          title: Text('Edit Profile'),
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
                          child: Text('Update'),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
