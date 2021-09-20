import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UserProfile.dart';
import 'Users.dart';
import 'getDataFromApi.dart';
import 'main.dart';

class WitherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmployeeList(),
    );
  }
}

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UserProfile()));
          },
          icon: Icon(Icons.settings),
        ),
        actions: [
          IconButton(
              onPressed: () {
                addUser.userLogout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => Login()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
        centerTitle: true,
        title: Text('Wither Information'),
      ),
      body: FutureBuilder(
        future: getWitherInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text('${snapshot.error} has occurred.'),
            );
          else if (snapshot.hasData) {
            final Wither data = snapshot.data as Wither;
            return ListView.builder(
                itemCount: data.weather!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:  EdgeInsets.only(top: 200),
                    child: Center(
                      child: Card(
                          child: Stack(
                            children: [
                              Image.network(
                                  'https://store-images.s-microsoft.com/image/apps.10595.14397430983184912.cfdf6f70-0a34-4999-b494-936559d822c3.7355576f-baf9-4be3-8b34-27bdc6ac1bd2?mode=scale&q=90&h=200&w=200&background=%230078D7'),
                            Padding(
                              padding:  EdgeInsets.only(top: 157),
                              child: Container(width: 200,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                                        Text('Icon : ${data.weather![index].icon.toString()}'),
                                        Text('Main : ${data.weather![index].main.toString()}'),
                                    ],),
                                    Padding(
                                      padding:  EdgeInsets.only(top: 15),
                                      child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                                        Text('Id : ${data.weather![index].id.toString()}'),
                                        Text('Des : ${data.weather![index].description.toString()}'),
                                      ],),
                                    ),
                                  ],
                                ),
                              ),
                            )],
                          ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
