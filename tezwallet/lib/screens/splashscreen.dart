import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tezwallet/screens/home.dart';
import 'package:tezwallet/screens/landingPage.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

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
    String directory = (await getApplicationDocumentsDirectory()).path;
    String dirtobecreated = "WalletInfo";
    String finaldir = Path.join(directory, dirtobecreated);
    var dir = io.Directory(finaldir);
    bool dirExist = await dir.exists();
    if(dirExist) {
      //seedphrase
      String filepath = '$finaldir/seedPhrase.txt';

      io.File file = io.File(filepath);
      String seedphrase = await file.readAsString();

      //secretKey
      String filepath1 = '$finaldir/secretKey.txt';

      io.File file1 = io.File(filepath1);
      String secretkey =await file1.readAsString();

      //publicKey
      String filepath2 = '$finaldir/publicKey.txt';


      io.File file2 = io.File(filepath2);
      String publickey = await file2.readAsString();

      //publichash
      String filepath3 = '$finaldir/publichash.txt';

      io.File file3 = io.File(filepath3);
      String publichash = await file3.readAsString();
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Home(secretkey: secretkey, publickey: publickey, publichash: publichash))));
    }
    else {
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => landingPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/tez'),
      ),
    );
  }

}
