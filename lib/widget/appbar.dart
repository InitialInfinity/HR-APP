import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

class AppBarWidget extends StatelessWidget {
  String title = "";
  bool addbutton = false;
  bool menubutton = false;
  bool back = false;

  final Function? onTapAdd;

  AppBarWidget(
      this.title, this.addbutton, this.onTapAdd, this.menubutton, this.back,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          color: BLUE,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  (menubutton == true)
                      ? IconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          icon: const Icon(
                            Icons.menu,
                            color: WHITE,
                          ),
                        )
                      // : (back == true)
                      //     ? IconButton(
                      //         onPressed: () {
                      // Get.back();
                      //         },
                      //         icon: const Icon(
                      //           Icons.arrow_back,
                      //           color: WHITE,
                      //         ),
                      //       )
                      : const SizedBox(
                          width: 40,
                        ),
                  // (back == true)
                  //     ? IconButton(
                  //         onPressed: () => () {
                  //           Get.back();
                  //         },
                  //         icon: const Icon(
                  //           Icons.arrow_back,
                  //           color: WHITE,
                  //         ),
                  //       )
                  //     : const SizedBox(),
                  Text(
                    title.toString(),
                    style: const TextStyle(color: WHITE),
                  ),
                ],
              )
            ],
          ),
          (addbutton == true)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        onTapAdd!.call();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: WHITE,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
