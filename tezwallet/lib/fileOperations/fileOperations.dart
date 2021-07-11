import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class getKeys {
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<String> createFolderInAppDocDir() async {

    try {
      if (Platform.isAndroid) {
        if(await _requestPermission(Permission.storage)) {
          final Directory _appDocDir = await getApplicationDocumentsDirectory();
          //App Document Directory + folder name
          final Directory _appDocDirFolder =
          Directory('${_appDocDir.path}/WalletInfo/');

          if (await _appDocDirFolder.exists()) {
            //if folder already exists return path
            return _appDocDirFolder.path;
          } else {
            //if folder not exists create folder and then return its path
            final Directory _appDocDirNewFolder =
            await _appDocDirFolder.create(recursive: true);
            return _appDocDirNewFolder.path;
          }
        }
      }
    } catch (e) {
      print(e);
    }

    return "Not";
  }

  Future<void> writeKeys(List<String> keys, String mnemonic) async {
    String path = await createFolderInAppDocDir();

    //seedphrase
    String filepath = '$path/seedPhrase.txt';

    File file = File(filepath);
    file.writeAsString(mnemonic);

    //secretKey
    String filepath1 = '$path/secretKey.txt';

    File file1 = File(filepath1);
    file1.writeAsString(keys[0]);

    //publicKey
    String filepath2 = '$path/publicKey.txt';

    File file2 = File(filepath2);
    file2.writeAsString(keys[1]);

    //publichash
    String filepath3 = '$path/publichash.txt';

    File file3 = File(filepath3);
    file3.writeAsString(keys[2]);


  }
  Future<List<String>> readKeys() async {

    List<String> keys = [];

    String path = await createFolderInAppDocDir();

    //seedphrase
    String filepath = '$path/seedPhrase.txt';

    File file = File(filepath);
    String seedphrase = await file.readAsString();

    //secretKey
    String filepath1 = '$path/secretKey.txt';

    File file1 = File(filepath1);
    String secretkey =await file1.readAsString();

    //publicKey
    String filepath2 = '$path/publicKey.txt';


    File file2 = File(filepath2);
    String publickey = await file2.readAsString();

    //publichash
    String filepath3 = '$path/publichash.txt';

    File file3 = File(filepath3);
    String publichash = await file3.readAsString();

    keys = [secretkey,publickey,publichash,seedphrase];

    return keys;

  }
}