import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/donate_item.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';
import '../utils/components.dart';

class TimeValue {
    final int _key;
    final String _value;
    TimeValue(this._key, this._value);
}

class AccountView extends StatefulWidget {
  @override
  DonateViewState createState() => DonateViewState();
}

class DonateViewState extends State<AccountView>  {
  

  bool donated_status = false;

  final _buttonOptions = [
        TimeValue(30,  "30 minutes"),
        TimeValue(60,  "1 hour"),
        TimeValue(120, "2 hours"),
        TimeValue(240, "4 hours"),
        TimeValue(480, "8 hours"),
        TimeValue(720, "12 hours"),
    ];

  int selected_phone_index = 0;
  CustomPopupMenu _selectedMenu = group_menu_list[0];

////////////// ! Main ////////////////////
  @override
  Widget build(BuildContext context) {
    

    return  Scaffold(
      appBar: AppBar(
          title: Text(default_contributes[selected_contribute_index].title ,style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            })),
          
        
      body: Container(
                  height: 150.0,
                  child:
                ListView(
                      padding: EdgeInsets.all(8.0),
                      children: _buttonOptions.map((timeValue) => RadioListTile(
                          groupValue: selected_phone_index,
                          title: Text(timeValue._value),
                          value: timeValue._key,
                          onChanged: (val) {
                              setState(() {
                                  debugPrint('VAL = $val');
                                  selected_phone_index = val;
                              });
                          },
                      )).toList(),
                  ),
                ),
      backgroundColor: Colors.grey,
    );
  }
}