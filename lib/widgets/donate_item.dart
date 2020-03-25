import 'package:flutter/material.dart';
import 'package:moneygroup/utils/uiData.dart';
import 'package:moneygroup/utils/appData.dart';

class DonateItem extends StatefulWidget {
  final String name;
  final String phone;
  final String amount;
  final String time;
  final bool isMe;
  final Function action;

  DonateItem({
    Key key,
    // @required this.dp,
    @required this.name,
    @required this.phone,
    @required this.amount,
    @required this.time,
    @required this.isMe,
    @required this.action,
  }) : super(key: key);

  @override
  _DonateItemState createState() => _DonateItemState();
}

class _DonateItemState extends State<DonateItem> {
  @override
  Widget build(BuildContext context) {
    final bg = widget.isMe ? Colors.green[50] : Colors.red[50];
    final align =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = widget.isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            topRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(5.0),
          );

    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.only(
              left: 20, right: 20, top: 10, bottom: 10), //.all(10.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3,
            minWidth: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5),
              Text(
                "${widget.phone} - ${widget.name}",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: widget.isMe ? TextAlign.right : TextAlign.left,
              ),
              SizedBox(height: 5),
              RichText(
                textAlign: widget.isMe ? TextAlign.right : TextAlign.left,
                text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: "${widget.name} contributed"),
                    new TextSpan(
                        text: '  \$${widget.amount}',
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
        Padding(
          padding: widget.isMe
              ? EdgeInsets.only(
                  right: 10,
                  bottom: 10.0,
                )
              : EdgeInsets.only(
                  left: 10,
                  bottom: 10.0,
                ),
          child: Text(
            widget.time,
            style: TextStyle(
              color: Colors.black,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }
}
