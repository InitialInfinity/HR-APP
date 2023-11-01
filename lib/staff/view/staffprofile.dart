import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/staff/controller/home.dart';
import 'package:hr/widget/appbar.dart';

import '../../constant.dart';
import '../../widget/popup.dart';

class StaffProfile extends StatelessWidget {
  const StaffProfile({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: GREY_LIGHTER,
        body: SafeArea(
          child: Obx(
            () {
              return (homeController.isLoading.value)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: loadingWidget()),
                    )
                  : Column(
                      children: [
                        AppBarWidget(
                            "Staff Details", false, () {}, false, false),
                        Container(
                          width: Get.width,
                          decoration: const BoxDecoration(color: WHITE),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Center(
                                      child: Icon(
                                        Icons.person,
                                        color: BLUE,
                                        size: 60,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        titleText(
                                            homeController.staffName.value,
                                            BLUE),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        normaltext(
                                            homeController.designation.value,
                                            ORANGE),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        smallText(homeController.emailid.value,
                                            GREY_DARK),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Get.width,
                                        decoration:
                                            const BoxDecoration(color: BLUE),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              normaltext(
                                                "Personal Details",
                                                WHITE,
                                                FontWeight.bold,
                                                TextAlign.justify,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "Staff Id",
                                            GREY_DARK,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          normaltext(
                                            homeController.empid.value,
                                            BLUE,
                                            FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "Address",
                                            GREY_DARK,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          normaltext(
                                            homeController.address.value,
                                            BLUE,
                                            FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "Date Of Birth",
                                            GREY_DARK,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          normaltext(
                                            homeController.dob.value,
                                            BLUE,
                                            FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "Date Of Joining",
                                            GREY_DARK,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          normaltext(
                                            homeController.doj.value,
                                            BLUE,
                                            FontWeight.bold,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "Basic Salary",
                                            GREY_DARK,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          smallText(
                                              homeController.basicsalary.value,
                                              BLUE,
                                              FontWeight.bold),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    width: Get.width,
                                    decoration:
                                        const BoxDecoration(color: BLUE),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          normaltext(
                                            "Other Details",
                                            WHITE,
                                            FontWeight.bold,
                                            TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "PF No",
                                            GREY_DARK,
                                          ),
                                          normaltext(homeController.pfNo.value,
                                              BLUE, FontWeight.bold),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "Account No",
                                            GREY_DARK,
                                          ),
                                          normaltext(
                                            homeController.accountNo.value,
                                            BLUE,
                                            FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "ESIC No",
                                            GREY_DARK,
                                          ),
                                          normaltext(
                                            homeController.esic.value,
                                            BLUE,
                                            FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          smallText(
                                            "Working Hours",
                                            GREY_DARK,
                                          ),
                                          normaltext(
                                            homeController.workinghours.value,
                                            BLUE,
                                            FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
