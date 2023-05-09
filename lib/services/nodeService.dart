import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';


class NodeService {
  bool isLoading = true;

  // final String _rpcUrl = "https://goerli-rollup.arbitrum.io/rpc";
  // final String _wsUrl = "ws://goerli-rollup.arbitrum.io/rpc/";

  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";

  final String _privateKey = "ec754553254fd6b9bcfa929e27d378b648b4ac8adf926b0663e41e13c03c174d";

  late Web3Client _client;
  late String _abiCode;

  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  late ContractFunction _notesCount;
  late ContractFunction _notes;
  late ContractFunction _addNote;
  late ContractFunction _deleteNote;
  late ContractFunction _editNote;
  late ContractEvent _noteAddedEvent;
  late ContractEvent _noteDeletedEvent;
  NodeService() {
    init();
  }


  init() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCreadentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    print("test1 ");
    String abiStringFile = await rootBundle.loadString("contracts/build/contracts/Node.json");

    print("trst2 ");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    // _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["421613"]["address"]);
    _contractAddress=EthereumAddress.fromHex("0xaD24Fc1d8eC357C9d0B7Fe252AB8172e67F552C9");
  }

  Future<void> getCreadentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "Node"), _contractAddress);
    // _notesCount = _contract.function("notesCount");
    // _notes = _contract.function("notes");
    // _addNote = _contract.function("addNote");
    //
    // _editNote = _contract.function("editNote");
    //
    // _noteAddedEvent = _contract.event("NoteAdded");
    // _noteDeletedEvent = _contract.event("NoteDeleted");
    //await getNotes();
    print(_contract.address);
  }
  // state changing function
  Future<String> callFunction(String funcname, List<dynamic> args, String privateKey) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = _contract;
    final ethFunction = contract.function(funcname);
    final result = await _client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
        ),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  //non state change function
  Future<List<dynamic>> ask(String funcName, List<dynamic> args) async {
    final contract = _contract;
    final ethFunction = contract.function(funcName);
    final result = _client.call(contract: contract, function: ethFunction, params: args);
    return result;
  }
  Future<void> getUserName()async {
var res= await ask("getUserName", []);
print(res);
  }

}
