import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/datepicker.dart';
import '../../controller/staffsalary.dart';

class StaffSalaryPage extends StatelessWidget {
  const StaffSalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    StaffSalaryController staffSalaryController =
        Get.put(StaffSalaryController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => true,
        child: Obx(
          () {
            return SafeArea(
              child: Column(
                children: [
                  // AppBarWidget("Salary Report", false, () {}, ""),
                  Container(
                      height: 70,
                      decoration: const BoxDecoration(
                          color: BLUE,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Salary Report".toString(),
                            style: const TextStyle(color: WHITE),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: GREY,
                              )),
                              child: Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showMonth("en",
                                              staffSalaryController.smonthDate);
                                        },
                                        child: Container(
                                          width: 130,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: BLUE),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: normaltext(
                                              staffSalaryController
                                                  .smonthDate.value
                                                  .toString(),
                                              BLUE,
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showYear("en",
                                              staffSalaryController.syear);
                                        },
                                        child: Container(
                                          width: 130,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: BLUE),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: normaltext(
                                              staffSalaryController.syear.value
                                                  .toString(),
                                              BLUE,
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  (staffSalaryController.isloading.value)
                                      ? loadingWidget()
                                      : GestureDetector(
                                          onTap: () {
                                            staffSalaryController
                                                .getStaffSalaryPDF();
                                            staffSalaryController.update();
                                          },
                                          child: Container(
                                            height: 40,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: BLUE,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                normaltext(
                                                  "Salary Report",
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
    );
  }
}
