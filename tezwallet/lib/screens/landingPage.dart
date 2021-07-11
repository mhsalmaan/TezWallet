import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tezster_dart/tezster_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tezwallet/screens/home.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:tezwallet/fileOperations/fileOperations.dart';

class landingPage extends StatelessWidget {


  List<String> keys = [];

  void _createWallet() async {
    String mnemonic = TezsterDart.generateMnemonic();

    keys = await TezsterDart.getKeysFromMnemonic(mnemonic: mnemonic);

    getKeys().writeKeys(keys, mnemonic);
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "TezWallet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: FlatButton(
                child: Text(
                  "Create Wallet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.yellow[700],
                onPressed: () {
                  _createWallet();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FlatButton(
                child: Text(
                  "Import Wallet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.yellow[700],
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
  
}

Future<String> createFolder() async {

  String directory = (await getApplicationDocumentsDirectory()).path;
  String dirtobecreated = "WalletInfo";
  String finaldir = join(directory, dirtobecreated);
  var dir = io.Directory(finaldir);
  bool dirExist = await dir.exists();
  if(!dirExist) {
    dir.create(recursive: true);
  }

  return finaldir;
}

