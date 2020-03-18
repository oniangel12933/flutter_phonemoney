import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/common_switch.dart';
import '../utils/uidata.dart';
import '../utils/components.dart';


class AddGroupView extends StatelessWidget {

  final title = TextEditingController();
  final amount = TextEditingController();
  final description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Create New Group',style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
      backgroundColor: Colors.grey[100],
      body: _body(context)
    );
  }

  _body(BuildContext context) => SingleChildScrollView (
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(height: 50),
        loginTextField(title, false, TextInputType.emailAddress, "Title"),         
        SizedBox(height: 30),
        loginTextField(amount, false, TextInputType.number, "Amount"),
        SizedBox(height: 30),
        new Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: new TextField( 
            controller: description,
            maxLines: null,
            decoration: new InputDecoration(
              // hintText: 'Type here about new group',
              labelText: 'Description',
              labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              border: const OutlineInputBorder(),
          )
        )),
        SizedBox(height: 50),
        roundColorButton("Create", Colors.grey[200], Colors.black, 30, () => {createGroup(context)}),
        ],
    )
  );

  Function createGroup(BuildContext context) {
    groups.add(Group(
      title.text,
      description.text,
      amount.text,
      "${random.nextInt(300)}",
      "${random.nextInt(50)}min ago",
      users[random.nextInt(10)],
    ));

    Alert(
      context: context,
      style: alertStyle(),
      type: AlertType.success,
      title: UIData.appName,
      desc: "Successfully created new group",
      buttons: [
        DialogButton(
          child: Text(
            "DONE",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () => {
            Navigator.pop(context),
            Navigator.pop(context),},
          width: 120,
          height: 40,
        )
      ],
    ).show();
  }
}
