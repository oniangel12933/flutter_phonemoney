import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils/appData.dart';
import '../utils/functions.dart';
import '../utils/components.dart';
import '../utils/uiData.dart';
import '../widgets/donate_item.dart';

class PhoneNumber {
  final int id;
  final String number;
  PhoneNumber(this.id, this.number);
}

class DonateView extends StatefulWidget {
  final bool donatedStatus;
  Function callback;
  DonateView({
    Key key,
    this.donatedStatus,
    // this.callback,
  }) : super(key: key);

  // DonateViewState({this.donatedStatus});

  @override
  DonateViewState createState() => DonateViewState();
}

class DonateViewState extends State<DonateView> {
  int number_of_donates = 0;
  int total_donates = 0;
  bool add_donate_status = false;

  int selected_phone_index = 0;
  List<PhoneNumber> phone_numbers = [];
  CustomPopupMenu _selectedMenu = group_menu_list[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int index = 0;
    phone_numbers.add(PhoneNumber(index, AppData.user_info.mainPhone));
    index++;
    if (AppData.user_info.otherPhones != "") {
      final other_phones = AppData.user_info.otherPhones.split(",");
      other_phones.map((i) {
        final phone = PhoneNumber(index, i);
        phone_numbers.add(PhoneNumber(index, i));
        index++;
      }).toList();
    }

    number_of_donates = donates == null ? 0 : donates.length;
    if (donates != null) {
      donates.map((i) {
        total_donates += int.parse(i.donated_amount);
      }).toList();
    }
  }

