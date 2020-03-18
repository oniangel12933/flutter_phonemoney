import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/common_switch.dart';
import '../utils/uidata.dart';
import '../utils/components.dart';
import '../widgets/friend_item.dart';


// Channge2
class AddFriendView extends StatefulWidget {
  @override
  AddFriendViewState createState() => AddFriendViewState();
}

class AddFriendViewState extends State<AddFriendView> {

  String search_text;
  var filtered_users = users;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          title: Text('Create New Group',style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: bodyData(context)
        ),
      );
  }

  Widget bodyData(BuildContext context) => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1
              searchCard(),
              SizedBox(height: 10),
              userList(),
            ],
          ),
        ),
      );

  Widget searchCard() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      // elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    search_text = text;
                  });   
                                 
                },
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Find users"),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget userList() => ListView.separated(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    padding: EdgeInsets.all(10),
    separatorBuilder: (BuildContext context, int index) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 1,
          width: MediaQuery.of(context).size.width / 1.3,
          child: Divider(),
        ),
      );
    },
    itemCount: groups.length,
    itemBuilder: (BuildContext context, int index) {

      return  (search_text == '' || search_text ==  null || users[index].name.toLowerCase().contains(search_text.toLowerCase()) || users[index].phoneNumber.toLowerCase().contains(search_text.toLowerCase())) ? FriendItem(
        // dp: friend['dp'],
        name: users[index].name,
        phoneNumber: users[index].phoneNumber,
        isOnline: users[index].isOnLine,
        visableInvite: true,
        action: () {
          Alert(
            context: context,
            style: alertStyle(),
            type: AlertType.success,
            title: UIData.appName,
            desc: "You sent invitation request to ${users[index].name}",
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
          ).show();
        },
      ) : new Container();
    },
  );

}
