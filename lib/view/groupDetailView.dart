import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/common_switch.dart';
import '../utils/uidata.dart';
import '../utils/components.dart';


class GroupDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "Group Detail",
      showDrawer: false,
      showFAB: false,
      backGroundColor: Colors.grey.shade300,
      bodyData: bodyData(context),
      actionFirstIcon: null,
    );
  }

  final group = groups[selected_index];

  Widget bodyData(BuildContext context) => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 50,),
                Row(children: <Widget>[
                  Text(
                    "Title :",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black38, fontSize: 17),
                  ),
                  SizedBox(width: 10),
                  Text(
                    group.title,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
                  ),
                ],),                
                SizedBox(height: 5),
                Text(
                  "created by ${group.user.name}  ${group.created_time}",
                  style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38, fontSize: 13),
                ),
                SizedBox(height: 20,),
                Row(children: <Widget>[
                  Text(
                    "Amount :",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black38, fontSize: 17),
                  ),
                  SizedBox(width: 10),
                  Text(
                    group.target_amount,
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
                  ),
                ],), 
                SizedBox(height: 20),
                Text(
                  "Description :",
                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black38, fontSize: 17),
                ),
                SizedBox(height: 10),
                Text(
                  group.description,
                  style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 15),
                ),
                SizedBox(height: 50,),
                roundColorButton("Join", Colors.grey[200], Colors.black, 30, () => {join(context)}),
                
              ],
            ),
          )
          
        ),
      );

  Function join(BuildContext context) {
    Alert(
        context: context,
        title: "Thanks for join",
        content: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Type your amount',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {

              Navigator.pop(context),
              Alert(
                context: context,
                style: alertStyle(),
                type: AlertType.success,
                title: UIData.appName,
                desc: "Successfully joined to ${group.title}",
                buttons: [
                  DialogButton(
                    child: Text(
                      "DONE",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () => {Navigator.pop(context)},
                    width: 120,
                    height: 40,
                  )
                ],
              ).show()
            },
            child: Text(
              "Join",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
