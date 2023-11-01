import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/leave.dart';
import 'package:hr/company/view/leave/addleave.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/bottomnavigationbar.dart';
import '../../../widget/drawer.dart';
import 'package:extended_tabs/extended_tabs.dart';

import '../../../widget/popup.dart';

class LeaveMasterPage extends StatelessWidget {
  const LeaveMasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveController leaveController = Get.put(LeaveController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Obx(
            () {
              return Column(
                children: [
                  AppBarWidget("Leave Master", true, () {
                    Get.offAll(() => const AddLeavePage());
                  }, true, false),
                  Stack(
                    children: <Widget>[
                      TabBar(
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 4,
                              color: BLUE,
                            ),
                          ),
                        ),
                        labelColor: BLUE,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelColor: GREY_DARK,
                        tabs: [
                          Tab(child: Text("Week Off".toString())),
                          Tab(child: Text("Holiday".toString())),
                          Tab(child: Text("Leave".toString())),
                        ],
                        controller: leaveController.tabControllerList,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ExtendedTabBarView(
                      controller: leaveController.tabControllerList,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: (leaveController.isLoading.value)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Center(child: loadingWidget()),
                                )
                              : leaveController.weekOfflist.isEmpty == true
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Center(
                                        child: normaltext(
                                          'No Week Off',
                                          ORANGE,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: <Widget>[
                                        for (var i
                                            in leaveController.weekOfflist)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Card(
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        color: BLUE),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          normaltext(
                                                              "Week Off Details",
                                                              WHITE),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await leaveController
                                                                          .editLeave(
                                                                              i,
                                                                              0);
                                                                      leaveController
                                                                              .showWeekOff
                                                                              .value ==
                                                                          true;
                                                                      leaveController
                                                                          .showWeekOffcontainer();
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color:
                                                                          WHITE,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      showMyDialog(
                                                                          "",
                                                                          "Are you sure want to delete week off ",
                                                                          i["WeekOff_First"] +
                                                                              " ",
                                                                          "Delete",
                                                                          () async {
                                                                        await leaveController
                                                                            .deleteWeekOff(i["Id"]);
                                                                      });

                                                                      leaveController
                                                                          .update();
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color:
                                                                          GREY_LIGHTER,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              normaltext(
                                                                  i["WeekOff_First"],
                                                                  BLUE),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              normaltext(
                                                                  i["WeekOff_Second"],
                                                                  BLUE),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                        ),
                        SingleChildScrollView(
                          child: (leaveController.isLoading.value)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Center(child: loadingWidget()),
                                )
                              : (leaveController.allHolidday.isEmpty == true)
                                  ? Center(
                                      child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: normaltext("No holiday", RED),
                                    ))
                                  : Column(
                                      children: <Widget>[
                                        for (var i
                                            in leaveController.allHolidday)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Card(
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        color: BLUE),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          normaltext(
                                                              "Holiday Details",
                                                              WHITE),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await leaveController
                                                                          .editLeave(
                                                                              i,
                                                                              1);
                                                                      leaveController
                                                                              .showHoliday
                                                                              .value ==
                                                                          true;
                                                                      leaveController
                                                                          .showHolidaycontainer();
                                                                      leaveController
                                                                          .update();
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color:
                                                                          WHITE,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      showMyDialog(
                                                                          "",
                                                                          "Are you sure want to delete holiday ",
                                                                          i["Description"] +
                                                                              " ",
                                                                          "Delete",
                                                                          () async {
                                                                        await leaveController
                                                                            .deleteHoliday(i["Id"]);
                                                                      });

                                                                      leaveController
                                                                          .update();
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color:
                                                                          GREY_LIGHTER,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              normaltext(
                                                                  i["Description"],
                                                                  BLUE),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  normaltext(
                                                                      i["Date"],
                                                                      BLUE),
                                                                  SizedBox(
                                                                    width: 05,
                                                                  ),
                                                                  normaltext(
                                                                      "${"(" + i["Day"]})",
                                                                      BLUE),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                        ),
                        SingleChildScrollView(
                          child: (leaveController.isLoading.value)
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Center(child: loadingWidget()),
                                )
                              : (leaveController.addleaveList.isEmpty == true)
                                  ? Center(
                                      child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: normaltext("No leave", RED),
                                    ))
                                  : Column(
                                      children: <Widget>[
                                        for (var i
                                            in leaveController.addleaveList)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Card(
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        color: BLUE),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          normaltext(
                                                              "Leave Details",
                                                              WHITE),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await leaveController
                                                                          .editLeave(
                                                                              i,
                                                                              2);
                                                                      leaveController
                                                                              .showLeave
                                                                              .value ==
                                                                          true;
                                                                      leaveController
                                                                          .showLeavecontainer();
                                                                      leaveController
                                                                          .update();
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color:
                                                                          WHITE,
                                                                      size: 18,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  // GestureDetector(
                                                                  //   onTap:
                                                                  //       () async {
                                                                  //     showMyDialog(
                                                                  //         "",
                                                                  //         "Are you sure want to delete leave for ",
                                                                  //         i["StaffName"] +
                                                                  //             " ",
                                                                  //         "Delete",
                                                                  //         () async {
                                                                  //       await leaveController
                                                                  //           .deleteHoliday(i["Id"]);
                                                                  //     });

                                                                  //     leaveController
                                                                  //         .update();
                                                                  //   },
                                                                  //   child: Icon(
                                                                  //     Icons
                                                                  //         .delete,
                                                                  //     color:
                                                                  //         GREY_LIGHTER,
                                                                  //     size: 18,
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              normaltext(
                                                                  i["StaffName"],
                                                                  BLUE),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  normaltext(
                                                                      "Privilege Leave :",
                                                                      BLUE),
                                                                  SizedBox(
                                                                    width: 05,
                                                                  ),
                                                                  normaltext(
                                                                      i["PrivilegeLeave"],
                                                                      BLUE),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  normaltext(
                                                                      "Sick Leave :",
                                                                      BLUE),
                                                                  SizedBox(
                                                                    width: 05,
                                                                  ),
                                                                  normaltext(
                                                                      i["SickLeaves"],
                                                                      BLUE),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      drawer: WeDrawer(),
    );
  }
}
