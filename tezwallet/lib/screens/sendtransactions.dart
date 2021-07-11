import 'package:flutter/material.dart';
import 'package:tezster_dart/models/key_store_model.dart';
import 'package:tezster_dart/tezster_dart.dart';

class sendTransactions extends StatelessWidget {
  List<String> keys;
  var rpc;
  sendTransactions({Key? key, required this.keys, required this.rpc}) : super(key: key);


  String amount = "";
  String account = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TezWAllet"),
        backgroundColor: Colors.yellow[700],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.deepPurple[200],
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_upward),
                  Text('Send Tez'),
                ],
              ),
            ),
            Text(
              'Recipient',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Color(0xffff9900))),
              child: TextFormField(
                onChanged: (c) => account = c,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'tk1312lasdkkmdaksmdkakml',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Amount',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Color(0xffff9900))),
              child: TextFormField(
                onChanged: (c) => amount = c,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('Tez'),
                  ),
                  hintText: '00000',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Text('Using the default gas fee as 10000 mutez',
                style: TextStyle(color: Colors.grey)),
            SizedBox(
              height: 40,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _makeTransation();
                    Navigator.pop(context);
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
        ),
      ),
    );
  }
  void _makeTransation() async {
    var server = rpc;
    var keyStore = KeyStoreModel(
      publicKey: keys[1],
      secretKey: keys[0],
      publicKeyHash: keys[2],
    );

    var transactionSinger = await TezsterDart.createSigner(
      TezsterDart.writeKeyWithHint(keyStore.secretKey, 'edsk')
    );
    var transactionResult = await TezsterDart.sendTransactionOperation(
      server,
      transactionSinger,
      keyStore,
      account,
      int.parse(amount),
      10000
    );
  }
}