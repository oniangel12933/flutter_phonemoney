import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import '../widgets/common_switch.dart';
import '../widgets/friend_item.dart';
import '../utils/uidata.dart';
import 'addFriendView.dart';


class FriendView extends StatefulWidget {
  @override
  FriendViewState createState() => FriendViewState();
}

class FriendViewState extends State<FriendView> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Friends',style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              onPressed: () => {
                Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return AddFriendView();
                  },
                )),
              },
              icon: Icon(CupertinoIcons.person_add),
            ),
          ],
        ),
        body: ListView.separated(
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
                User friend = users[index];
                return FriendItem(
                  // dp: friend['dp'],
                  name: friend.name,
                  phoneNumber: friend.phoneNumber,
                  isOnline: friend.isOnLine,
                  visableInvite: false,
                  action: () {},
                );
              },
              
        )
  
    );
  }
}
