import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/profile.dart';

import '../../constant.dart';
import '../../widget/comapnyappbarhome.dart';
import '../../widget/bottomnavigationbar.dart';
import '../../widget/drawer.dart';
import '../../widget/popup.dart';

class CompanyHomePage extends StatelessWidget {
  const CompanyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return WillPopScope(
      onWillPop: () async => onWillPopHome(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () {
            return profileController.isLoading.value
                ? Center(
                    child: loadingWidget(),
                  )
                : Stack(
                    children: <Widget>[
                      const CompanyHomeAppBarWidget(),
                      Positioned(
                        bottom: 0,
                        height: 450,
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
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          color: WHITE,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  barrierColor: BLUE,
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      title: titleText(
                                                        "Today's Present",
                                                        BLACK,
                                                        TextAlign.center,
                                                      ),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: (profileController
                                                                    .onPresent
                                                                    .isEmpty ==
                                                                true)
                                                            ? normaltext(
                                                                "There is no present",
                                                                RED,
                                                                FontWeight
                                                                    .normal,
                                                                TextAlign
                                                                    .center)
                                                            : Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  for (var i
                                                                      in profileController
                                                                          .onPresent)
                                                                    ListTile(
                                                                      leading:
                                                                          const Icon(
                                                                        Icons
                                                                            .calendar_month,
                                                                        color:
                                                                            BLUE,
                                                                      ),
                                                                      title:
                                                                          normaltext(
                                                                        i['StaffName']
                                                                            .toString(),
                                                                        BLACK,
                                                                        FontWeight
                                                                            .bold,
                                                                      ),
                                                                      subtitle:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          smallText(
                                                                            i['Designation'].toString(),
                                                                            GREY_DARK,
                                                                            FontWeight.normal,
                                                                            TextAlign.left,
                                                                          ),
                                                                          const Divider(
                                                                            color:
                                                                                GREY_DARK,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              smallText("In Time:", GREY_DARK),
                                                                              smallText(i["InTime"], GREY_DARK)
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              smallText("Out Time:", GREY_DARK),
                                                                              smallText((i["OutTime"] == null) ? "--/--" : i["OutTime"], GREY_DARK)
                                                                            ],
                                                                          ),
                                                                          const Divider(
                                                                            color:
                                                                                GREY_DARK,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              smallText(
                                                                                "In Distance:",
                                                                                GREY_DARK,
                                                                              ),
                                                                              smallText(
                                                                                (i["InDistance"] == null)
                                                                                    ? "--/--"
                                                                                    : (i["InDistance"].toString() == "0")
                                                                                        ? "0"
                                                                                        : i["InDistance"].toString().substring(0, 6),
                                                                                GREY_DARK,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              smallText(
                                                                                "Out Distance:",
                                                                                GREY_DARK,
                                                                              ),
                                                                              smallText(
                                                                                (i["OutDistance"] == null)
                                                                                    ? "--/--"
                                                                                    : i["OutDistance"].toString() == "0"
                                                                                        ? "0"
                                                                                        : i["OutDistance"].toString().substring(0, 6),
                                                                                GREY_DARK,
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                ],
                                                              ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                decoration: const BoxDecoration(
                                                  color: GREEN,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    profileController
                                                        .presentCount.value,
                                                    style: const TextStyle(
                                                      fontSize: 28,
                                                      color: WHITE,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            titleText(
                                              "Present",
                                              BLACK,
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            barrierColor: BLUE,
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: titleText(
                                                  "Today's Absent",
                                                  BLACK,
                                                  TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: (profileController
                                                              .onAbsent
                                                              .isEmpty ==
                                                          true)
                                                      ? normaltext(
                                                          "There is no absent",
                                                          RED,
                                                          FontWeight.normal,
                                                          TextAlign.center)
                                                      : Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            for (var i
                                                                in profileController
                                                                    .onAbsent)
                                                              ListTile(
                                                                leading:
                                                                    const Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  color: BLUE,
                                                                ),
                                                                title:
                                                                    normaltext(
                                                                  i['StaffName']
                                                                      .toString(),
                                                                  BLACK,
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                                subtitle:
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    smallText(
                                                                      i['Designation']
                                                                          .toString(),
                                                                      GREY_DARK,
                                                                      FontWeight
                                                                          .normal,
                                                                      TextAlign
                                                                          .left,
                                                                    ),
                                                                    const Divider(
                                                                      color:
                                                                          GREY_DARK,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                            "In Time:",
                                                                            GREY_DARK),
                                                                        smallText(
                                                                            i["InTime"],
                                                                            GREY_DARK)
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                            "Out Time:",
                                                                            GREY_DARK),
                                                                        smallText(
                                                                            (i["OutTime"] == null)
                                                                                ? "--/--"
                                                                                : i["OutTime"],
                                                                            GREY_DARK)
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      color:
                                                                          GREY_DARK,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                          "In Distance:",
                                                                          GREY_DARK,
                                                                        ),
                                                                        smallText(
                                                                          i["InDistance"].toString().substring(
                                                                              0,
                                                                              6),
                                                                          GREY_DARK,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                          "Out Distance:",
                                                                          GREY_DARK,
                                                                        ),
                                                                        smallText(
                                                                          (i["OutDistance"] == null)
                                                                              ? "--/--"
                                                                              : i["OutDistance"].toString().substring(0, 6),
                                                                          GREY_DARK,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 130,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: WHITE,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: const BoxDecoration(
                                                  color: RED,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  profileController
                                                      .absentCount.value,
                                                  style: const TextStyle(
                                                    fontSize: 28,
                                                    color: WHITE,
                                                  ),
                                                )),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              titleText("Absent", BLACK),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            barrierColor: BLUE,
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: titleText(
                                                  "Today's On Leave",
                                                  BLACK,
                                                  TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: (profileController
                                                              .onLeave
                                                              .isEmpty ==
                                                          true)
                                                      ? normaltext(
                                                          "There is no one on leave",
                                                          RED,
                                                          FontWeight.normal,
                                                          TextAlign.center)
                                                      : Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            for (var i
                                                                in profileController
                                                                    .onLeave)
                                                              ListTile(
                                                                leading:
                                                                    const Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  color: BLUE,
                                                                ),
                                                                title:
                                                                    normaltext(
                                                                  i['StaffName']
                                                                      .toString(),
                                                                  BLACK,
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                                subtitle:
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    smallText(
                                                                      i['Designation']
                                                                          .toString(),
                                                                      GREY_DARK,
                                                                      FontWeight
                                                                          .normal,
                                                                      TextAlign
                                                                          .left,
                                                                    ),
                                                                    const Divider(
                                                                      color:
                                                                          GREY_DARK,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                            "In Time:",
                                                                            GREY_DARK),
                                                                        smallText(
                                                                            i["InTime"],
                                                                            GREY_DARK)
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                            "Out Time:",
                                                                            GREY_DARK),
                                                                        smallText(
                                                                            (i["OutTime"] == null)
                                                                                ? "--/--"
                                                                                : i["OutTime"],
                                                                            GREY_DARK)
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      color:
                                                                          GREY_DARK,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                          "In Distance:",
                                                                          GREY_DARK,
                                                                        ),
                                                                        smallText(
                                                                          i["InDistance"].toString().substring(
                                                                              0,
                                                                              6),
                                                                          GREY_DARK,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                          "Out Distance:",
                                                                          GREY_DARK,
                                                                        ),
                                                                        smallText(
                                                                          (i["OutDistance"] == null)
                                                                              ? "--/--"
                                                                              : i["OutDistance"].toString().substring(0, 6),
                                                                          GREY_DARK,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 130,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: WHITE,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: const BoxDecoration(
                                                  color: ORANGE,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  profileController
                                                      .onLeaveCount.value,
                                                  style: const TextStyle(
                                                    fontSize: 28,
                                                    color: WHITE,
                                                  ),
                                                )),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              titleText("On Leave", BLACK),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            barrierColor: BLUE,
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: titleText(
                                                  "Today's WFH",
                                                  BLACK,
                                                  TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: (profileController
                                                              .onWFH.isEmpty ==
                                                          true)
                                                      ? normaltext(
                                                          "There is no one on WFH",
                                                          RED,
                                                          FontWeight.normal,
                                                          TextAlign.center)
                                                      : Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            for (var i
                                                                in profileController
                                                                    .onWFH)
                                                              ListTile(
                                                                leading:
                                                                    const Icon(
                                                                  Icons
                                                                      .calendar_month,
                                                                  color: BLUE,
                                                                ),
                                                                title:
                                                                    normaltext(
                                                                  i['StaffName']
                                                                      .toString(),
                                                                  BLACK,
                                                                  FontWeight
                                                                      .bold,
                                                                ),
                                                                subtitle:
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    smallText(
                                                                      i['Designation']
                                                                          .toString(),
                                                                      GREY_DARK,
                                                                      FontWeight
                                                                          .normal,
                                                                      TextAlign
                                                                          .left,
                                                                    ),
                                                                    const Divider(
                                                                      color:
                                                                          GREY_DARK,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                            "In Time:",
                                                                            GREY_DARK),
                                                                        smallText(
                                                                            i["InTime"],
                                                                            GREY_DARK)
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                            "Out Time:",
                                                                            GREY_DARK),
                                                                        smallText(
                                                                            (i["OutTime"] == null)
                                                                                ? "--/--"
                                                                                : i["OutTime"],
                                                                            GREY_DARK)
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      color:
                                                                          GREY_DARK,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                          "In Distance:",
                                                                          GREY_DARK,
                                                                        ),
                                                                        smallText(
                                                                          i["InDistance"].toString().substring(
                                                                              0,
                                                                              6),
                                                                          GREY_DARK,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        smallText(
                                                                          "Out Distance:",
                                                                          GREY_DARK,
                                                                        ),
                                                                        smallText(
                                                                          (i["OutDistance"] == null)
                                                                              ? "--/--"
                                                                              : i["OutDistance"].toString().substring(0, 6),
                                                                          GREY_DARK,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 130,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            color: WHITE,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                decoration: const BoxDecoration(
                                                  color: BLUE,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    profileController
                                                        .wfhCount.value,
                                                    style: const TextStyle(
                                                      fontSize: 28,
                                                      color: WHITE,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              titleText("WFH", BLACK),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            barrierColor: BLUE,
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: titleText(
                                                  "Upcoming Birthday's",
                                                  BLACK,
                                                  TextAlign.center,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      for (var i
                                                          in profileController
                                                              .birthday)
                                                        ListTile(
                                                          leading: const Icon(
                                                            Icons.cake,
                                                            color: ORANGE,
                                                          ),
                                                          title: normaltext(
                                                            i['StaffName']
                                                                .toString(),
                                                            BLACK,
                                                            FontWeight.bold,
                                                          ),
                                                          subtitle: smallText(
                                                            i['Designation']
                                                                .toString(),
                                                            GREY_DARK,
                                                            FontWeight.normal,
                                                            TextAlign.justify,
                                                          ),
                                                          trailing: smallText(
                                                            i['DOB'].toString(),
                                                            GREY_DARK,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 160,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: WHITE,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                normaltext(
                                                  "Birthday's",
                                                  BLACK,
                                                  FontWeight.bold,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                const Icon(
                                                  Icons.cake,
                                                  color: ORANGE,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            barrierColor: BLUE,
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: titleText(
                                                    "Work Anniversary",
                                                    BLACK,
                                                    TextAlign.center),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      for (var i
                                                          in profileController
                                                              .workAnniversary)
                                                        ListTile(
                                                          leading: const Icon(
                                                            Icons.celebration,
                                                            color: RED,
                                                          ),
                                                          title: normaltext(
                                                            i['StaffName']
                                                                .toString(),
                                                            BLACK,
                                                            FontWeight.bold,
                                                          ),
                                                          subtitle: smallText(
                                                            i['Designation']
                                                                .toString(),
                                                            GREY_DARK,
                                                            FontWeight.normal,
                                                            TextAlign.justify,
                                                          ),
                                                          trailing: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              smallText(
                                                                "Since Year ${i['YearsSinceJoining']}",
                                                                GREY_DARK,
                                                              ),
                                                              smallText(
                                                                i['DateOfJoining'],
                                                                GREY_DARK,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 160,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: WHITE,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                normaltext(
                                                  "Work Anniversary",
                                                  BLACK,
                                                  FontWeight.bold,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                const Icon(
                                                  Icons.celebration,
                                                  color: RED,
                                                )
                                              ],
                                            ),
                                          ),
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
                    ],
                  );
          },
        ),
        bottomNavigationBar: BottomNavigationBarWidget(0),
        drawer: WeDrawer(),
      ),
    );
  }
}
