import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class ListTileColumNameWidget extends StatelessWidget {
  final String clumnname1;

  final String clumnname2;
  final String clumnname3;

  const ListTileColumNameWidget(
    this.clumnname1, {
    this.clumnname2 = "",
    this.clumnname3 = "",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: GREY_LIGHTER,
          height: 60,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  clumnname1.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    color: BLUE,
                  ),
                ),
                // SizedBox(
                //   width: 45,
                // ),
                Text(
                  clumnname2.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    color: BLUE,
                  ),
                ),
                // SizedBox(
                //   width: 45,
                // ),
                Text(
                  clumnname3.toString(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 16,
                    color: BLUE,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
