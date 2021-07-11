import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tezwallet/screens/home.dart';
import 'package:tezwallet/screens/landingPage.dart';
import 'package:tezwallet/fileOperations/fileOperations.dart';

class splashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splashScreen> {

  @override
  void initState() {
    find();
    super.initState();
  }

  void find() async {

    String path = await getKeys().createFolderInAppDocDir();
    File file =  File('$path/secretKey.txt');
    if (await file.exists()) {
      Timer(
          Duration(seconds: 3),
              () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Home())));
    }
    else {
      Timer(
          Duration(seconds: 3),
              () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => landingPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/tez'),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}