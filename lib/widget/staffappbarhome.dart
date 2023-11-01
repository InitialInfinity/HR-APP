import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/changepassword.dart';
import 'package:hr/logincontroller.dart';
import 'package:hr/login.dart';
import 'package:hr/staff/controller/home.dart';

import '../constant.dart';
import '../service.dart';
import '../staff/view/staffLeave/leave.dart';
import '../staff/view/staffprofile.dart';
import '../staff/view/staffsalary/staffsalary.dart';
import 'popup.dart';

class StaffHomeAppBarWidget extends StatelessWidget {
  StaffHomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Obx(
      () {
        return Positioned(
          top: 0,
          height: Get.height,
          width: Get.width,
          child: SizedBox(
            width: double.infinity,
            height: 110,
            child: Container(
              height: 130,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 0),
                  ),
                ],
                color: BLUE,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PopupMenuButton<int>(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            itemBuilder: (context) => buildPopupMenu(context),
                            offset: const Offset(-10, 30),
                            //color: Colors.white,
                            elevation: 2,
                            onSelected: (value) {
                              if (value == 0) {
                                Get.to(() => const StaffLeaveMasterPage());
                              } else if (value == 1) {
                                Get.to(() => const StaffProfile());
                              } else if (value == 2) {
                                Get.to(() => const StaffSalaryPage());
                              } else if (value == 3) {
                                Get.to(() => const ChangePasswordPage());
                              } else if (value == 4) {
                                showMyDialog("", "Are you sure want to ",
                                    "Logout ", "Logout", () {
                                  Service.logout();
                                });
                              }
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CircleAvatar(
                            //   radius: 50,
                            //   backgroundColor: BLUE,
                            //   backgroundImage:
                            //       AssetImage('assets/images/profile.jpg'),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              "Welcome, " + homeController.staffName.value,
                              style: const TextStyle(
                                color: WHITE,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              homeController.designation.value,
                              style: const TextStyle(
                                color: ORANGE,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              homeController.emailid.value,
                              style: const TextStyle(
                                color: GREY_DARK,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Good ${homeController.dailystatus.value}...",
                              style: const TextStyle(
                                color: WHITE,
                                fontWeight: FontWeight.w600,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

PopupMenuEntry<int> buildPopupMenuItem(
    String text, BuildContext context, int value) {
  return PopupMenuItem(
    value: value,
    child: Text(
      text,
      style: TextStyle(
          // fontSize: 14,
          color: (text == "Logout") ? RED : BLUE),
    ),
  );
}

List<PopupMenuEntry<int>> buildPopupMenu(BuildContext context) {
  List<PopupMenuEntry<int>> list = [];
  list.add(buildPopupMenuItem("Leave History", context, 0));
  list.add(buildPopupMenuItem("Profile", context, 1));
  list.add(buildPopupMenuItem("Salary Slip", context, 2));
  list.add(buildPopupMenuItem("Change Password", context, 3));
  list.add(buildPopupMenuItem("Logout", context, 4));
  return list;
}
