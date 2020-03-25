import 'package:flutter/material.dart';
import '../utils/appData.dart';
import '../utils/uiData.dart';


class ReportItem extends StatefulWidget {

  final String name;
  final ReportType type;
  final String optional_val;
  final String created_time;
  final String isOnLine;

  ReportItem({
    Key key,
    // @required this.dp,
    @required this.name,
    @required this.type,
    @required this.optional_val,
    @required this.created_time,
    @required this.isOnLine
  }) : super(key: key);

  @override
  _ReportItemState createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {
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
                      color: widget.isOnLine == "1"
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
        subtitle: Text(widget.optional_val),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 5),
            widget.type != ReportType.contribute_end
                ?SizedBox()
                :Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 13,
                minHeight: 11,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                child:Text(
                  "Ended",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${widget.created_time}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
