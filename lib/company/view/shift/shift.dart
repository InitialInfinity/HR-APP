import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hr/company/view/shift/addshift.dart';
import 'package:hr/widget/drawer.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/popup.dart';
import '../../controller/shift.dart';

class ShiftList extends StatelessWidget {
  const ShiftList({super.key});
  @override
  Widget build(BuildContext context) {
    ShiftController shiftController = Get.put(ShiftController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Obx(
            () {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget("Shift Details", true, () {
                    shiftController.goToAddShift();
                  }, true, false),
                  (shiftController.isLoading.value)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(child: loadingWidget()),
                        )
                      : (shiftController.shiftList.isEmpty == true)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Center(
                                  child: normaltext(
                                      "There is no shift data", RED)),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i in shiftController.shiftList)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100]),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              normaltext(i["ShiftName"], BLUE,
                                                  FontWeight.bold),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                (i["ShiftName"] == "Night")
                                                    ? Icons.star_half
                                                    : (i["ShiftName"] ==
                                                            "Morning")
                                                        ? Icons.sunny
                                                        : (i["ShiftName"] ==
                                                                "Evening")
                                                            ? Icons.sunny
                                                            : Icons.sunny,
                                                color:
                                                    (i["ShiftName"] == "Night")
                                                        ? BLACK
                                                        : (i["ShiftName"] ==
                                                                "Morning")
                                                            ? ORANGE
                                                            : ORANGE,
                                                size: 14,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              smallText(
                                                  "Start Time :", GREY_DARK),
                                              smallText(i["StartTime"], BLUE)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              smallText(
                                                  "End Time :", GREY_DARK),
                                              smallText(i["EndTime"], BLUE)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              smallText(
                                                  "Grace Time :", GREY_DARK),
                                              smallText(i["GraceTime"], BLUE)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 90,
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    await shiftController
                                                        .updateShift(i);

                                                    shiftController.update();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    backgroundColor: BLUE,
                                                    side: const BorderSide(
                                                        color: BLUE),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      normaltext("Edit", WHITE,
                                                          FontWeight.bold),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.edit,
                                                        color: WHITE,
                                                        size: 12,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 90,
                                                height: 30,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showMyDialog(
                                                        "",
                                                        "Are You Sure to ",
                                                        "Delete " +
                                                            i["ShiftName"] +
                                                            " Shift",
                                                        "Delete", () async {
                                                      await shiftController
                                                          .deleteShift(i["Id"]);
                                                    });

                                                    shiftController.update();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    backgroundColor: RED,
                                                    side: const BorderSide(
                                                        color: RED),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      normaltext(
                                                          "Delete",
                                                          WHITE,
                                                          FontWeight.bold),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.delete,
                                                        color: WHITE,
                                                        size: 12,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // child: Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   children: [
                                      //     Column(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.start,
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Row(
                                      //           children: [
                                      //             const Icon(
                                      //               Icons.circle,
                                      //               color: RED,
                                      //               size: 10,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 5,
                                      //             ),
                                      //             Container(
                                      //               width: Get.width - 150,
                                      //               child: normaltext(
                                      //                   i["ShiftName"], BLACK),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment
                                      //                   .spaceBetween,
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.center,
                                      //           children: [
                                      //             smallText("Start Time: ",
                                      //                 GREY_DARK),
                                      //             smallText(
                                      //                 i["StartTime"], GREY_DARK)
                                      //           ],
                                      //         ),
                                      //         Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment
                                      //                   .spaceBetween,
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.center,
                                      //           children: [
                                      //             smallText(
                                      //                 "End Time: ", GREY_DARK),
                                      //             smallText(
                                      //                 i["EndTime"], GREY_DARK)
                                      //           ],
                                      //         )
                                      //       ],
                                      //     ),
                                      //     Column(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.center,
                                      //       children: [
                                      //         Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment
                                      //                   .spaceAround,
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.center,
                                      //           children: [
                                      //             GestureDetector(
                                      //               onTap: () async {
                                      //                 await shiftController
                                      //                     .updateShift(i);

                                      //                 shiftController.update();
                                      //               },
                                      //               child: const Icon(
                                      //                 Icons.edit,
                                      //                 color: GREEN,
                                      //                 size: 16,
                                      //               ),
                                      //             ),
                                      //             GestureDetector(
                                      //               onTap: () {
                                      //                 showMyDialog(
                                      //                     "",
                                      //                     "Are You Sure to ",
                                      //                     "Delete " +
                                      //                         i["ShiftName"] +
                                      //                         " Shift",
                                      //                     "Delete", () async {
                                      //                   await shiftController
                                      //                       .deleteShift(
                                      //                           i["Id"]);
                                      //                 });

                                      //                 shiftController.update();
                                      //               },
                                      //               child: const Icon(
                                      //                 Icons.delete,
                                      //                 color: RED,
                                      //                 size: 16,
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         )
                                      //       ],
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                  ),
                              ],
                            )
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
