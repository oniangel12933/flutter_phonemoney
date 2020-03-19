import 'package:flutter/material.dart';
import 'package:moneygroup/widgets/report_item.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/group_item.dart';
import '../widgets/member_item.dart';
import '../widgets/contribute_item.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';
import '../utils/components.dart';



class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView>  {
  

  int _currentIndex = 0;
  CustomPopupMenu _selectedMenu = group_menu_list[0];

////////////// ! Main ////////////////////
  @override
  Widget build(BuildContext context) {
    
    void _menuSelected(CustomPopupMenu choice) {
      setState(() {
        _selectedMenu = choice;
        switch (_selectedMenu.title) {
          case "New Group": 
            createGroupAlert();
            break;
          case "New Contribute":
            createContributeAlert();
            break;

          case "New Member":
            createMemberAlert();
            break;

          default:
            break;
        }
      });
    }


    return Scaffold(
      appBar: AppBar(
          title: Text((app_status_index == 0) ? 'My Contributes' : default_groups[selected_group_index].title ,style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: app_status_index != 0 ? Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    app_status_index = (app_status_index > 0) ? app_status_index -= 1 : 0;
                    print(app_status_index);
                  });
                  
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            }) : Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(null),
                onPressed: () {
                  app_status_index = (app_status_index != 0) ? app_status_index-- : 0;
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(child: CircularProgressIndicator(),);
                    });
                await new Future.delayed(const Duration(seconds: 2));
                Navigator.pop(context);
                
                setState(() {
                  
                  if (app_status_index == 0) {
                    Group new_group = Group("", names[random.nextInt(10)], details[random.nextInt(10)], "1", "2020.03.25", User("0", "SSS", "123123", true), [User("0", "SSS", "123123",true)], null);
                    if (default_groups == null || default_groups.length == 0) {
                        default_groups = [new_group];
                    }
                    else {
                      default_groups.add(new_group);
                    }

                    Report new_report = Report("", ReportType.contribute_end, names[random.nextInt(10)], "2020-03-25", User("", names[random.nextInt(10)], phones[random.nextInt(10)], true));
                    if (default_reports == null || default_reports.length == 0) {
                        default_reports = [new_report];
                    }
                    else {
                      default_reports.add(new_report);
                    }
                  }
                  else {
                    Contribute new_contribute = Contribute("", names[random.nextInt(10)], details[random.nextInt(10)], "${random.nextInt(900)}", "0", "2020-03-25", "2020-03-29", new_contribute_beneficiary_name.text, new_contribute_beneficiary_number.text, User("", names[random.nextInt(10)], phones[random.nextInt(10)], true));
                    if (default_contributes == null || default_contributes.length == 0) {
                        default_contributes = [new_contribute];
                    }
                    else {
                      default_contributes.add(new_contribute);
                    }

                    User new_member = User("", names[random.nextInt(10)], phones[random.nextInt(10)], random.nextBool());
                    default_groups[selected_group_index].members.add(new_member);
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
                return app_status_index == 0 ? group_menu_list.map((CustomPopupMenu choice) {
                  return PopupMenuItem<CustomPopupMenu>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList() : member_menu_list.map((CustomPopupMenu choice) {
                  return PopupMenuItem<CustomPopupMenu>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            )
          ],
          
        ),
        
        // endDrawer: groupDrawer(),
      body: new DefaultTabController(        
        length: 2,
        child: Scaffold(
          appBar: AppBar(  
            backgroundColor: Colors.black,        
            title: TabBar(
              labelColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  text: (app_status_index == 0) ? "Groups" : "Group`s Contributions",
                ),
                Tab(
                  text: (app_status_index == 0) ? "Reports" : "Members",
                ),
              ],
            ),
          ),
        
        body: TabBarView(
          children: <Widget>[
            app_status_index == 0 ? (default_groups == null || default_groups.length == 0 ? nonGroupView():groupListView()) : (default_contributes == null || default_contributes.length == 0 ? nonContributeView():contributeListView()),
            app_status_index == 0 ? (default_reports == null || default_reports.length == 0 ? nonReportView():reportListView()) : (memberListView()),    
          
        ],
        ),
      ),
    ));
  }


