import 'package:flutter/material.dart';
import 'package:moneygroup/view/addGroupView.dart';
import 'package:moneygroup/view/groupDetailView.dart';
import '../widgets/common_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import '../widgets/common_switch.dart';
import '../widgets/group_item.dart';
import '../utils/uidata.dart';
import 'addGroupView.dart';


class GroupView extends StatefulWidget {
  @override
  GroupViewState createState() => GroupViewState();
}

class GroupViewState extends State<GroupView> {
  

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          title: Text('Groups',style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              onPressed: () => {
                Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return AddGroupView();
                  },
                ),
             )
                            },
              icon: Icon(CupertinoIcons.add_circled),
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "My Groups",
              ),
              Tab(
                text: "All Groups",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.separated(
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
              itemCount: groups.length,
              itemBuilder: (BuildContext context, int index) {
                Group group = groups[index];
                return GroupItem(
                  // dp: group.,
                  name: group.user.name,
                  amount: group.target_amount,
                  title: group.title,
                  time: group.created_time,
                  isOnline: group.user.isOnLine,
                  action: () {
                    selected_index = index;
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (BuildContext context){
                          return GroupDetailView();
                        },
                      ));
                  },
                );
              },
            ),
            ListView.separated(
              padding: EdgeInsets.all(10),
              separatorBuilder: (BuildContext context, int index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 0.5,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Divider(),
                  ),
                );
              },
              itemCount: groups.length,
              itemBuilder: (BuildContext context, int index) {
                Group group = groups[index];
                return GroupItem(
                  // dp: group.,
                  name: group.user.name,
                  amount: group.target_amount,
                  title: group.title,
                  time: group.created_time,
                  isOnline: group.user.isOnLine,
                  action: () {
                    selected_index = index;
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (BuildContext context){
                          return GroupDetailView();
                        },
                      ));
                  },
                );
              },
          ),
        ],
        ),
      ),
    );
  }
}
