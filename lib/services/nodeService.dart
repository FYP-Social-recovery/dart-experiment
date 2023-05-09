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
    _contractAddress=EthereumAddress.fromHex("0x02b7adC4f71B5475Ec124dbf9A44bC5Fb8851b3B");
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
  Future<void> getUserName()async {

  }
  // Future<DeployedContract> loadContract() async {
  //   String abi = await rootBundle.loadString('assets/abi.json');
  //   String contractAddress = _contract.address.toString();
  //   final contract = DeployedContract(ContractAbi.fromJson(abi, 'Election'), EthereumAddress.fromHex(contractAddress));
  //   return contract;
  // }
  // getNotes() async {
  //   List notesList = await _client
  //       .call(contract: _contract, function: _notesCount, params: []);
  //   BigInt totalNotes = notesList[0];
  //   // noteCount = totalNotes.toInt();
  //   // notes.clear();
  //   // for (int i = 0; i < noteCount; i++) {
  //   //   var temp = await _client.call(
  //   //       contract: _contract, function: _notes, params: [BigInt.from(i)]);
  //   //   if (temp[1] != "")
  //   //     notes.add(
  //   //       Note(
  //   //         id: temp[0].toString(),
  //   //         title: temp[1],
  //   //         body: temp[2],
  //   //         created:
  //   //         DateTime.fromMillisecondsSinceEpoch(temp[3].toInt() * 1000),
  //   //       ),
  //   //     );
  //   }
  //   //isLoading = false;
  //   // notifyListeners();
  // }
  //
  // addNote(Note note) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await _client.sendTransaction(
  //     _credentials,
  //     Transaction.callContract(
  //       contract: _contract,
  //       function: _addNote,
  //       parameters: [
  //         note.title,
  //         note.body,
  //         BigInt.from(note.created.millisecondsSinceEpoch),
  //       ],
  //     ),
  //   );
  //   await getNotes();
  // }
  //
  // deleteNote(int id) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await _client.sendTransaction(
  //     _credentials,
  //     Transaction.callContract(
  //       contract: _contract,
  //       function: _deleteeNote,
  //       parameters: [BigInt.from(id)],
  //     ),
  //   );
  //   await getNotes();
  // }
  //
  // editNote(Note note) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print(BigInt.from(int.parse(note.id)));
  //   await _client.sendTransaction(
  //     _credentials,
  //     Transaction.callContract(
  //       contract: _contract,
  //       function: _editNote,
  //       parameters: [BigInt.from(int.parse(note.id)), note.title, note.body],
  //     ),
  //   );
  //   await getNotes();
  // }

}
