import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class TestServiceTwo {

  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";

  late Web3Client _client;
  late String _abiCode;

  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;


  final String _privateKey = "3d789a56b97933f50f9ea622a0ea95982823b2dcb6f248b58b5aff3872f247e7";

  // TestServiceTwo(){
  //   init();
  // }

  init() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCreadentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle
        .loadString("contracts/build/contracts/Node.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCreadentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "Node"), _contractAddress);
    print(_contract.address);
  }

  Future<String> getUserName()async{

    return "";
  }
}