////////////// ! Group ////////////////////

  nonGroupView() => Center(
      child: new Padding(
            padding: new EdgeInsets.only(top: 50, bottom: 50),
            child: Column(                  
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.png',height: 100,width: 100,),
                SizedBox(height: 10),
                Text(
                  "You don`t have any groups yet",
                  style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 15),
                ),
                SizedBox(height: 10),
                clickLable("Create New Group", Colors.blue, () => {createGroupAlert()}),
              ],
            )
      )
  );
  final new_group_title = TextEditingController();
  final new_group_description = TextEditingController();

  createGroupAlert() => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("Create Group", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25)),
                SizedBox(height: 30),
                borderedTextField(new_group_title, TextInputType.text, false, "Title", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 10),
                borderedTextField(new_group_description, TextInputType.text, true, "Description", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  roundColorButton("Cancel", 140,Colors.red, Colors.black, 10, () => {
                    new_group_title.text = "",
                    new_group_description.text = "",            
                    Navigator.pop(context)}),
                  roundColorButton("Create", 140, Colors.green, Colors.black, 10, () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator(),);
                        });
                    await new Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      Group cell = Group("", new_group_title.text, new_group_description.text, "1", "2020.03.25", User("0", "SSS", "123123", true), [User("0", "SSS", "123123",true)], null);
                      if (default_groups == null || default_groups.length == 0) {
                          default_groups = [cell];
                      }
                      else {
                        default_groups.add(cell);
                      }
                    });

                    new_group_title.text = "";
                    new_group_description.text = "";       
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
  

  
  groupListView() => ListView.separated(
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
              itemCount: default_groups.length,
              itemBuilder: (BuildContext context, int index) {
                Group group = default_groups[index];
                return GroupItem(
                  // dp: group.,
                  name: group.title,
                  description: group.description,
                  number_of_members: "${group.members.length}",
                  isOnLine: group.created_user.isOnLine,
                  action: () {
                    setState(() {
                      app_status_index = 1;
                      selected_group_index = index;
                    });
                  },
                );
              },
            );


////////////// ! Report ////////////////////

  nonReportView() => 
    Center(
      child: new Padding(
            padding: new EdgeInsets.only(top: 100, bottom: 100),
            child: Column(        
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.png',height: 100,width: 100,),
                SizedBox(height: 10),
                Text(
                  "You don`t have any reports yet",
                  style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
            )
            
  );

  reportListView() => ListView.separated(
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
    itemCount: default_reports.length,
    itemBuilder: (BuildContext context, int index) {
      Report report = default_reports[index];
      ReportType report_type;
      String report_optional_val;

      if (report.type == ReportType.member_add) {
        // report_type = ReportType.member_add;   
        report_optional_val = "added to ${report.optional_val} group";               
      }
      else if (report.type == ReportType.contribute_creat) {
        // report_type = ReportType.contribute_creat;
        report_optional_val = "created new contribute";
      }
      else if (report.type == ReportType.contribute_join) {
        // report_type = ReportType.contribute_join;
        report_optional_val = "joined on ${report.optional_val}";
      }
      else {
        // report_type = ReportType.contribute_end;
        report_optional_val = "ended  ${report.optional_val}";
      }

      return ReportItem(
        // dp: group.,
        name: report.created_user.name,
        type: report.type,
        optional_val: report_optional_val,
        created_time: report.created_time,
        isOnLine: report.created_user.isOnLine);
    });

  
////////////// ! Contribute ////////////////////

  nonContributeView() => Center(
      child: new Padding(
            padding: new EdgeInsets.only(top: 50, bottom: 50),
            child: Column(                  
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo.png',height: 100,width: 100,),
                SizedBox(height: 10),
                Text(
                  "You don`t have any contributes yet",
                  style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey, fontSize: 15),
                ),
                SizedBox(height: 10),
                clickLable("Create New Contribute", Colors.blue, () => {createContributeAlert()}),
              ],
            )
      )
  );
  final new_contribute_title = TextEditingController();
  final new_contribute_description = TextEditingController();
  final new_contribute_amount = TextEditingController();
  final new_contribute_beneficiary_number = TextEditingController();
  final new_contribute_beneficiary_name = TextEditingController();

  createContributeAlert() => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0)), //this right here
        child: SingleChildScrollView (
    child: Container(
          height: 650,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("Create Contribute", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25)),
                SizedBox(height: 20),
                borderedTextField(new_contribute_title, TextInputType.text, false, "Title", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 10),
                borderedTextField(new_contribute_description, TextInputType.text, true, "Description", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 10),
                borderedTextField(new_contribute_amount, TextInputType.number, false, "Target Amount(optional)", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 20,),
                Text("Settlement Details(MTN Momo)", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey,fontSize: 15)),
                SizedBox(height: 10),
                borderedTextField(new_contribute_beneficiary_number, TextInputType.number, false, "Beneficiary MTN number", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 10),
                borderedTextField(new_contribute_beneficiary_name, TextInputType.text, false, "Beneficiary Name", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  roundColorButton("Cancel", 140,Colors.red, Colors.black, 10, () => {
                    new_contribute_title.text = "",
                    new_contribute_description.text = "",  
                    new_contribute_amount.text = "",  
                    new_contribute_beneficiary_number.text = "",  
                    new_contribute_beneficiary_name.text = "",            
                    Navigator.pop(context)}),
                  roundColorButton("Create", 140, Colors.green, Colors.black, 10, () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator(),);
                        });
                    await new Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      Contribute cell = Contribute("", new_contribute_title.text, new_contribute_description.text, new_contribute_amount.text, "0", "2020-03-25", "2020-03-29", new_contribute_beneficiary_name.text, new_contribute_beneficiary_number.text, User("", names[random.nextInt(10)], phones[random.nextInt(10)], true));
                      if (default_contributes == null || default_contributes.length == 0) {
                          default_contributes = [cell];
                      }
                      else {
                        default_contributes.add(cell);
                      }
                    });

                    new_contribute_title.text = "";
                    new_contribute_description.text = "";
                    new_contribute_amount.text = "";  
                    new_contribute_beneficiary_number.text = "";  
                    new_contribute_beneficiary_name.text = "";     
                    Navigator.pop(context);
                    Navigator.pop(context);
                  })
                ],)
              ],
            ),
          ),
        ),
      ));
    });
  

  
  contributeListView() => ListView.separated(
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
              itemCount: default_contributes.length,
              itemBuilder: (BuildContext context, int index) {
                Contribute contribute = default_contributes[index];
                return ContributeItem(
                  // dp: group.,
                  title: contribute.title,
                  description: contribute.description,
                  created_time: contribute.current_amount,
                  current_amount: contribute.current_amount,
                  isOnLine: contribute.created_user.isOnLine,
                  action: () {
                    setState(() {
                      selected_contribute_index = index;
                      Navigator.pushNamed(context, UIData.donateRoute);
                    });
                  },
                );
              },
            );

