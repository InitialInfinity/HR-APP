import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/salary.dart';
import 'package:hr/widget/datepicker.dart';
import 'package:hr/widget/drawer.dart';
import 'package:hr/widget/dropdown.dart';
import 'package:hr/widget/textformfield.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../constant.dart';
import '../../../widget/appbar.dart';
import '../../../widget/bottomnavigationbar.dart';
import 'addsalary.dart';

class SalaryPage extends StatelessWidget {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SalaryController salaryController = Get.put(SalaryController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Obx(
          () {
            return SafeArea(
              child: Column(
                children: [
                  AppBarWidget("Salary", true, () {
                    Get.to(() => AddSalaryPage());
                  }, true, false),
                  (salaryController.isLoading.value)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(child: loadingWidget()),
                        )
                      : Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: SingleChildScrollView(
                              child: (salaryController.allsalaryList.isEmpty ==
                                      true)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Center(
                                        child: normaltext(
                                            "Salary details not available",
                                            RED),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
                                        for (var i
                                            in salaryController.allsalaryList)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Container(
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(60),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: GREY,
                                                  ),
                                                  top: BorderSide(
                                                    color: GREY,
                                                  ),
                                                  left: BorderSide(
                                                    color: GREY,
                                                  ),
                                                  right: BorderSide(
                                                    width: 6,
                                                    color: GREY,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      // width: 40,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: ORANGE,
                                                        // borderRadius:
                                                        //     BorderRadius
                                                        //         .circular(
                                                        //             20),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              i["Month"]
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                color: WHITE,
                                                              ),
                                                            ),
                                                            Text(
                                                              int.parse(i["Year"]
                                                                      .toString())
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  color: WHITE),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        normaltext(
                                                            i["StaffName"],
                                                            BLACK),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        smallText(
                                                          i["Designation"],
                                                          GREY_DARK,
                                                          FontWeight.normal,
                                                          TextAlign.left,
                                                        ),
                                                        const SizedBox(
                                                          height: 05,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            normaltext(
                                                                "Credited:",
                                                                GREEN),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            normaltext(
                                                                i["Basic_Salary"],
                                                                GREEN),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            salaryController
                                                                .deleteSalarySlip(
                                                                    i["Id"]);
                                                            salaryController
                                                                .update();
                                                          },
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                              Icons.delete,
                                                              size: 18,
                                                              color: RED,
                                                            ),
                                                          )),
                                                      // GestureDetector(
                                                      //     onTap: () {
                                                      //       salaryController
                                                      //           .gotoSalaryEdit(
                                                      //               i);
                                                      //       salaryController
                                                      //           .update();
                                                      //     },
                                                      //     child: const Padding(
                                                      //       padding:
                                                      //           EdgeInsets.all(
                                                      //               8.0),
                                                      //       child: Icon(
                                                      //         Icons.edit,
                                                      //         size: 18,
                                                      //         color: BLUE,
                                                      //       ),
                                                      //     )),
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
                        ),
                ],
              ),
            );
          },
        ),
      ),
      drawer: WeDrawer(),
      bottomNavigationBar: BottomNavigationBarWidget(2),
      floatingActionButton: FloatingActionButton(
        backgroundColor: BLUE,
        foregroundColor: WHITE,
        onPressed: () async {
          await Get.dialog(
            AlertDialog(
              title: titleText('Search Salary By Month', BLACK),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormFieldWidget(
                    controller: salaryController.searchMonth,
                    hinttext: "Select Month",
                    textColor: GREY_DARK,
                    readonly: false,
                    onTap: () {
                      showMonthPicker(
                        headerColor: BLUE,
                        selectedMonthBackgroundColor: BLUE,
                        unselectedMonthTextColor: BLUE,
                        hideHeaderRow: true,
                        lastDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 3650)),
                        confirmWidget: normaltext(
                          "OK",
                          BLUE,
                          FontWeight.bold,
                        ),
                        cancelWidget: normaltext(
                          "Cancel",
                          BLUE,
                          FontWeight.bold,
                        ),
                        context: Get.context!,
                        initialDate: DateTime.now(),
                      ).then((date) {
                        if (date != null) {
                          salaryController.searchMonthValue.value =
                              DateFormat.MMM().format(date);

                          salaryController.searchMonth.text =
                              salaryController.searchMonthValue.value;
                          print(salaryController.searchMonthValue.value);
                        }
                      });
                    },
                    prefixIcon: const Icon(
                      Icons.calendar_month,
                      color: GREY_DARK,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldWidget(
                    controller: salaryController.searchYear,
                    hinttext: "Select Year",
                    textColor: GREY_DARK,
                    readonly: false,
                    onTap: () async {
                      await showMonthPicker(
                        lastDate: DateTime.now(),
                        headerColor: BLUE,
                        selectedMonthBackgroundColor: BLUE,
                        unselectedMonthTextColor: BLUE,
                        yearFirst: true,
                        hideHeaderRow: true,
                        confirmWidget: normaltext(
                          "OK",
                          BLUE,
                          FontWeight.bold,
                        ),
                        cancelWidget: normaltext(
                          "Cancel",
                          BLUE,
                          FontWeight.bold,
                        ),
                        context: Get.context!,
                        initialDate: DateTime.now(),
                      ).then((date) {
                        if (date != null) {
                          salaryController.searchYearValue.value =
                              DateFormat.y().format(date);
                          salaryController.searchYear.text =
                              salaryController.searchYearValue.value;
                        }
                      });
                    },
                    prefixIcon: const Icon(
                      Icons.calendar_month,
                      color: GREY_DARK,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () => Get.back(canPop: false),
                  child: const Text(
                    'No',
                    style: TextStyle(color: BLUE),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BLUE)),
                  onPressed: () {
                    salaryController.filterByMonth(
                        salaryController.searchMonthValue.value,
                        salaryController.searchYearValue.value);
                    salaryController.update();
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: WHITE),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.filter_alt_sharp,
        ),
      ),
    );
  }
}
