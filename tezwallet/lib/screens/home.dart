import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatelessWidget {
  final String secretkey, publickey, publichash;
  Home({Key? key, required this.secretkey, required this.publickey, required this.publichash}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(secretkey),
          Text(publickey),
          Text(publichash),
        ],
      ),
    );
  }
}