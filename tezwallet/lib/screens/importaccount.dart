import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tezster_dart/tezster_dart.dart';
import 'package:tezwallet/fileOperations/fileOperations.dart';
import 'package:tezwallet/screens/home.dart';

class importAccount extends StatelessWidget {
  importAccount({Key ? key}) : super(key: key);


  String mnemonic = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Color(0xffff9900))),
            child: TextFormField(
              onChanged: (c) => mnemonic = c,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text('Enter Seed Phrase'),
                ),
                hintText: 'String',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  createAccount().then((account) {
                    if(account == true)
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                      }
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Send'),
                ),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.yellow[700]),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:
                            BorderSide(color: Colors.yellow)))),
              )),
        ],
      )
    );
  }

  Future<bool> createAccount() async {
    bool accounthas = false;
    List<String> keys = await TezsterDart.getKeysFromMnemonic(
      mnemonic: mnemonic
    );
    getKeys().writeKeys(keys, mnemonic);
    String path = await getKeys().createFolderInAppDocDir();
    File file =  File('$path/secretKey.txt');
    if (await file.exists()) {
      accounthas = true;
    }
    return accounthas;
  }}