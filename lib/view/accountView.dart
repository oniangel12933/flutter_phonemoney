import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/donate_item.dart';
import '../widgets/phone_item.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';
import '../utils/components.dart';

List<String> phone_numbers = [
  phones[random.nextInt(10)],
  phones[random.nextInt(10)],
  phones[random.nextInt(10)],
  phones[random.nextInt(10)]
];

class AccountView extends StatefulWidget {
  @override
  AccountViewState createState() => AccountViewState();
}

class AccountViewState extends State<AccountView>  {
  
  final new_phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    return  Scaffold(
      appBar: AppBar(
          title: Text("Account"),
          centerTitle: true,
          backgroundColor: Colors.black,
          ),
          
        
      body: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 15,right: 15,left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
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
                  )
                ),
                SizedBox(width: 30),
                Text(names[random.nextInt(10)], style: TextStyle(fontSize: 25),),
                SizedBox(width: 5),
                IconButton(icon: Icon(Icons.edit,size: 20,color: Colors.grey,), onPressed: (){}),
              ]
            ),
            SizedBox(height: 30),            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.phone, color: Colors.red[200],),
                SizedBox(width: 20),
                Text("Phones", style: TextStyle(color: Colors.black87, fontSize: 20),textAlign: TextAlign.left,)
              ],
            ),
            SizedBox(height:10),
            GestureDetector(
              onTap: () => {addPhoneAlert()},
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 3,),                        
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
            SizedBox(height:10),    
            Expanded(child: 
              ListView.separated(
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
                itemCount: phone_numbers.length,
                itemBuilder: (BuildContext context, int index) {
                  String phone = phone_numbers[index];
                  return PhoneItem(
                    // dp: group.,
                    phone_number: phone,
                    account_created_status: random.nextBool(),
                  );
                },
              )  
            ),
                  
          ]
        ),
      )
    );
  }

  addPhoneAlert() => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("Add Phone Number", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25)),
                SizedBox(height: 30),
                borderedTextField(new_phone, true, TextInputType.number, false, "Phone Number", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  roundColorButton("Cancel", 140,Colors.red, Colors.black, 10, () => {
                    new_phone.text = "",          
                    Navigator.pop(context)}),
                  roundColorButton("Create", 140, Colors.green, Colors.black, 10, () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator(),);
                        });
                    await new Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      phone_numbers.add(new_phone.text);
                    });
                    new_phone.text = "";   
                    Navigator.pop(context);
                    Navigator.pop(context);
                  })
                ],)
              ],
            ),
          ),
        ),
      );
    });
}