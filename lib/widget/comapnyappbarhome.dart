import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/service.dart';

import '../company/controller/profile.dart';
import '../constant.dart';

class CompanyHomeAppBarWidget extends StatelessWidget {
  const CompanyHomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    Uint8List convertBase64Image(String base64String) {
      return const Base64Decoder().convert(base64String.split(',').last);
    }

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(
                        Icons.menu,
                        color: WHITE,
                      ),
                    ),
                    // const SizedBox(),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.settings,
                    //     color: WHITE,
                    //   ),
                    // )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (profileController.companyLogoImage.value == "")
                            ? const CircleAvatar(
                                foregroundColor: Colors.transparent,
                                radius: 40,
                                // minRadius: 70,
                                backgroundImage: AssetImage(
                                  'assets/images/profile.jpg',
                                ),
                              )
                            : Container(
                                height: 80,
                                width: 80,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: WHITE,
                                ),
                                child: ClipOval(
                                  child: Image.memory(
                                    convertBase64Image(
                                      profileController.companyLogoImage.value,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Hi ${profileController.companyName.text}",
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
                          "Good ${profileController.dailystatus.value} ...",
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
  }
}
