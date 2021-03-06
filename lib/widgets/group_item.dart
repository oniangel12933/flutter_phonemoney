import 'package:flutter/material.dart';
import 'package:moneygroup/utils/uidata.dart';


class GroupItem extends StatefulWidget {

  final String name;
  final String description;
  final String number_of_members;
  final bool isOnLine;
  final Function action;

  GroupItem({
    Key key,
    // @required this.dp,
    @required this.name,
    @required this.description,
    @required this.number_of_members,
    @required this.isOnLine,
    @required this.action,
  }) : super(key: key);

  @override
  _GroupItemState createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
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
          "${widget.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${widget.description}"),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 5),
            widget.number_of_members == 0
                ?SizedBox()
                :Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 11,
                minHeight: 11,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                child:Text(
                  "${widget.number_of_members}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
          ],
        ),
        onTap: widget.action
      ),
    );
  }
}
