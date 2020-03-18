import 'package:flutter/material.dart';
import 'package:moneygroup/utils/uidata.dart';
// import 'package:social_app_ui/screens/conversation.dart';
import '../view/signupView.dart';


class FriendItem extends StatefulWidget {

  // final String dp;
  final String name;
  final String phoneNumber;
  final bool isOnline;
  final bool visableInvite;
  final Function action; 

  FriendItem({
    Key key,
    // @required this.dp,
    @required this.name,
    @required this.phoneNumber,
    @required this.isOnline,
    @required this.visableInvite,
    @required this.action,
  }) : super(key: key);

  @override
  _FriendItemState createState() => _FriendItemState();
}

class _FriendItemState extends State<FriendItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[            
            new Container(
              child: new CircleAvatar(
                backgroundImage: AssetImage(
                  UIData.default_profile,
                ),
                radius: 20,
              ),
              decoration: new BoxDecoration(
                color: const Color(0xFFFFFFFF), // border color
                shape: BoxShape.circle,
                border: new Border.all(
                  width: 2.0,
                  color: Colors.grey[200],
                ),
              )
            ),
            

            Positioned(
              bottom: 0.0,
              left: 4.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 11,
                width: 11,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.isOnline
                          ?Colors.greenAccent
                          :Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 7,
                    width: 7,
                  ),
                ),
              ),
            ),

          ],
        ),

        title: Text(
          "${widget.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${widget.phoneNumber}"),
        trailing: widget.visableInvite ? FlatButton(
                child: Text(
                  "Invite",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.green[300],
                onPressed: widget.action,
              ) : FlatButton(),
        onTap: widget.action
      ),
    );
  }
}
