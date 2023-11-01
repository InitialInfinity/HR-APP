import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class ListTileWidget extends StatelessWidget {
  final String name;

  final String contactno;

  final Function? onTap;
  final Function? onTapEdit;
  final Function? onTapDelete;
  final Color? color;
  const ListTileWidget({
    this.contactno = "",
    this.name = "",
    this.onTap,
    this.onTapEdit,
    this.onTapDelete,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(color: color),
              height: 60,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Text(
                //       name,
                //       textAlign: TextAlign.left,
                //       style: const TextStyle(),
                //     ),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Text(
                //               contactno.toString(),
                //               textAlign: TextAlign.left,
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         Row(
                //           children: [
                //             GestureDetector(
                //               onTap: () {
                //                 onTapEdit!.call();
                //               },
                //               child: Icon(
                //                 Icons.edit_outlined,
                //                 size: 20,
                //               ),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             GestureDetector(
                //               onTap: () {
                //                 onTapDelete!.call();
                //               },
                //               child: const Icon(
                //                 Icons.delete,
                //                 size: 20,
                //                 color: RED,
                //               ),
                //             )
                //           ],
                //         )
                //       ],
                //     )
                //   ],
                // ),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: const TableBorder(
                    bottom: BorderSide(color: GREY),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(4),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Text(
                            name,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Text(
                            contactno,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                onTapEdit!.call();
                              },
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                onTapDelete!.call();
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 20,
                                color: RED,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              onTap!.call();
            },
          ),
        ),
      ],
    );
  }
}
