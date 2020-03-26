import 'package:flutter/material.dart';
import 'package:moneygroup/utils/uidata.dart';
import 'package:moneygroup/utils/functions.dart';
// import 'package:social_app_ui/screens/conversation.dart';
import '../view/signupView.dart';


class ContributeItem extends StatefulWidget {

  final String title;
  final String description;
  final String created_time;
  final String current_amount;
  final bool isOnLine;
  final Function action;

  ContributeItem({
    Key key,
    // @required this.dp,
    @required this.title,
    @required this.description,
    @required this.created_time,
    @required this.current_amount,
    @required this.isOnLine,
    @required this.action,
  }) : super(key: key);

  @override
  _ContributeItemState createState() => _ContributeItemState();
}

class _ContributeItemState extends State<ContributeItem> {
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
                      color: widget.isOnLine
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
          "${widget.title}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${widget.description}"),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 5),
            Text(
              getTime(widget.created_time),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 5),
            Text(
              "Total \$${widget.current_amount}",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
                textAlign: TextAlign.right,
              ),
            
          ],
        ),
        onTap: widget.action
      ),
    );
  }
}
