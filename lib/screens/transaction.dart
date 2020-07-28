import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymangement/models/user_model.dart';
import 'package:moneymangement/screens/widget/infoReceiver.dart';
import 'package:moneymangement/screens/widget/verifyPin.dart';
import 'package:moneymangement/utilities/currency.dart';

class Transaction extends StatefulWidget {
  final String uidReceiver;
  final Future<User> userFuture;

  const Transaction({Key key, this.userFuture, this.uidReceiver})
      : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  final _formKey = GlobalKey<FormState>();
  int money = 0;
  int _userMoney = 0;
  int _userPin = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Giao dịch',
              style: GoogleFonts.muli(
                  textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
            ),
            backgroundColor: Color(0xff5e63b6),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'NHẬP SỐ TIỀN',
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(
                            () => money = int.parse(val.replaceAll('.', '')));
                        print('money ne $money');
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        CurrencyFormat()
                      ],
                      validator: (val) {
                        if (val.isEmpty) return 'Hãy nhập số tiền';
                        if (money < 1000) {
                          return 'Số tiền phải lớn hơn 1.000';
                        }
                        if (money > _userMoney) {
                          return 'Số dư trong ví không đủ';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      'THÔNG TIN NGƯỜI NHẬN',
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ),
                  InfoReceiver(idReceiver: widget.uidReceiver),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      'NGUỒN TIỀN',
                      style: GoogleFonts.muli(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      )),
                    ),
                  ),
                  Card(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Icon(Icons.account_balance_wallet,
                              size: 45.0, color: Color(0xff5e63b6)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Ví điện tử',
                              style: GoogleFonts.muli(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                            FutureBuilder<User>(
                              future: widget.userFuture,
                              builder: (ctx, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  _userPin = snapshot.data.pin;
                                  _userMoney = snapshot.data.money;
                                  return Text(
                                    '${NumberFormat("#,###", "vi").format(snapshot.data.money)}đ',
                                    style: GoogleFonts.muli(
                                        textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                        Spacer(),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Thay đổi',
                            style: GoogleFonts.muli(
                                textStyle: TextStyle(
                              color: Colors.blue[500],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Color(0xff5e63b6),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyPin(
                                        userMoney: _userMoney,
                                        userPIN: _userPin,
                                      )));

                          print("check");
                        }
                      },
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 80.0),
                      child: Text(
                        "Xác nhận",
                        style: GoogleFonts.muli(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                    ),
                  ),
                ]),
          )),
    );
  }
}
