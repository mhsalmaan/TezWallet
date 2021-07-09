import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tezster_dart/tezster_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tezwallet/screens/home.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class landingPage extends StatelessWidget {


  List<String> keys = [];

  void _createWallet() async {
    String mnemonic = TezsterDart.generateMnemonic();

    keys = await TezsterDart.getKeysFromMnemonic(mnemonic: mnemonic);

    Future<String> path = createFolder();
    //seedphrase
    String filepath = '$path/seedPhrase.txt';

    var txtfile = io.File(filepath);
    bool txtFile = txtfile.exists() as bool;
    if(!txtFile) {
      txtfile.create();
    }
    io.File file = io.File(filepath);
    file.writeAsString(mnemonic);

    //secretKey
    String filepath1 = '$path/secretKey.txt';

    var txtfile1 = io.File(filepath1);
    bool txtFile1 = txtfile1.exists() as bool;
    if(!txtFile1) {
      txtfile1.create();
    }
    io.File file1 = io.File(filepath1);
    file.writeAsString(keys[0]);

    //publicKey
    String filepath2 = '$path/publicKey.txt';

    var txtfile2 = io.File(filepath2);
    bool txtFile2 = txtfile2.exists() as bool;
    if(!txtFile2) {
      txtfile2.create();
    }
    io.File file2 = io.File(filepath2);
    file.writeAsString(keys[1]);

    //publichash
    String filepath3 = '$path/publichash.txt';

    var txtfile3 = io.File(filepath3);
    bool txtFile3 = txtfile3.exists() as bool;
    if(!txtFile3) {
      txtfile3.create();
    }
    io.File file3 = io.File(filepath3);
    file.writeAsString(keys[2]);
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home(secretkey: keys[0], publickey: keys[1], publichash: keys[2])));
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

