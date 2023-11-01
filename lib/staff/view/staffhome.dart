import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/staff/controller/home.dart';
import 'package:hr/widget/dropdown.dart';

import '../../constant.dart';
import '../../widget/button.dart';
import '../../widget/popup.dart';
import '../../widget/staffappbarhome.dart';
import 'package:intl/intl.dart';

class StaffHomePage extends StatelessWidget {
  const StaffHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return WillPopScope(
      onWillPop: () async => onWillPopHome(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () {
            return (homeController.isLoading.value)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: loadingWidget()),
                  )
                : Stack(
                    children: <Widget>[
                      StaffHomeAppBarWidget(),
                      Positioned(
                        bottom: 0,
                        height: 500,
                        width: Get.width,
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: GREY_LIGHTER,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(40),
                                topLeft: Radius.circular(140),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0,
                                            vertical: 28.0,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: 255,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Center(
                                                              child: homeController
                                                                      .isLoading
                                                                      .value
                                                                  ? loadingWidget()
                                                                  : SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          const Icon(
                                                                            Icons.location_on,
                                                                            color:
                                                                                BLUE,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          normaltext(
                                                                              homeController.currentAddress!.value,
                                                                              BLUE),
                                                                        ],
                                                                      ),
                                                                    ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 150,
                                                          child: Card(
                                                            color: Colors.white,
                                                            elevation: 2,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal:
                                                                    17.0,
                                                                vertical: 34.0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'Punch In',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          Get.width /
                                                                              20,
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    homeController.punchIn.value ==
                                                                            "--/--"
                                                                        ? '--/--'
                                                                        : homeController
                                                                            .punchIn
                                                                            .value,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          24.0,
                                                                      color:
                                                                          GREEN,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          width: 150,
                                                          child: Card(
                                                            color: Colors.white,
                                                            elevation: 2,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal:
                                                                    17.0,
                                                                vertical: 34.0,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'Punch Out',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          Get.width /
                                                                              20,
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    homeController.punchOut.value ==
                                                                            '--/--'
                                                                        ? "--/--"
                                                                        : homeController
                                                                            .punchOut
                                                                            .value,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          24.0,
                                                                      color:
                                                                          RED,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  (homeController.punchIn.value != "--/--" &&
                                          homeController.punchOut.value !=
                                              "--/--")
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(top: 32),
                                          child: Text(
                                            "You have completed this day...!",
                                            style: TextStyle(
                                              fontSize: Get.width / 20,
                                              color: BLUE,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(
                                            left: Get.height / 30,
                                            right: Get.height / 30,
                                            top: Get.height / 15,
                                          ),
                                          child: ButtonWidget(
                                            onPressed: () async {
                                              await homeController
                                                  .getCurrentPosition();
                                              punchInandOutDialog();
                                            },
                                            text:
                                                homeController.punchIn.value ==
                                                        "--/--"
                                                    ? "Punch In"
                                                    : "Punch Out",
                                            buttonBorder: BLUE,
                                            buttonColor: BLUE,
                                            textcolor: WHITE,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}

punchInandOutDialog() {
  HomeController homeController = Get.put(HomeController());
  return Get.defaultDialog(
    title: "",
    backgroundColor: WHITE,
    radius: 10,
    content: Obx(
      () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            homeController.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: loadingWidget())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: RED,
                            ),
                          )
                        ],
                      ),
                      titleText(homeController.staffName.value, BLUE),
                      const SizedBox(
                        height: 10,
                      ),
                      normaltext(homeController.designation.value, GREY_DARK),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: GREY),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                normaltext("Date:", GREY_DARK),
                                const SizedBox(
                                  width: 2,
                                ),
                                normaltext(
                                    DateFormat('dd/MM/yyyy')
                                        .format(DateTime.now()),
                                    GREY_DARK),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        smallText("Punch In:", GREY_DARK),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        smallText(
                                            homeController.punchIn.toString(),
                                            GREEN),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        smallText("Punch Out:", GREY_DARK),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        smallText(
                                            homeController.punchOut.toString(),
                                            RED),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Icon(
                        Icons.location_on,
                        color: BLUE,
                        size: 28,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      titleText(homeController.currentAddress!.value, BLUE),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonWidget(
                        buttonBorder: BLUE,
                        buttonColor: BLUE,
                        textcolor: WHITE,
                        onPressed: () async {
                          if (homeController.punchIn.value == "--/--") {
                            await homeController.punchInFunc();
                            homeController.update();
                          } else if (homeController.punchOut.value == "--/--") {
                            await homeController.punchOutFunc();
                            homeController.update();
                          }
                        },
                        text: homeController.punchIn.value == "--/--"
                            ? "Punch In"
                            : "Punch Out",
                      )
                    ],
                  ),
          ],
        );
      },
    ),
  );
}
