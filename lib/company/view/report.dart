import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hr/company/controller/leave.dart';
import 'package:hr/company/controller/salary.dart';
import 'package:hr/company/view/leave/leavemaster.dart';
import 'package:hr/widget/drawer.dart';

import '../../constant.dart';
import '../../widget/appbar.dart';
import '../../widget/bottomnavigationbar.dart';
import '../../widget/button.dart';
import '../../widget/datepicker.dart';
import '../../widget/dropdown.dart';
import '../../widget/textformfield.dart';
import 'salary/addsalary.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveController leaveController = Get.put(LeaveController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => true,
        child: Obx(
          () {
            return SafeArea(
              child: Column(
                children: [
                  AppBarWidget("Monthly Report", false, () {}, true, false),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: BLUE,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  normaltext(
                                    "Select Month And Year",
                                    WHITE,
                                    FontWeight.bold,
                                  ),
                                  const Icon(
                                    Icons.date_range,
                                    color: WHITE,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showMonth("en", leaveController.monthDate);
                                  },
                                  child: Container(
                                    width: 130,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: BLUE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: normaltext(
                                        leaveController.monthDate.value
                                            .toString(),
                                        BLUE,
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showYear("en", leaveController.year);
                                  },
                                  child: Container(
                                    width: 130,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: BLUE),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: normaltext(
                                        leaveController.year.value.toString(),
                                        BLUE,
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            (leaveController.isLoadingleave.value)
                                ? loadingWidget()
                                : GestureDetector(
                                    onTap: () {
                                      leaveController.getLeaveReportMonthly();
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: BLUE,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          normaltext(
                                            "Leave Report",
                                            WHITE,
                                            FontWeight.bold,
                                          ),
                                          const Icon(
                                            Icons.download,
                                            color: WHITE,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            (leaveController.isLoadingAttendance.value)
                                ? loadingWidget()
                                : GestureDetector(
                                    onTap: () {
                                      leaveController
                                          .getAttendanceReportMonthly();
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: BLUE,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          normaltext(
                                            "Attendance Report",
                                            WHITE,
                                            FontWeight.bold,
                                          ),
                                          const Icon(
                                            Icons.download,
                                            color: WHITE,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      drawer: WeDrawer(),
      bottomNavigationBar: BottomNavigationBarWidget(3),
    );
  }
}
