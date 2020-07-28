import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymangement/models/user_model.dart';
import 'griddashboad.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:http/http.dart' as http;

import '../network_handle.dart';

class MainPage extends StatefulWidget {
  final Future<User> userFuture;

  const MainPage({Key key, this.userFuture}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();

  // Future fetchSuccessRatioAndRequiredInterviews() async {
  // final response = await networkHandler.get();
  // return json.decode(response.body);
}

class _MainPageState extends State<MainPage> {
  NetworkHandler networkHandler = NetworkHandler();
  int money = 0;

  @override
  void initState() {
    super.initState();
  }

  buildProfileInfo(String username) {
    print('user info $username');
    if (username == null) {
      username = "null";
    }
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Xin chào,',
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                  Text(
                    username,
                    style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    NumberFormat("#,###", "vi").format(money),
                    style: GoogleFonts.muli(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  Text(
                    'VND',
                    style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          FutureBuilder<User>(
            future: widget.userFuture,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.name);
                money = snapshot.data.money;
                return Container(
                  child: buildProfileInfo(snapshot.data.name),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard(
            userFuture: widget.userFuture,
          ),
        ],
      ),
    );
  }
}
