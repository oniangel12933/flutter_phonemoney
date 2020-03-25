import 'package:flutter/material.dart';
import '../utils/uidata.dart';

class SettingView extends StatelessWidget {
  Widget bodyData() => SingleChildScrollView(
        child: Theme(
          data: ThemeData(fontFamily: UIData.ralewayFont),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //1
              SizedBox(
                height: 50,
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                        title: Text("Change Name"),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          print("Name +++++");
                        }),
                    ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        title: Text("Change Phone Number"),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          print("Phone +++++");
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.grey,
                        ),
                        title: Text("Log Out"),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          print("Out +++++");
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: bodyData());
  }
}
