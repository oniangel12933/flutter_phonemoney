import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:moneygroup/widgets/report_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/group_item.dart';
import '../widgets/member_item.dart';
import '../widgets/contribute_item.dart';
import '../utils/uiData.dart';
import '../utils/appData.dart';
import '../utils/components.dart';
import '../utils/functions.dart';

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  TabController tabbar;
  int _currentIndex = 0;
  CustomPopupMenu _selectedMenu = group_menu_list[0];
  bool create_group_status = false;
  bool create_contribute_status = false;
  bool add_member_status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabbar = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabbar.dispose();
  }

////////////// ! Main ////////////////////
  @override
  Widget build(BuildContext context) {
    void _menuSelected(CustomPopupMenu choice) {
      setState(() {
        _selectedMenu = choice;
        switch (_selectedMenu.title) {
          case UIData.menuNewGroup:
            tabbar.animateTo(0);
            create_group_status = true;
            setState(() {});
            break;

          case UIData.menuAccount:
            Navigator.pushNamed(context, UIData.accountRoute);
            break;

          case UIData.menuLogOut:
            groups = [];
            contributes = [];
            members = [];
            reports = [];
            donates = [];
            Navigator.popUntil(context, ModalRoute.withName(UIData.loginRoute));
            break;

          case UIData.menuNewContribute:
            tabbar.animateTo(0);
            create_contribute_status = true;
            setState(() {});
            break;

          case UIData.menuNewMember:
            tabbar.animateTo(1);
            add_member_status = true;
            setState(() {});
            break;

          default:
            break;
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
              (app_status_index == 0)
                  ? 'My Contributes'
                  : groups[selected_group_index].title,
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: app_status_index != 0
              ? Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        members = [];
                        contributes = [];
                        tabbar.animateTo(0);
                        app_status_index =
                            (app_status_index > 0) ? app_status_index -= 1 : 0;
                        print(app_status_index);
                      });
                    },
                  );
                })
              : Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: const Icon(null),
                      onPressed: () {
                        app_status_index =
                            (app_status_index != 0) ? app_status_index-- : 0;
                      },
                    );
                  },
                ),
          actions: <Widget>[
            IconButton(
              icon:
              Icon(Icons.refresh),
              onPressed: () async {
              Map<String, String> params = null;
              if (app_status_index == 0) {
                params = {'user_id': AppData.user_info.id};
              } else {
                params = {'group_id': groups[selected_group_index].id};
              }

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

                  if (data['groups'] != null) {
                    groups = [];
                    (data['groups'] as List).map((i) {
                      final group = Group.fromJson(i as Map<String, dynamic>);
                      if (groups == null) {
                        groups = [group];
                      } else {
                        groups.add(group);
                      }
                    }).toList();

                    groups.sort(
                        (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                  }

                  if (data['contributes'] != null) {
                    contributes = [];
                    (data['contributes'] as List).map((i) {
                      final contribute =
                          Contribute.fromJson(i as Map<String, dynamic>);
                      if (contributes == null) {
                        contributes = [contribute];
                      } else {
                        contributes.add(contribute);
                      }
                    }).toList();

                    contributes.sort(
                        (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                  }

                  if (data['members'] != null) {
                    members = [];
                    (data['members'] as List).map((i) {
                      final member = Member.fromJson(i as Map<String, dynamic>);
                      if (members == null) {
                        members = [member];
                      } else {
                        members.add(member);
                      }
                    }).toList();

                    contributes.sort(
                        (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                  }
                }
                Navigator.pop(context);
                setState(() {});
              }, onError: (error) {
                print(error);
              });
            }),
            PopupMenuButton<CustomPopupMenu>(
              elevation: 3.2,
              initialValue: app_status_index == 0
                  ? group_menu_list[1]
                  : member_menu_list[1],
              onCanceled: () {
                print('You have not chosed anything');
              },
              tooltip: 'This is tooltip',
              onSelected: _menuSelected,
              itemBuilder: (BuildContext context) {
                return app_status_index == 0
                    ? group_menu_list.map((CustomPopupMenu choice) {
                        return PopupMenuItem<CustomPopupMenu>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList()
                    : member_menu_list.map((CustomPopupMenu choice) {
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
              automaticallyImplyLeading: false,
              title: TabBar(
                labelColor: Colors.white,
                controller: tabbar,
                tabs: <Widget>[
                  Tab(
                    text: (app_status_index == 0)
                        ? "Groups"
                        : "Group`s Contributions",
                  ),
                  Tab(
                    text: (app_status_index == 0) ? "Reports" : "Members",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabbar,
              children: <Widget>[
                app_status_index == 0
                    ? (groups == null || groups.length == 0
                        ? Stack(children: <Widget>[
                            nonGroupView(),
                            this.create_group_status
                                ? createGroupView()
                                : new Container()
                          ])
                        : Stack(children: <Widget>[
                            groupListView(),
                            this.create_group_status
                                ? createGroupView()
                                : new Container()
                          ]))
                    : (contributes == null || contributes.length == 0
                        ? Stack(children: <Widget>[
                            nonContributeView(),
                            create_contribute_status
                                ? createContributeView()
                                : new Container()
                          ])
                        : Stack(children: <Widget>[
                            contributeListView(),
                            create_contribute_status
                                ? createContributeView()
                                : new Container()
                          ])),
                app_status_index == 0
                    ? (reports == null || reports.length == 0
                        ? nonReportView()
                        : reportListView())
                    : Stack(children: <Widget>[
                        memberListView(),
                        add_member_status ? addMemberView() : new Container()
                      ])
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
              Image.asset(
                'assets/logo.png',
                height: 100,
                width: 100,
              ),
              SizedBox(height: 10),
              Text(
                "You don`t have any groups yet",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              SizedBox(height: 10),
              clickLable(
                  "Create New Group",
                  Colors.blue,
                  () => {
                        setState(() {
                          create_group_status = true;
                        })
                      }),
            ],
          )));

  final new_group_title = TextEditingController();
  final new_group_description = TextEditingController();
  bool new_group_title_status = true;
  bool new_group_description_status = true;

  createGroupView() => GestureDetector(
      onTap: () {
        new_group_title.text = "";
        new_group_description.text = "";
        new_group_title_status = true;
        new_group_description_status = true;
        create_group_status = false;
        setState(() {});
      },
      child: Container(
          color: Colors.black87.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
          child: GestureDetector(
            onTap: () {},
            child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      width: 300,
                      height: 350,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Create Group",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    fontSize: 25)),
                            SizedBox(height: 20),
                            borderedTextField(
                                new_group_title,
                                new_group_title_status,
                                TextInputType.text,
                                false,
                                "Title",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(height: 10),
                            borderedTextField(
                                new_group_description,
                                new_group_description_status,
                                TextInputType.text,
                                true,
                                "Description",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(
                              height: 20,
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
                                          new_group_title.text = "",
                                          new_group_description.text = "",
                                          new_group_title_status = true,
                                          new_group_description_status = true,
                                          create_group_status = false,
                                          setState(() {})
                                        }),
                                roundColorButton("Create", 140, Colors.green,
                                    Colors.black, 10, () async {
                                  new_group_title_status =
                                      checkInputed(new_group_title);
                                  new_group_description_status =
                                      checkInputed(new_group_description);
                                  setState(() {});
                                  if (new_group_title_status &&
                                      new_group_description_status) {
                                    final formatter =
                                        new DateFormat('yyyy-MM-dd-hh-mm');
                                    final current_time =
                                        formatter.format(new DateTime.now());

                                    var params = {
                                      'created_user_id': AppData.user_info.id,
                                      'title': new_group_title.text,
                                      'description': new_group_description.text,
                                      'created_time': current_time
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
                                                AppData.createGroupApi)
                                        .then((value) {
                                      // Run extra code here

                                      if (value['status'] as bool) {
                                        final data = value['data']
                                            as Map<String, dynamic>;
                                        final group = Group.fromJson(
                                            data['group']
                                                as Map<String, dynamic>);
                                        if (groups == null ||
                                            groups.length == 0) {
                                          groups = [group];
                                        } else {
                                          groups.add(group);
                                        }
                                        create_group_status = false;
                                        setState(() {});
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pop(context);
                                        showAlert(
                                            context,
                                            AlertType.error,
                                            value['message'] as String,
                                            "Close",
                                            () => {Navigator.pop(context)});
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

  bool group_owner_status = false;

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
        itemCount: groups.length,
        itemBuilder: (BuildContext context, int index) {
          Group group = groups[index];
          return GroupItem(
            // dp: group.,
            name: group.title,
            description: group.description,
            number_of_members: "${group.number_of_members}",
            isOnLine: true,
            action: () {
              var params = {'group_id': group.id};

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              postApiCall(params, AppData.baseURL + AppData.getDetailApi).then(
                  (value) {
                // Run extra code here

                if (value['status'] as bool) {
                  final data = value['data'] as Map<String, dynamic>;
                  if (data['contributes'] != null) {
                    (data['contributes'] as List).map((i) {
                      final contribute =
                          Contribute.fromJson(i as Map<String, dynamic>);
                      if (contributes == null) {
                        contributes = [contribute];
                      } else {
                        contributes.add(contribute);
                      }
                    }).toList();
                    contributes.sort(
                        (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                  }
                  group_owner_status = false;
                  if (data['members'] != null) {
                    (data['members'] as List).map((i) {
                      final member = Member.fromJson(i as Map<String, dynamic>);
                      if (member.owner_status == "1" &&
                          member.phone_number == AppData.user_info.mainPhone) {
                        group_owner_status = true;
                      }
                      if (members == null) {
                        members = [member];
                      } else {
                        members.add(member);
                      }
                    }).toList();
                    members.sort(
                        (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                  }
                }
                Navigator.pop(context);
                app_status_index = 1;
                selected_group_index = index;
                setState(() {});
              }, onError: (error) {
                print(error);
              });
            },
          );
        },
      );

////////////// ! Report ////////////////////

  nonReportView() => Center(
          child: new Padding(
        padding: new EdgeInsets.only(top: 100, bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 10),
            Text(
              "You don`t have any reports yet",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                  fontSize: 15),
            ),
          ],
        ),
      ));

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
      itemCount: reports.length,
      itemBuilder: (BuildContext context, int index) {
        Report report = reports[index];
        ReportType report_type;
        String report_optional_val;

        if (report.type == ReportType.member_add) {
          // report_type = ReportType.member_add;
          report_optional_val = "added to ${report.optional_val} group";
        } else if (report.type == ReportType.contribute_creat) {
          // report_type = ReportType.contribute_creat;
          report_optional_val = "created new contribute";
        } else if (report.type == ReportType.contribute_join) {
          // report_type = ReportType.contribute_join;
          report_optional_val = "joined on ${report.optional_val}";
        } else {
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
              Image.asset(
                'assets/logo.png',
                height: 100,
                width: 100,
              ),
              SizedBox(height: 10),
              Text(
                "You don`t have any contributes yet",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              SizedBox(height: 10),
              clickLable("Create New Contribute", Colors.blue,
                  () => {create_contribute_status = true, setState(() {})}),
            ],
          )));
  final new_contribute_title = TextEditingController();
  final new_contribute_description = TextEditingController();
  final new_contribute_amount = TextEditingController();
  final new_contribute_beneficiary_number = TextEditingController();
  final new_contribute_beneficiary_name = TextEditingController();
  bool new_contribute_title_status = true;
  bool new_contribute_description_status = true;
  bool new_contribute_beneficiary_name_status = true;
  bool new_contribute_beneficiary_phone_status = true;

  createContributeView() => GestureDetector(
      onTap: () {
        new_contribute_title.text = "";
        new_contribute_description.text = "";
        new_contribute_amount.text = "";
        new_contribute_beneficiary_number.text = "";
        new_contribute_beneficiary_name.text = "";
        new_contribute_title_status = true;
        new_contribute_description_status = true;
        new_contribute_beneficiary_name_status = true;
        new_contribute_beneficiary_phone_status = true;
        create_contribute_status = false;
        setState(() {});
      },
      child: Container(
          color: Colors.black87.withOpacity(0.5),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.white,
                      width: 300,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Create Contribute",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    fontSize: 25)),
                            SizedBox(height: 20),
                            borderedTextField(
                                new_contribute_title,
                                new_contribute_title_status,
                                TextInputType.text,
                                false,
                                "Title",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(height: 10),
                            borderedTextField(
                                new_contribute_description,
                                new_contribute_description_status,
                                TextInputType.text,
                                true,
                                "Description",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(height: 10),
                            borderedTextField(
                                new_contribute_amount,
                                true,
                                TextInputType.numberWithOptions(signed: true),
                                false,
                                "Target Amount(optional)",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Settlement Details(MTN Momo)",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 15)),
                            SizedBox(height: 10),
                            borderedTextField(
                                new_contribute_beneficiary_number,
                                new_contribute_beneficiary_name_status,
                                TextInputType.number,
                                false,
                                "Beneficiary MTN number",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(height: 10),
                            borderedTextField(
                                new_contribute_beneficiary_name,
                                new_contribute_beneficiary_phone_status,
                                TextInputType.text,
                                false,
                                "Beneficiary Name",
                                UIData.smallPadding,
                                textFieldNull()),
                            SizedBox(height: 20),
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
                                          new_contribute_title.text = "",
                                          new_contribute_description.text = "",
                                          new_contribute_amount.text = "",
                                          new_contribute_beneficiary_number
                                              .text = "",
                                          new_contribute_beneficiary_name.text =
                                              "",
                                          new_contribute_title_status = false,
                                          new_contribute_description_status =
                                              false,
                                          new_contribute_beneficiary_name_status =
                                              false,
                                          new_contribute_beneficiary_phone_status =
                                              false,
                                          create_contribute_status = false,
                                          setState(() {})
                                        }),
                                roundColorButton("Create", 140, Colors.green,
                                    Colors.black, 10, () async {
                                  new_contribute_title_status =
                                      checkInputed(new_contribute_title);
                                  new_contribute_description_status =
                                      checkInputed(new_contribute_description);
                                  new_contribute_beneficiary_name_status =
                                      checkInputed(
                                          new_contribute_beneficiary_name);
                                  new_contribute_beneficiary_phone_status =
                                      checkInputed(
                                          new_contribute_beneficiary_number);
                                  setState(() {});

                                  if (new_contribute_title_status &&
                                      new_contribute_description_status &&
                                      new_contribute_beneficiary_name_status &&
                                      new_contribute_beneficiary_phone_status) {
                                    final formatter =
                                        new DateFormat('yyyy-MM-dd-hh-mm');
                                    final current_time =
                                        formatter.format(new DateTime.now());
                                    var params = {
                                      "created_group_id":
                                          groups[selected_group_index].id,
                                      "created_user_id": AppData.user_info.id,
                                      "title": new_contribute_title.text,
                                      "description":
                                          new_contribute_description.text,
                                      "target_amount":
                                          new_contribute_amount.text,
                                      "created_time": current_time,
                                      "end_time": "2020-04-20",
                                      "beneficiary_name":
                                          new_contribute_beneficiary_name.text,
                                      "beneficiary_phone":
                                          new_contribute_beneficiary_number.text
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
                                                AppData.createContributeApi)
                                        .then((value) {
                                      // Run extra code here

                                      if (value['status'] as bool) {
                                        final data = value['data']
                                            as Map<String, dynamic>;
                                        final contribute = Contribute.fromJson(
                                            data['contribute']
                                                as Map<String, dynamic>);
                                        if (contributes == null) {
                                          contributes = [contribute];
                                        } else {
                                          contributes.add(contribute);
                                        }
                                        new_contribute_title.text = "";
                                        new_contribute_description.text = "";
                                        new_contribute_amount.text = "";
                                        new_contribute_beneficiary_number.text =
                                            "";
                                        new_contribute_beneficiary_name.text =
                                            "";
                                        new_contribute_title_status = true;
                                        new_contribute_description_status =
                                            true;
                                        new_contribute_beneficiary_name_status =
                                            true;
                                        new_contribute_beneficiary_phone_status =
                                            true;
                                        create_contribute_status = false;
                                        Navigator.pop(context);
                                        showAlert(
                                            context,
                                            AlertType.success,
                                            value['message'] as String,
                                            "Close",
                                            () => {
                                                  setState(() {}),
                                                  Navigator.pop(context)
                                                });
                                      } else {
                                        Navigator.pop(context);
                                        showAlert(
                                            context,
                                            AlertType.error,
                                            value['message'] as String,
                                            "Close",
                                            () => {Navigator.pop(context)});
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
          ))));

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
        itemCount: contributes.length,
        itemBuilder: (BuildContext context, int index) {
          Contribute contribute = contributes[index];
          return ContributeItem(
            // dp: group.,
            title: contribute.title,
            description: contribute.description,
            created_time: contribute.created_time,
            current_amount: contribute.current_amount,
            isOnLine: true,
            action: () {
              setState(() {
                selected_contribute_index = index;
                var params = {'contribute_id': contribute.id};

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });

                postApiCall(params, AppData.baseURL + AppData.getDetailApi)
                    .then((value) {
                  // Run extra code here

                  if (value['status'] as bool) {
                    final data = value['data'] as Map<String, dynamic>;
                    (data['donates'] as List).map((i) {
                      final donate = Donate.fromJson(i as Map<String, dynamic>);
                      if (donates == null) {
                        donates = [donate];
                      } else {
                        donates.add(donate);
                      }
                    }).toList();
                    donates.sort(
                        (a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
                  }
                  Navigator.pop(context);
                  Navigator.pushNamed(context, UIData.donateRoute);
                }, onError: (error) {
                  print(error);
                });
              });
            },
          );
        },
      );

////////////// ! Member ////////////////////

  final new_member_phone = TextEditingController();
  bool new_member_phone_status = true;
  addMemberView() => GestureDetector(
      onTap: () {
        new_member_phone.text = "";
        new_member_phone_status = true;
        add_member_status = false;
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
                            Text("Add Member(s)",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    fontSize: 25)),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                  "Add up to ten phone numbers separated by commas(,)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      fontSize: 17)),
                            ),
                            borderedTextField(
                                new_member_phone,
                                new_member_phone_status,
                                TextInputType.numberWithOptions(signed: true),
                                true,
                                "Phones(separate with comma)",
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
                                          new_member_phone.text = "",
                                          new_member_phone_status = true,
                                          add_member_status = false,
                                          setState(() {})
                                        }),
                                roundColorButton("Create", 140, Colors.green,
                                    Colors.black, 10, () async {
                                  new_member_phone_status =
                                      checkInputed(new_member_phone);
                                  setState(() {});

                                  if (new_member_phone_status) {
                                    final formatter =
                                        new DateFormat('yyyy-MM-dd-hh-mm');
                                    final current_time =
                                        formatter.format(new DateTime.now());
                                    var params = {
                                      "group_id":
                                          groups[selected_group_index].id,
                                      "phone_numbers": new_member_phone.text,
                                      "joined_time": current_time
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
                                                AppData.addMemberApi)
                                        .then((value) {
                                      // Run extra code here

                                      if (value['status'] as bool) {
                                        final data = value['data']
                                            as Map<String, dynamic>;
                                        (data['members'] as List).map((i) {
                                          final member = Member.fromJson(
                                              i as Map<String, dynamic>);
                                          if (members == null) {
                                            members = [member];
                                          } else {
                                            members.add(member);
                                          }
                                        }).toList();

                                        new_member_phone.text = "";
                                        new_member_phone_status = true;
                                        add_member_status = false;
                                        Navigator.pop(context);
                                        showAlert(
                                            context,
                                            AlertType.success,
                                            value['message'] as String,
                                            "Close",
                                            () => {
                                                  Navigator.pop(context),
                                                  setState(() {})
                                                });
                                        ;
                                      } else {
                                        Navigator.pop(context);
                                        showAlert(
                                            context,
                                            AlertType.error,
                                            value['message'] as String,
                                            "Close",
                                            () => {Navigator.pop(context)});
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

  memberListView() => Column(mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 15),
            GestureDetector(
                onTap: () => {
                      add_member_status = true,
                      setState(() {
                        add_member_status = true;
                        setState(() {});
                      })
                    },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        child:
                            Icon(Icons.add_circle_outline, color: Colors.grey),
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
                    Text("Add Member",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                            fontSize: 15))
                  ],
                )),
            members != null
                ? Expanded(
                    child: ListView.separated(
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
                        itemCount: members.length,
                        itemBuilder: (BuildContext context, int index) {
                          Member member = members[index];
                          return MemberItem(
                              // dp: group.,
                              name: member.name,
                              phoneNumber: member.phone_number,
                              ownerStatus: member.owner_status == "1"
                                  ? "1"
                                  : (group_owner_status ? "0" : "2"),
                              isOnline: true,
                              action: () async {
                                var params = {'member_id': member.id};

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
                                            AppData.removeMemberApi)
                                    .then((value) {
                                  // Run extra code here

                                  if (value['status'] as bool) {
                                    members.remove(member);
                                    setState(() {});
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                    showAlert(
                                        context,
                                        AlertType.error,
                                        value['message'] as String,
                                        "Close",
                                        () => {Navigator.pop(context)});
                                  }
                                }, onError: (error) {
                                  print(error);
                                });
                              });
                        }),
                  )
                : new Container()
          ]);

  bool checkInputed(TextEditingController controller) {
    if (controller.text == '') {
      return false;
    } else {
      return true;
    }
  }
}
