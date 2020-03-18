/*
* Author: Aslan
* 23.02.2019
* */
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneygroup/utils/uidata.dart';
import 'package:moneygroup/view/addGroupView.dart';
import 'package:moneygroup/view/friendView.dart';
import 'package:moneygroup/view/groupView.dart';
import 'package:moneygroup/view/settingView.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: <String, WidgetBuilder>{
        UIData.groupRoute: (BuildContext context) => GroupView(),
        UIData.groupAddRoute: (BuildContext context) => AddGroupView(),
        UIData.friendRoute: (BuildContext context) => FriendView(),
        UIData.friendAddRoute: (BuildContext context) => FriendView(),
        UIData.settingRoute: (BuildContext context) => SettingView(),
      },
      
      home: body(),
    );
  }

body() =>  WillPopScope(
      // Prevent swipe popping of this page. Use explicit exit buttons only.
      onWillPop: () => Future<bool>.value(true),
      
      child: DefaultTextStyle(
        
        style: CupertinoTheme.of(context).textTheme.textStyle,
        child: CupertinoTabScaffold(
          
          tabBar: CupertinoTabBar(
            currentIndex: UIData.home_selected_index,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                title: Text('Groups'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.group),
                title: Text('Friends'),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                title: Text('Setting'),
              ),
            ],
            onTap: (index) {
              print (index);
              setState(() {
                UIData.home_selected_index = index;
              });
            },
          ),
          tabBuilder: (BuildContext context, int index) {
            assert(index >= 0 && index <= 3);
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (BuildContext context) => GroupView(),
                  defaultTitle: 'Group',
                );
                break;
              case 1:
                return CupertinoTabView(
                  builder: (BuildContext context) => FriendView(),
                  defaultTitle: 'Friends',
                );
                break;
              case 2:
                return CupertinoTabView(
                  builder: (BuildContext context) => SettingView(),
                  defaultTitle: 'Setting',
                );
                break;
                break;
            }
            return null;
          },
          
        ),
      ),
    );

}