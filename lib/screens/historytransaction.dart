import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/models/transaction_model.dart';
import 'package:moneymangement/network_handle.dart';
import 'package:moneymangement/screens/widget/trantile.dart';

class HistoryTransaction extends StatefulWidget {
  final String uid;

  HistoryTransaction({this.uid});

  @override
  _HistoryTransactionState createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  NetworkHandler _networkHandler = new NetworkHandler();

  void initState() {
    super.initState();
  }

  Future<List<TransactionModel>> _getTrans() async {
    var data = await _networkHandler.get("/transaction/sender/${widget.uid}");

    var jsonData = json.decode(data.body);

    List<TransactionModel> transactions = [];

    for (var u in jsonData) {
      TransactionModel tran = TransactionModel(
          id: u["id"],
          idSender: u["idSender"],
          idReceiver: u["idReceiver"],
          state: u["state"],
          money: u["money"],
          time: u["time"],
          typeTransaction: u["typeTransaction"]);
      transactions.add(tran);
    }

    print(transactions.length);

    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lịch sử giao dịch',
            style: GoogleFonts.muli(
                textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
          ),
          backgroundColor: Color(0xff5e63b6),
        ),
        body: Container(
            child: FutureBuilder(
                future: _getTrans(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(
                          //     snapshot.data[index].picture
                          //   ),
                          // ),
                          title: Text(snapshot.data[index].name),
                          subtitle: Text(snapshot.data[index].email),
                          onTap: () {
                            // Navigator.push(context,
                            //   new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                            // );
                          },
                        );
                      },
                    );
                  }
                })));
  }
}
