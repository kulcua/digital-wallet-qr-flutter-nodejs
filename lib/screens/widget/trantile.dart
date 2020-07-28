// import 'package:flutter/material.dart';
// import 'package:moneymangement/models/transaction_model.dart';
// import 'package:moneymangement/network_handle.dart';

// class TranTile extends StatefulWidget {
//   final String uid;
//   final String tranid;

//   const TranTile({Key key, this.uid, this.tranid}) : super(key: key);
//   @override
//   _TranTileState createState() => _TranTileState();
// }

// class _TranTileState extends State<TranTile> {
//   TransactionModel _tran;
//   //NetworkHandler

//   @override
//   Widget build(BuildContext context) {
//     return  StreamBuilder<TransactionModel>(
//         stream: ,
//         builder: (context, snapshot) {
//           print('snapshot tile ${snapshot.hasData}');
//           if (!snapshot.hasData) {
//             return SizedBox.shrink();
//           } else {
//             _tran = snapshot.data;
//             return GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => ResultTransaction(
//                       moneyTrans: _tran.money,
//                       moneyUser: widget.user.money,
//                       nameReceiver: userReceiver.name,
//                       idTrans: '3458364913854',
//                     )),
//               ),
//               child: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.white,
//                       backgroundImage: AssetImage(checkStateImage(widget.user.id, _tran.idReceiver)),
//                     ),
//                     title: FutureBuilder(
//                         future:
//                         DatabaseService.getUserWithId(_tran.idReceiver),
//                         builder:
//                             (BuildContext context, AsyncSnapshot snapshot) {
//                           if (!snapshot.hasData) {
//                             return SizedBox.shrink();
//                           }
//                           userReceiver = snapshot.data;
//                           return Text(
//                             checkStateTitle(_tran.state, widget.user.id, _tran.idReceiver),
//                             style: GoogleFonts.muli(
//                               textStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           );
//                         }),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         FutureBuilder(
//                             future:
//                             DatabaseService.getUserWithId(_tran.idSender),
//                             builder:
//                                 (BuildContext context, AsyncSnapshot snapshot) {
//                               if (!snapshot.hasData) {
//                                 return SizedBox.shrink();
//                               }
//                               userSender = snapshot.data;
//                               return Text(
//                                 checkStateText(widget.user.id, _tran.idReceiver),
//                                 style: GoogleFonts.muli(
//                                     textStyle: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                     )),
//                               );
//                             }),
//                         SizedBox(height: 5.0),
//                         Text(
//                           DateFormat('dd-MM-yyyy').add_jm().format(
//                             _tran.time.toDate(),
//                           ),
//                           style: GoogleFonts.muli(
//                               textStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w300,
//                               )),
//                           textAlign: TextAlign.right,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 decoration: new BoxDecoration(
//                     border: new Border(
//                         bottom: new BorderSide(color: Colors.grey[300]))),
//               ),
//             );
//           }
//         });
// }
