import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/network_handle.dart';

class InfoReceiver extends StatefulWidget {
  final String idReceiver;

  const InfoReceiver({Key key, this.idReceiver}) : super(key: key);

  @override
  _InfoReceiverState createState() => _InfoReceiverState();
}

class _InfoReceiverState extends State<InfoReceiver> {
  NetworkHandler networkHandler = new NetworkHandler();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: networkHandler.getUserwithId(widget.idReceiver),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Tên người nhận',
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                        Text(
                          snapshot.data.name,
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Số điện thoại',
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                        Text(
                          snapshot.data.username,
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Thời gian giao dịch',
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                        Text(
                          DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
                          style: GoogleFonts.muli(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
