import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneygroup/view/donateView%20.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/donate_item.dart';
import '../widgets/phone_item.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';
import '../utils/components.dart';
import '../utils/functions.dart';


class AccountView extends StatefulWidget {

DonateViewState parent;
  @override
  AccountViewState createState() => AccountViewState(this.parent);
}

class AccountViewState extends State<AccountView> {
  final new_phone = TextEditingController();
  bool new_phone_status = true;
  bool add_phone_status = false;
DonateViewState parent;
AccountViewState(this.parent);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Account"),
          centerTitle: true,
          leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
          backgroundColor: Colors.black,
        ),
        body: Stack(children: <Widget>[
          body(context),
          add_phone_status ? addPhoneView() : new Container()
        ]));
  }

  body(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 40, bottom: 15, right: 15, left: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                        child: new CircleAvatar(
                          backgroundImage: AssetImage(
                            UIData.default_profile,
                          ),
                          radius: 40,
                        ),
                        decoration: new BoxDecoration(
                          color: const Color(0xFFFFFFFF), // border color
                          shape: BoxShape.circle,
                          border: new Border.all(
                            width: 3.0,
                            color: Colors.red[100],
                          ),
                        )),
                    SizedBox(width: 30),
                    Text(
                      AppData.user_info.name,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(width: 5),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onPressed: () {}),
                  ]),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.phone,
                    color: Colors.red[200],
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Phones",
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () => {add_phone_status = true, setState(() {})},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                          child: Icon(Icons.add_circle_outline,
                              color: Colors.grey),
                          decoration: new BoxDecoration(
                            color: const Color(0xFFFFFFFF), // border color
                            shape: BoxShape.circle,
                            border: new Border.all(
                              width: 2.0,
                              color: Colors.grey[200],
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Add PhoneNumber",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              fontSize: 15))
                    ],
                  )),
              SizedBox(height: 10),
              Expanded(
                  child: ListView.separated(
                padding: EdgeInsets.all(10),
                separatorBuilder: (BuildContext context, int index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Divider(),
                    ),
                  );
                },
                itemCount: phoneNumbers.length,
                itemBuilder: (BuildContext context, int index) {
                  String phone = phoneNumbers[index].number;
                  return PhoneItem(
                      // dp: group.,
                      phone_number: phone,
                      account_created_status:
                          phone == AppData.user_info.mainPhone ? true : false);
                },
              )),
            ]),
      );

  addPhoneView() => GestureDetector(
      onTap: () {
        new_phone.text = "";
        new_phone_status = true;
        add_phone_status = false;
        setState(() {});
      },
      child: Container(
          color: Colors.black87.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.white,
                      width: 350,
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add Phone Number",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    fontSize: 25)),
                            SizedBox(height: 30),
                            borderedTextField(
                                new_phone,
                                new_phone_status,
                                TextInputType.number,
                                false,
                                "Phone Number",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                roundColorButton(
                                    "Cancel",
                                    140,
                                    Colors.red,
                                    Colors.black,
                                    10,
                                    () => {
                                          new_phone.text = "",
                                          new_phone_status = true,
                                          add_phone_status = false,
                                          setState(() {})
                                        }),
                                roundColorButton("Add", 140, Colors.green,
                                    Colors.black, 10, () async {
                                  if (new_phone.text == '') {
                                    new_phone_status = false;
                                  } else {
                                    new_phone_status = true;
                                  }
                                  setState(() {});
                                  if (new_phone_status) {
                                    var params = {
                                      'user_id': AppData.user_info.id,
                                      'phone_number': new_phone.text
                                    };

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        });

                                    postApiCall(
                                            params,
                                            AppData.baseURL +
                                                AppData.addPhoneApi)
                                        .then((value) {
                                      // Run extra code here

                                      if (value['status'] as bool) {
                                        final data = value['data']
                                            as Map<String, dynamic>;
                                        AppData.user_info = User.fromJson(
                                            data['profile']
                                                as Map<String, dynamic>);

                                        Navigator.pop(context);
                                        showAlert(
                                            context,
                                            AlertType.success,
                                            value['message'] as String,
                                            "Close",
                                            () => {
                                              phoneNumbers.add(PhoneNumber(phoneNumbers.length, new_phone.text)),
                                                  Navigator.pop(context),
                                                  new_phone.text = "",
                                                  new_phone_status = true,
                                                  add_phone_status = false,
                                                  setState(() {})
                                                });
                                      } else {
                                        Navigator.pop(context);
                                        showAlert(
                                            context,
                                            AlertType.error,
                                            value['message'] as String,
                                            "Close",
                                            () => {
                                                  Navigator.pop(context),
                                                  new_phone.text = "",
                                                  new_phone_status = true,
                                                  add_phone_status = false,
                                                  setState(() {})
                                                });
                                      }
                                    }, onError: (error) {
                                      print(error);
                                    });
                                  }
                                })
                              ],
                            )
                          ],
                        ),
                      ),
                    ))),
          )));
}
