import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
Future<void> main() async{
  String randomMnemonic = bip39.generateMnemonic();
  // print(randomMnemonic);
  String seed = bip39.mnemonicToSeedHex(randomMnemonic);
  print("Seed : "+seed.toString());
  // bool isValid = bip39.validateMnemonic(mnemonic);
  // print(isValid);
  // isValid = bip39.validateMnemonic('basket actual');
  // print(isValid);
  String entropy = bip39.mnemonicToEntropy(randomMnemonic);
  print("Entropy : "+entropy.toString());
  String mnemonic = bip39.entropyToMnemonic(entropy);
  print("Mnemonic Phase: "+mnemonic);
  String mnemonic_regenerated = bip39.entropyToMnemonic(entropy);
  // print(mnemonic_regenerated);

  // Chain chain = Chain.seed(hex.encode(utf8.encode(seed)));
  Chain chain = Chain.seed(seed);
  // var key_1 = chain.forPath('m/0/100') as ExtendedPrivateKey;

  ExtendedKey key = chain.forPath("m/44'/60'/0'/0/0");
  String privateKey=key.privateKeyHex().toString().substring(2);
  print("Private Key; "+privateKey);
  Credentials credentials = EthPrivateKey.fromHex(key.privateKeyHex()); //web3dart
  var address = await credentials.extractAddress(); //web3dart
  print("Public key: "+address.toString());



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: const Text( 'Flutter Demo Home Page'),
    );
  }
}
