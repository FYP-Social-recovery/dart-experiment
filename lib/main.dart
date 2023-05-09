import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:http/http.dart';
import 'package:pheonix/screens/home.dart';
import 'package:pheonix/services/nodeService.dart';
import 'package:pheonix/services/publicContractService.dart';
import 'package:pheonix/services/testServiceTwo.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:web3dart/web3dart.dart';
Future<void> main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TestServiceTwo testTwo=new TestServiceTwo();
    PublicContract pc=new PublicContract();
    NodeService ns=new NodeService();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        body: Container(
          child: Column(
            children: [
              Text("Page loaded"),
              IconButton(onPressed: ()=>{ns.init()}, icon: Icon(Icons.face_rounded))
            ],
          ),
        ),
      ),

    );
  }
}