////////////// ! Member ////////////////////

  final new_member_phone = TextEditingController();

  createMemberAlert() => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text("Add Member(s)", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue,fontSize: 25)),
                SizedBox(height: 10),
                Padding(
                   padding: const EdgeInsets.only(left: 12.0),
                   child:
                    Text("Add up to ten phone numbers separated by commas(,)", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54,fontSize: 17)),
                ),
                borderedTextField(new_member_phone, TextInputType.text, true, "Phones(separate with comma)", UIData.smallPadding, textFieldNull()), 
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                  roundColorButton("Cancel", 140,Colors.red, Colors.black, 10, () => {
                    new_member_phone.text = "",          
                    Navigator.pop(context)}),
                  roundColorButton("Add", 140, Colors.green, Colors.black, 10, () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator(),);
                        });
                    await new Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      final array = new_member_phone.text.split(',');
                      for (var cell in array) {
                        final number = cell.trim();
                        User user = User("", number, number, random.nextBool());
                        default_groups[selected_group_index].members.add(user);
                      }
                    });

                    new_member_phone.text = "";     
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
  

  
  memberListView() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 15),GestureDetector(
                  onTap: () => {createMemberAlert()},
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20,),                        
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
                        Text("Add Member", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54,fontSize: 15))
                      ],
                    )),
                Expanded(
                  child: 
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
                    itemCount: default_groups[selected_group_index].members.length,
                    itemBuilder: (BuildContext context, int index) {
                      User member = default_groups[selected_group_index].members[index];
                      return MemberItem(
                        // dp: group.,
                        name: member.name,
                        phoneNumber: member.phoneNumber,
                        isOnline: member.isOnLine,
                        action: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(child: CircularProgressIndicator(),);
                              });
                          await new Future.delayed(const Duration(seconds: 2));
                          Navigator.pop(context);
                          setState(() {
                            default_groups[selected_group_index].members.removeAt(index);
                          });
                        }
                      );
                    }
                ),
                )]
            );

}