  bool isMeCheck(String number) {
    if (phones.contains(number)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    void _menuSelected(CustomPopupMenu choice) {
      setState(() {
        _selectedMenu = choice;
        switch (_selectedMenu.title) {
          case UIData.menuViewBeneficiary:
            beneficiaryViewAlert();
            break;

          default:
            settleRequestAlert();
            break;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(contributes[selected_contribute_index].title,
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              Text(
                  "\$${total_donates} in ${donates == null ? 0 : donates.length} payments",
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ]),
        // centerTitle: true,
        backgroundColor: Colors.black,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              donates = [];
              Navigator.popUntil(
                  context, ModalRoute.withName(UIData.homeRoute));
            },
            // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              var params = {
                'contribute_id': contributes[selected_contribute_index].id
              };

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });

              postApiCall(params, AppData.baseURL + AppData.reloadApi).then(
                  (value) {
                // Run extra code here

                if (value['status'] as bool) {
                  final data = value['data'] as Map<String, dynamic>;
                  if (data['donates'] != null) {
                    donates = [];
                    (data['donates'] as List).map((i) {
                      final donate = Donate.fromJson(i as Map<String, dynamic>);
                      if (groups == null) {
                        donates = [donate];
                      } else {
                        donates.add(donate);
                      }
                    }).toList();

                    donates.sort(
                        (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                  }
                }
                Navigator.pop(context);
                setState(() {});
              }, onError: (error) {
                print(error);
              });
            },
            icon: Icon(Icons.refresh),
          ),
          PopupMenuButton<CustomPopupMenu>(
            elevation: 3.2,
            initialValue: app_status_index == 0
                ? group_menu_list[1]
                : member_menu_list[1],
            onCanceled: () {
              print('You have not chossed anything');
            },
            tooltip: 'This is tooltip',
            onSelected: _menuSelected,
            itemBuilder: (BuildContext context) {
              return donate_menu_list.map((CustomPopupMenu choice) {
                return PopupMenuItem<CustomPopupMenu>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Stack(children: [
        donateListView(),
        add_donate_status ? addDonateView() : new Container()
      ]),
      backgroundColor: Colors.grey,
    );
  }

  final new_donate_amount = TextEditingController();
  bool new_donate_amount_status = true;

  addDonateView() => GestureDetector(
      onTap: () {
        // new_contribute_title.text = "";
        // new_contribute_beneficiary_phone_status = true;
        add_donate_status = false;
        setState(() {});
      },
      child: Container(
          color: Colors.black87.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
          child: Center(
              child: SingleChildScrollView(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            color: Colors.white,
                            width: 300,
                            height: 500,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "Contribute to ${contributes[selected_contribute_index].title}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                            fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10),
                                      new Container(
                                          height: 42.0,
                                          width: 120.0,
                                          color: Colors.green[50],
                                          child: Center(
                                            child: Text(
                                                "  \$${new_donate_amount.text}   ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                    fontSize: 17),
                                                textAlign: TextAlign.center),
                                          )),
                                      SizedBox(height: 10),
                                      Text(
                                        "Fee : \$${double.parse(new_donate_amount.text) * 0.01}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                            fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          "Total : \$${double.parse(new_donate_amount.text) * 1.01}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                              fontSize: 13),
                                          textAlign: TextAlign.center),
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.maxFinite,
                                        child: ListView(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(8.0),
                                          children: phone_numbers
                                              .map((phone_number) =>
                                                  RadioListTile(
                                                    groupValue:
                                                        selected_phone_index,
                                                    title: Text(
                                                        phone_number.number),
                                                    value: phone_number.id,
                                                    onChanged: (val) => {
                                                      setState(() => {
                                                            selected_phone_index =
                                                                val
                                                          })
                                                    },
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      GestureDetector(
                                          onTap: () => {
                                                Navigator.pushNamed(context,
                                                    UIData.accountRoute)
                                              },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Container(
                                                  child: Icon(
                                                      Icons.add_circle_outline,
                                                      color: Colors.grey),
                                                  decoration: new BoxDecoration(
                                                    color: const Color(
                                                        0xFFFFFFFF), // border color
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                      fontSize: 15))
                                            ],
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            roundColorButton(
                                                "Cancel",
                                                140,
                                                Colors.red,
                                                Colors.black,
                                                10,
                                                () => {
                                                      new_donate_amount.text =
                                                          "",
                                                      add_donate_status = false,
                                                      setState(() {})
                                                    }),
                                            roundColorButton(
                                                "Donate",
                                                140,
                                                Colors.green,
                                                Colors.black,
                                                10, () async {
                                              final formatter = new DateFormat(
                                                  'yyyy-MM-dd-hh-mm');
                                              final current_time = formatter
                                                  .format(new DateTime.now());
                                              var params = {
                                                'contribute_id': contributes[
                                                        selected_contribute_index]
                                                    .id,
                                                'donated_user_id':
                                                    AppData.user_info.id,
                                                'donated_member_name':
                                                    AppData.user_info.name,
                                                'donated_member_phone':
                                                    phone_numbers[
                                                            selected_phone_index]
                                                        .number,
                                                'donated_time': current_time,
                                                'donated_amount':
                                                    new_donate_amount.text
                                              };

                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  });
                                              postApiCall(
                                                      params,
                                                      AppData.baseURL +
                                                          AppData.addDonateApi)
                                                  .then((value) {
                                                // Run extra code here

                                                if (value['status'] as bool) {
                                                  final data = value['data']
                                                      as Map<String, dynamic>;
                                                  final donate =
                                                      Donate.fromJson(
                                                          data['donate'] as Map<
                                                              String, dynamic>);
                                                  if (donate == null) {
                                                    donates = [donate];
                                                  } else {
                                                    donates.add(donate);
                                                  }

                                                  Navigator.pop(context);
                                                  total_donates += int.parse(
                                                      new_donate_amount.text);
                                                  contributes[
                                                          selected_contribute_index] =
                                                      Contribute.fromJson(
                                                          data['contribute']
                                                              as Map<String,
                                                                  dynamic>);
                                                  add_donate_status = false;
                                                  showAlert(
                                                      context,
                                                      AlertType.success,
                                                      value['message']
                                                          as String,
                                                      "Close",
                                                      () => {
                                                            Navigator.pop(
                                                                context),
                                                            setState(() {})
                                                          });
                                                } else {
                                                  Navigator.pop(context);
                                                  showAlert(
                                                      context,
                                                      AlertType.error,
                                                      value['message']
                                                          as String,
                                                      "Close",
                                                      () => {
                                                            Navigator.pop(
                                                                context)
                                                          });
                                                }
                                              }, onError: (error) {
                                                print(error);
                                              });
                                            })
                                          ]),
                                    ]))),
                      ))))));

  donateListView() => Column(mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: (donates == null || donates.length == 0)
                  ? new Container()
                  : ListView.separated(
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
                      itemCount: donates.length,
                      itemBuilder: (BuildContext context, int index) {
                        Donate donate = donates[index];
                        return DonateItem(
                            // dp: group.,
                            name: donate.donated_member_name,
                            phone: donate.donated_member_phone,
                            amount: donate.donated_amount,
                            time: donate.donated_time,
                            isMe: donate.donated_user_id == AppData.user_info.id
                                ? true
                                : false,
                            action: () {});
                      }),
            ),
            SizedBox(height: 15),
            Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30),
                width: 350,
                child: RaisedButton(
                  padding: EdgeInsets.all(5.0),
                  shape: StadiumBorder(),
                  disabledColor: Colors.brown,
                  child: GestureDetector(
                      // onTap: () => {createDonateAlert()},
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: borderedTextField(
                            new_donate_amount,
                            new_donate_amount_status,
                            TextInputType.numberWithOptions(signed: true),
                            false,
                            "Donate",
                            5,
                            textFieldNull()),
                      ),
                      GestureDetector(
                          onTap: () => {
                                if (new_donate_amount.text == '')
                                  {new_donate_amount_status = false}
                                else
                                  {new_donate_amount_status = true},
                                if (new_donate_amount_status)
                                  {add_donate_status = true},
                                setState(() {}),
                              },
                          child: Container(
                            child: Icon(FontAwesomeIcons.paperPlane,
                                color: Colors.lightBlue),
                            decoration: new BoxDecoration(
                              color: Colors.transparent, // border color
                              shape: BoxShape.circle,
                              border: new Border.all(
                                width: 2.0,
                                color: Colors.grey[200],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )),
                  color: Colors.yellow,
                )),
            SizedBox(
              height: 30,
            )
          ]);

  beneficiaryViewAlert() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Beneficiary",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          fontSize: 25)),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.content_paste,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "MTN Mobile Money",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        contributes[selected_contribute_index].beneficiary_name,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.phone_iphone,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        contributes[selected_contribute_index]
                            .beneficiary_phone,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  roundColorButton(
                      "Done", 140, Colors.red, Colors.black, 10, () {})
                ],
              ),
            ),
          ),
        );
      });

  settleRequestAlert() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: 340,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Request Settlement",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          fontSize: 25)),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.content_paste,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "MTN Mobile Money",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        contributes[selected_contribute_index].beneficiary_name,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.phone_iphone,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        contributes[selected_contribute_index]
                            .beneficiary_phone,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        contributes[selected_contribute_index].current_amount,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.warning,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Text(
                        "This end this contribution",
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(width: 10),
                      roundColorButton(
                          "Confirm", 100, Colors.blue, Colors.white, 10,
                          () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        await new Future.delayed(const Duration(seconds: 2));
                        Navigator.pop(context);
                        Navigator.pop(context);
                        beneficiaryEndedAlert();
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });

  beneficiaryEndedAlert() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Congratulation",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          fontSize: 25)),
                  SizedBox(height: 30),
                  Text(
                    "\$${contributes[selected_contribute_index].current_amount} paid out to ${contributes[selected_contribute_index].beneficiary_name}",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${contributes[selected_contribute_index].beneficiary_phone}",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Fee : \$${double.parse(contributes[selected_contribute_index].current_amount) * 0.01}",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 30),
                  roundColorButton("Done", 140, Colors.red, Colors.black, 10,
                      () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  })
                ],
              ),
            ),
          ),
        );
      });
}

// typedef void DonateInViewCallback(String result);
