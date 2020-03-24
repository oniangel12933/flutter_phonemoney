import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils/appData.dart';
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

class DonateViewState extends State<DonateView>  {
  

  int selected_phone_index = 0;
  CustomPopupMenu _selectedMenu = group_menu_list[0];
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
                  Navigator.popUntil(context, ModalRoute.withName(UIData.homeRoute));
                  
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            }),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(child: CircularProgressIndicator(),);
                    });
                await new Future.delayed(const Duration(seconds: 1));
                Navigator.pop(context);
                Donate new_donate = Donate(User("", names[random.nextInt(10)], phones[random.nextInt(10)], phones[random.nextInt(10)], random.nextBool()), "${random.nextInt(500)}", "2020-02-15");

                setState(() {                  
                  if (default_donates == null || default_donates.length == 0) {
                      default_donates = [new_donate];
                  }
                  else {
                    default_donates.add(new_donate);
                  }
                });
              },                
              icon: Icon(Icons.refresh),
            ),
            PopupMenuButton<CustomPopupMenu>(
              elevation: 3.2,
              initialValue: app_status_index == 0 ? group_menu_list[1] : member_menu_list[1],
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
        
      body: donateListView(),
      backgroundColor: Colors.grey,
    );
  }

  final new_donate_amount = TextEditingController();

  donateListView() => Column(
    mainAxisAlignment: MainAxisAlignment.end,
    // crossAxisAlignment: CrossAxisAlignment.end,
    children: [                
      Expanded(
        child: 
          (default_donates == null || default_donates.length == 0) ? new Container() : ListView.separated(
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
          itemCount: default_donates.length,
          itemBuilder: (BuildContext context, int index) {
            Donate donate = default_donates[index];
            return DonateItem(
              // dp: group.,
              user: donate.user,
              amount: donate.amount,
              time: "2020-03-25",
              isMe: random.nextBool(),
              action: (){});
          }
      ),
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
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: 200, height: 40,
                  child:borderedTextField(new_donate_amount, true, TextInputType.number, false, "Donate", 5, textFieldNull()), 
                  ), 
                  GestureDetector(
                    onTap: () => {
                      if (new_donate_amount.text == null || new_donate_amount.text == "") {
                          Alert(
                            context: context,
                            style: alertStyle(),
                            type: AlertType.warning,
                            title: "Warning",
                            desc: "Please type donate amount",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Close",
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                                height: 40,
                              )
                            ],
                          ).show()
                      }
                      else {
                        showDialog(context: context, builder: (context) => DonateInView(donateAmount: new_donate_amount.text)),
                      }
                    },
                    child:                  
                          Container(
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
                          SizedBox(width: 10,),
                        ],
                    )),
          color: Colors.yellow,
        )),
          SizedBox(height: 30,)]
  );

  beneficiaryViewAlert() => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 280,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("Beneficiary", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25)),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.content_paste, color: Colors.grey, size: 20,),
                    SizedBox(width: 10),
                    Text("MTN Mobile Money", style: TextStyle(fontSize: 15),),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.grey, size: 20,),
                    SizedBox(width: 10),
                    Text(default_contributes[selected_contribute_index].beneficiary_name, style: TextStyle(fontSize: 15),),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.phone_iphone, color: Colors.grey, size: 20,),
                    SizedBox(width: 10),
                    Text(default_contributes[selected_contribute_index].beneficiary_number, style: TextStyle(fontSize: 15),),
                  ],
                ),
                SizedBox(height: 30),
                roundColorButton("Done", 140,Colors.red, Colors.black, 10, () {})
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
                borderRadius:
                    BorderRadius.circular(12.0)), //this right here
            child: Container(
              height: 340,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Text("Request Settlement", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25)),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.content_paste, color: Colors.grey, size: 20,),
                        SizedBox(width: 10),
                        Text("MTN Mobile Money", style: TextStyle(fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.grey, size: 20,),
                        SizedBox(width: 10),
                        Text(default_contributes[selected_contribute_index].beneficiary_name, style: TextStyle(fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.phone_iphone, color: Colors.grey, size: 20,),
                        SizedBox(width: 10),
                        Text(default_contributes[selected_contribute_index].beneficiary_number, style: TextStyle(fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.paperPlane, color: Colors.grey, size: 20,),
                        SizedBox(width: 10),
                        Text(default_contributes[selected_contribute_index].current_amount, style: TextStyle(fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[     
                        Icon(
                          Icons.warning,
                         color: Colors.grey, size: 15,),                   
                        Text("This end this contribution", style: TextStyle(fontSize: 13),),
                        SizedBox(width: 10),
                        roundColorButton("Confirm", 100,Colors.blue, Colors.white, 10, () 
                          async {                  
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(child: CircularProgressIndicator(),);
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
            borderRadius:
                BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 280,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("Congratulation", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25)),
                SizedBox(height: 30),
                Text("\$${default_contributes[selected_contribute_index].current_amount} paid out to ${default_contributes[selected_contribute_index].beneficiary_name}", style: TextStyle(fontSize: 15),),
                SizedBox(height: 20),
                Text("${default_contributes[selected_contribute_index].beneficiary_number}", style: TextStyle(fontSize: 15),),
                SizedBox(height: 20),
                Text("Fee : \$${double.parse(default_contributes[selected_contribute_index].current_amount) * 0.01}", style: TextStyle(fontSize: 15),),
                SizedBox(height: 30),
                roundColorButton("Done", 140,Colors.red, Colors.black, 10, () {
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

class DonateInView extends StatefulWidget {

  final String donateAmount;
  Function callback;

  DonateInView({this.donateAmount});

  @override
  DonateInViewState createState() => DonateInViewState();
}

class DonateInViewState extends State<DonateInView> {

  int selected_phone_index = 0;
  final phone_numbers = [
        PhoneNumber(1, phones[random.nextInt(10)]),
        PhoneNumber(2, phones[random.nextInt(10)]),
        PhoneNumber(3, phones[random.nextInt(10)]),
    ];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        SizedBox(height: 10),
        Text("Contribute to ${default_contributes[selected_contribute_index].title}", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25),textAlign: TextAlign.center,),
        SizedBox(height: 10),
        new Container(
          height: 42.0,
          width: 120.0,
          color: Colors.green[50],
          child: Center(
            child: Text("  \$${this.widget.donateAmount}   ", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87,fontSize: 17), textAlign: TextAlign.center),
          )                  
        ),
        
        SizedBox(height: 10),
        Text("Fee : \$${double.parse(this.widget.donateAmount) * 0.01}", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54,fontSize: 13),textAlign: TextAlign.center,),
        SizedBox(height: 10),
        Text("Total : \$${double.parse(this.widget.donateAmount) * 1.01}", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54,fontSize: 13),textAlign: TextAlign.center),
        Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: phone_numbers.map((phone_number) => RadioListTile(
                      groupValue: selected_phone_index,
                      title: Text(phone_number.number),
                      value: phone_number.id,
                      onChanged: (val) => {
                          setState(() => {
                              selected_phone_index = val
                          })
                      },
                  )).toList(),
              ),
         ), 
        SizedBox(height: 15),
        GestureDetector(
          onTap: () => {Navigator.pushNamed(context, UIData.accountRoute)},
          child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 30,),                        
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
                    )
                  ),
                SizedBox(width: 10,),
                Text("Add PhoneNumber", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54,fontSize: 15))
              ],
            )
          ),
        SizedBox(height: 20,),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            roundColorButton("Cancel", 140,Colors.red, Colors.black, 10, () => {        
              Navigator.pop(context)}),
            roundColorButton("Donate", 140, Colors.green, Colors.black, 10, () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator(),);
                  });
              await new Future.delayed(const Duration(seconds: 2));                    
              Donate new_donate = Donate(User("", names[random.nextInt(10)], phones[random.nextInt(10)], names[random.nextInt(10)], random.nextBool()), this.widget.donateAmount, "2020-05-05");
              if (default_donates == null || default_donates.length == 0) {
                default_donates = [new_donate];
              }
              else {
                default_donates.add(new_donate);
              }

              Navigator.pop(context);
              Navigator.pop(context);
              showDialog(context: context, builder: (context) => DonateView(donatedStatus: true));
            }
            )
          ]
        )
      ]
    );
  }
}