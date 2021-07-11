import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:tezwallet/fileOperations/fileOperations.dart';
import 'package:tezster_dart/tezster_dart.dart';
import 'package:tezwallet/screens/receivetransactions.dart';
import 'package:tezwallet/screens/sendtransactions.dart';

class Home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<Home> {
  List<String> keys = [];
  String balance = "0";
  String selectedNetwork = 'Mainnet';

  Map<String, String> networks = {
    'Mainnet': 'api.tzkt.io',
    'Edo2net': 'api.edo2net.tzkt.io',
    'Florence Net': 'api.florencenet.tzkt.io'
  };

  Map<String, String> networksChains = {
    'Mainnet': 'https://mainnet.smartpy.io',
    'Edo2net': 'https://edonet.smartpy.io/',
    //'Florence Net': 'api.florencenet.tzkt.io'
  };

  @override
  void initState() {
    super.initState();
    updateBalance();
    getKeys().readKeys().then((info) {
      setState(() {
        keys = info;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "TezWallet",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.yellow[700],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: TextStyle(fontSize: 16),
                      value: selectedNetwork,
                      items: networks.keys
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e,
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedNetwork = value.toString();
                        });
                        updateBalance();
                      },
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: keys[2]));
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied To clipboard')));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Color(0xffff9900)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    keys[2],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Balance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Color(0xffff9900)),
                ),
                child: Text(
                  '$balance mutez',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  updateBalance();
                },
                child: Text(
                  "Update Balance",
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.yellow[700]),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.yellow))),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        updateBalance();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sendTransactions(

                                  keys: keys,
                                  rpc: networksChains[selectedNetwork],
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.arrow_upward),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Send")
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow[700]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.yellow))),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        updateBalance();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => receiveTransactions(
                                      keys: keys,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.qr_code),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Receive")
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow[700]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.yellow))),
                      ))
                ],
              ),
            )
          ],
        ));
  }

  Future<String> getBalance() async {
    String string =
        await TezsterDart.getBalance(keys[2], networksChains[selectedNetwork]);
    print("got balance : $string");
    return string;
  }

  void updateBalance() {
    getBalance().then((Balance) {
      setState(() {
        balance = Balance;
      });
    });
  }
}
