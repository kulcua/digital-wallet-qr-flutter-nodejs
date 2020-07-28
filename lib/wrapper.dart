import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymangement/authen/authen.dart';
import 'package:moneymangement/models/user.dart';
import 'package:moneymangement/screens/home.dart';
import 'package:moneymangement/screens/input_pin.dart';
import 'package:moneymangement/screens/splash_screen.dart';
import 'package:moneymangement/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';

class Wrapper extends StatefulWidget {
  final Future<User> userFuture;

  const Wrapper({Key key, this.userFuture}) : super(key: key);
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    //checkLogin();
  }

  // void checkLogin() async {
  //   String token = await storage.read(key: "token");
  //   if (token == null ) {
  //     setState(() {
  //       _state = 1;
  //     });
  //   } else {
  //     setState(() {
  //       _state = 0;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print("vo wrapper");
    if (widget.userFuture == null)
      return Authentication();
    else
      return Home(
        userFuture: widget.userFuture,
      );
  }
}
