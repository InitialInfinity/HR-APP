import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/leave.dart';
import 'package:hr/widget/drawer.dart';
import 'package:hr/widget/label.dart';
import 'package:hr/widget/textformfield.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/backbutton.dart';
import 'leaveapprovallist.dart';

class LeaveApproval extends StatelessWidget {
  const LeaveApproval({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveController leaveController = Get.put(LeaveController());
    return Obx(
      () {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                AppBarWidget("Leave Approval", false, () {}, true, false),
                (leaveController.isLoading.value)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(child: loadingWidget()),
                      )
                    : (leaveController.adminAllLeave.isEmpty == true)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: normaltext("No leave application", RED),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (var i in leaveController.adminAllLeave)
                                    Card(
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: const EdgeInsets.all(10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            normaltext(
                                              i["StaffName"],
                                              BLUE,
                                              FontWeight.bold,
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            smallText(
                                                (i["Designation"] == null)
                                                    ? "Unknown"
                                                    : i["Designation"],
                                                GREY_DARK),
                                            const Divider(
                                              color: GREY_DARK,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                normaltext(
                                                    "Leave Type", GREY_DARK),
                                                normaltext(i["LeaveType"], BLUE)
                                              ],
                                            ),
                                            const Divider(
                                              color: GREY_DARK,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                normaltext("Period", GREY_DARK),
                                                normaltext(
                                                    i["FromDate"] +
                                                        " To " +
                                                        i["ToDate"],
                                                    BLUE)
                                              ],
                                            ),
                                            const Divider(
                                              color: GREY_DARK,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                normaltext(
                                                    "Duration", GREY_DARK),
                                                normaltext(i["NoOfDays"], BLUE)
                                              ],
                                            ),
                                            const Divider(
                                              color: GREY_DARK,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                normaltext(
                                                    "Leave Reason", GREY_DARK),
                                                normaltext(
                                                    i["LeaveReason"], BLUE)
                                              ],
                                            ),
                                            const Divider(
                                              color: GREY_DARK,
                                            ),
                                            LabelWidget("Reject Reason"),
                                            TextFormFieldWidget(
                                              hinttext: "Enter Reject Reason",
                                              errortext: "Enter Reject Reason",
                                              controller:
                                                  leaveController.reason,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              prefixIcon: const Icon(
                                                Icons.textsms_rounded,
                                                color: BLUE,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  height: 40,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      leaveController
                                                          .addLeaveApproval(
                                                        i["Id"].toString(),
                                                        i["StaffId"],
                                                        "Approve",
                                                      );
                                                      leaveController.update();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      backgroundColor: WHITE,
                                                      side: const BorderSide(
                                                          color: GREEN),
                                                    ),
                                                    child: normaltext("Approve",
                                                        GREEN, FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                SizedBox(
                                                  width: 130,
                                                  height: 40,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      leaveController
                                                          .addLeaveApproval(
                                                        i["Id"].toString(),
                                                        i["StaffId"],
                                                        "Reject",
                                                      );
                                                      leaveController.update();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      backgroundColor: WHITE,
                                                      side: const BorderSide(
                                                          color: RED),
                                                    ),
                                                    child: normaltext("Reject",
                                                        RED, FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                // : Expanded(
                // child: ListView(
                //   children: ListTile
                //       .divideTiles(context: context, tiles: [
                //     for (var i in leaveController.adminAllLeave)
                // ListTile(
                //   visualDensity: const VisualDensity(
                //       vertical: 4), //<-- SEE HERE
                //   leading: const CircleAvatar(
                //       backgroundColor: ORANGE,
                //       child: Icon(
                //         Icons.forum_rounded,
                //         color: WHITE,
                //         size: 20,
                //       )),

                //   title: Text.rich(
                //     TextSpan(
                //       children: [
                //         TextSpan(
                //           text: i["StaffName"] + " ",
                //           style: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 14),
                //         ),
                //         const TextSpan(
                //             text: 'Applied For',
                //             style: TextStyle(fontSize: 14)),
                //         TextSpan(
                //           text: ' ' + i["LeaveType"],
                //           style: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 14),
                //         ),
                //         const TextSpan(
                //             text: ' from',
                //             style: TextStyle(fontSize: 14)),
                //         TextSpan(
                //           text: ' ' + i["FromDate"],
                //           style: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 14),
                //         ),
                //         const TextSpan(
                //             text: ' to',
                //             style: TextStyle(fontSize: 14)),
                //         TextSpan(
                //           text: ' ' + i["ToDate"],
                //           style: const TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 14),
                //         ),
                //       ],
                //     ),
                //   ),
                //   subtitle: Column(
                //     mainAxisAlignment:
                //         MainAxisAlignment.start,
                //     crossAxisAlignment:
                //         CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment:
                //             MainAxisAlignment.spaceBetween,
                //         crossAxisAlignment:
                //             CrossAxisAlignment.end,
                //         children: [
                //           smallText(
                //             i["ApplicationDate"],
                //             GREY_DARK,
                //             FontWeight.normal,
                //             TextAlign.justify,
                //           ),
                //           leaveController.isApprove.value ==
                //                   true
                //               ? Column(
                //                   children: [
                //                     Row(
                //                       children: [
                //                         normaltext("Approved",
                //                             GREEN),
                //                         const SizedBox(
                //                           width: 10,
                //                         ),
                //                         const Icon(
                //                           Icons.check_circle,
                //                           color: GREEN,
                //                           size: 18,
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 )
                //               : leaveController
                //                           .isReject.value ==
                //                       true
                //                   ? Column(
                //                       children: [
                //                         Row(
                //                           children: [
                //                             const Icon(
                //                               Icons.cancel,
                //                               color: RED,
                //                               size: 18,
                //                             ),
                //                             const SizedBox(
                //                               width: 10,
                //                             ),
                //                             normaltext(
                //                                 "Rejected",
                //                                 RED),
                //                           ],
                //                         ),
                //                       ],
                //                     )
                //                   : Container()
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //       Row(
                //         mainAxisAlignment:
                //             MainAxisAlignment.start,
                //         crossAxisAlignment:
                //             CrossAxisAlignment.center,
                //         children: [
                //           SizedBox(
                //             width: 110,
                //             height: 30,
                //             child: ElevatedButton(
                //               onPressed: () {
                //                 leaveController
                //                     .addLeaveApproval(
                //                   i["Id"].toString(),
                //                   i["StaffId"],
                //                   "Approve",
                //                 );
                //                 leaveController.update();
                //               },
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius:
                //                       BorderRadius.circular(
                //                           10.0),
                //                 ),
                //                 backgroundColor: WHITE,
                //                 side: const BorderSide(
                //                     color: GREEN),
                //               ),
                //               child: normaltext("Approve",
                //                   GREEN, FontWeight.bold),
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 30,
                //           ),
                //           SizedBox(
                //             width: 110,
                //             height: 30,
                //             child: ElevatedButton(
                //               onPressed: () {
                //                 leaveController
                //                     .addLeaveApproval(
                //                   i["Id"].toString(),
                //                   i["StaffId"],
                //                   "Reject",
                //                 );
                //                 leaveController.update();
                //               },
                //               child: normaltext("Reject", RED,
                //                   FontWeight.bold),
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius:
                //                       BorderRadius.circular(
                //                           10.0),
                //                 ),
                //                 backgroundColor: WHITE,
                //                 side: const BorderSide(
                //                     color: RED),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(
                //         height: 10,
                //       ),
                //     ],
                //   ),
                // )
                // ]).toList(),
                //   ),
                // ),
              ],
            ),
          ),
          drawer: WeDrawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: BLUE,
            foregroundColor: WHITE,
            onPressed: () {
              Get.to(() => const LeaveApprovalList());
            },
            child: const Icon(
              Icons.list,
            ),
          ),
        );
      },
    );
  }
}
