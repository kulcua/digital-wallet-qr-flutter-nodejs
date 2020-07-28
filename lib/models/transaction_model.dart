import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String idSender;
  final String idReceiver;
  final String state;
  final int money;
  final Timestamp time;
  final String typeTransaction;
  //final String pushToken;

  TransactionModel(
      {this.id,
      this.idSender,
      this.idReceiver,
      this.state,
      this.money,
      this.time,
      this.typeTransaction});
  // this.pushToken});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['data']['_id'],
        idSender: json['data']['idSender'],
        idReceiver: json['data']['idReceiver'],
        state: json['data']['state'],
        money: json['data']['money'],
        time: json['data']['time'],
        typeTransaction: json['data']['typetransaction']);
  }
}
