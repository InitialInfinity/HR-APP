import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/company/controller/leave.dart';
import 'package:hr/widget/appbar.dart';
import 'package:hr/widget/bottomnavigationbar.dart';
import 'package:hr/widget/drawer.dart';

import '../../../constant.dart';

class LeaveApprovalList extends StatelessWidget {
  const LeaveApprovalList({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveController leaveController = Get.put(LeaveController());
    return Scaffold(
      body: Obx(
        () {
          return SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: Get.height),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    AppBarWidget(
                        "Leave Approval Status", false, () {}, true, false),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(top: 10),
                        children:
                            ListTile.divideTiles(context: context, tiles: [
                          for (var i in leaveController.leaveListAdmin)
                            ListTile(
                              visualDensity: const VisualDensity(vertical: 4),
                              leading: CircleAvatar(
                                  backgroundColor:
                                      (i["Approval_St"] == "Approve")
                                          ? GREEN
                                          : (i["Approval_St"] == "Reject")
                                              ? RED
                                              : ORANGE,
                                  child: Icon(
                                    (i["Approval_St"] == "Approve")
                                        ? Icons.check
                                        : (i["Approval_St"] == "Reject")
                                            ? Icons.close
                                            : Icons.info,
                                    color: WHITE,
                                    size: 20,
                                  )),
                              title: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: i["StaffName"] + " ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const TextSpan(
                                        text: 'Applied For',
                                        style: TextStyle(fontSize: 14)),
                                    TextSpan(
                                      text: ' ' + i["LeaveType"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const TextSpan(
                                        text: ' from',
                                        style: TextStyle(fontSize: 14)),
                                    TextSpan(
                                      text: ' ' + i["FromDate"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    const TextSpan(
                                        text: ' to',
                                        style: TextStyle(fontSize: 14)),
                                    TextSpan(
                                      text: ' ' + i["ToDate"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      smallText(
                                        i["ApplicationDate"],
                                        GREY_DARK,
                                        FontWeight.normal,
                                        TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      normaltext(
                                        (i["Approval_St"] == "Approve")
                                            ? "Approved Successfully"
                                            : (i["Approval_St"] == "Reject")
                                                ? "Rejected"
                                                : "Pending",
                                        (i["Approval_St"] == "Approve")
                                            ? GREEN
                                            : (i["Approval_St"] == "Reject")
                                                ? RED
                                                : GREY_DARK,
                                        FontWeight.normal,
                                        TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ]).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      drawer: WeDrawer(),
      bottomNavigationBar: BottomNavigationBarWidget(0),
    );
  }
}
