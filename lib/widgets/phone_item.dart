import 'package:flutter/material.dart';


class PhoneItem extends StatefulWidget {

  final String phone_number;
  final bool account_created_status;

  PhoneItem({
    Key key,
    // @required this.dp,
    @required this.phone_number,
    @required this.account_created_status,
  }) : super(key: key);

  @override
  _PhoneItemState createState() => _PhoneItemState();
}

class _PhoneItemState extends State<PhoneItem> {
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.phone_iphone, color: Colors.grey, size: 15),
        SizedBox(width: 10),
        Text(widget.phone_number, style: TextStyle(fontSize: 13, color: Colors.black87),),
        SizedBox(width: 10),
        widget.account_created_status ? Container(
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
                  "login Number",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ) : Container(),
      ],
    );
  }
}
