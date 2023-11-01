import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/drawer.dart';
import 'package:extended_tabs/extended_tabs.dart';

import '../../controller/staffleave.dart';
import '../staffhome.dart';
import 'addleave.dart';

class StaffLeaveMasterPage extends StatelessWidget {
  const StaffLeaveMasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    StaffLeaveController leaveController = Get.put(StaffLeaveController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Obx(
            () {
              return Column(
                children: [
                  AppBarWidget("Leave", true, () {
                    Get.to(() => const AddStaffLeavePage());
                  }, false, false),
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
                          Tab(child: Text("Leave Balance".toString())),
                          Tab(child: Text("Leave History".toString())),
                          // Tab(child: Text("Leave".toString())),
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
                          child: leaveController.isLoading.value
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        loadingWidget(),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    for (var i
                                        in leaveController.balanceLeaveList)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          top: 8.0,
                                        ),
                                        child: Column(
                                          children: [
                                            Card(
                                              margin: const EdgeInsets.all(10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        titleText(
                                                            "Leave Without Pay",
                                                            BLACK),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                smallText(
                                                                    "Balance",
                                                                    GREY_DARK),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  width: 50,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: BLUE,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      smallText(
                                                                    i["AvailedLeaves"]
                                                                        .toString(),
                                                                    WHITE,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ORANGE,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                normaltext(
                                                                  i["TotalLeaves"]
                                                                      .toString(),
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                normaltext(
                                                                  "Total Leave",
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: GREEN,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                normaltext(
                                                                  i["AvailableLeaves"]
                                                                      .toString(),
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                normaltext(
                                                                  "Applied Leave",
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        titleText("Sick Leave",
                                                            BLACK),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                smallText(
                                                                    "Balance",
                                                                    GREY_DARK),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  width: 50,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: BLUE,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      smallText(
                                                                    i["SickLeaveRemaining"]
                                                                        .toString(),
                                                                    WHITE,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ORANGE,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                normaltext(
                                                                  i["SickLeaveRemaining"]
                                                                      .toString(),
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                normaltext(
                                                                  "Total Leave",
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: GREEN,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                normaltext(
                                                                  i["SickLeaveTaken"]
                                                                      .toString(),
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                normaltext(
                                                                  "Applied Leave",
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        titleText(
                                                            "Privilege Leave",
                                                            BLACK),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                smallText(
                                                                    "Balance",
                                                                    GREY_DARK),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  width: 50,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: BLUE,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      smallText(
                                                                    i["PrivilegeRemaining"]
                                                                        .toString(),
                                                                    WHITE,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ORANGE,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                normaltext(
                                                                  i["PrivilegeLeave"]
                                                                      .toString(),
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                normaltext(
                                                                  "Total Leave",
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: GREEN,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                normaltext(
                                                                  i["PrivilegeLeaveTaken"]
                                                                      .toString(),
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                normaltext(
                                                                  "Applied Leave",
                                                                  WHITE,
                                                                  FontWeight
                                                                      .normal,
                                                                  TextAlign
                                                                      .center,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                        SingleChildScrollView(
                          child: leaveController.isLoading.value
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        loadingWidget(),
                                      ],
                                    ),
                                  ),
                                )
                              : (leaveController.leaveList.isEmpty == true)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: normaltext(
                                            "There is no leave history",
                                            RED,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: <Widget>[
                                        for (var i in leaveController.leaveList)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 8.0,
                                            ),
                                            child: Column(
                                              children: [
                                                Card(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: PINK,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            titleText(
                                                              i["NoOfDays"],
                                                              WHITE,
                                                              TextAlign.justify,
                                                            ),
                                                            normaltext(
                                                                "Day", WHITE),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          10.0),
                                                              child: Row(
                                                                children: [
                                                                  smallText(
                                                                    (i["LeaveType"] ==
                                                                            "")
                                                                        ? "Casual Leave"
                                                                        : i["LeaveType"],
                                                                    GREY_DARK,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .circle,
                                                                    color:
                                                                        BLACK,
                                                                    size: 8,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  smallText(
                                                                    "LV${DateFormat('ddMMyyyy').format(DateTime.now())}${leaveController.leaveList.indexOf(i)}",
                                                                    GREY_DARK,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10),
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .circle,
                                                                    size: 10,
                                                                    color:
                                                                        GREEN,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  normaltext(
                                                                      (i["Approval_St"] ==
                                                                              null)
                                                                          ? "Pending"
                                                                          : i["Approval_St"]
                                                                              .toString(),
                                                                      BLACK),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              leaveController
                                                                      .showContainer[leaveController
                                                                          .leaveList
                                                                          .indexOf(
                                                                              i)]
                                                                      .value =
                                                                  !leaveController
                                                                      .showContainer[leaveController
                                                                          .leaveList
                                                                          .indexOf(
                                                                              i)]
                                                                      .value;
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_outlined,
                                                              color: GREY_DARK,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                Visibility(
                                                  visible: leaveController
                                                      .showContainer[
                                                          leaveController
                                                              .leaveList
                                                              .indexOf(i)]
                                                      .value,
                                                  child: Card(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: PINK,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
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
                                                                          "Application Date",
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          "From Date",
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          "To Date",
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          "Reason",
                                                                          WHITE,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        normaltext(
                                                                          ":",
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          ":",
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          ":",
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          ":",
                                                                          WHITE,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        normaltext(
                                                                          i["ApplicationDate"],
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          i["FromDate"],
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          i["ToDate"],
                                                                          WHITE,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        normaltext(
                                                                          i["LeaveReason"],
                                                                          WHITE,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // : const Card()
                                              ],
                                            ),
                                          ),
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
      floatingActionButton: FloatingActionButton(
        foregroundColor: WHITE,
        backgroundColor: BLUE,
        onPressed: () {
          Get.offAll(() => const StaffHomePage());
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Icon(
              Icons.arrow_back_ios,
              size: 16,
            )),
          ],
        ),
      ),
    );
  }
}
