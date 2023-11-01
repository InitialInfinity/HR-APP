import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hr/company/companyregister.dart';
import 'package:hr/forgotpassword.dart';
import 'package:hr/logincontroller.dart';
import 'package:hr/widget/textformfield.dart';
import 'company/view/profile/comapanymaster.dart';
import 'constant.dart';
import 'location.dart';
import 'service.dart';
import 'widget/button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () {
          return SafeArea(
            child: FormBuilder(
              key: loginController.fbKeyLogin,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: Get.height / 2.5,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: BLUE,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(
                            100,
                          ),
                          topLeft: Radius.circular(
                            100,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  loginController.lType.value = "Companay";
                                  loginController.loginType();
                                  loginController.update();
                                },
                                child: Container(
                                  height: 100,
                                  width: 110,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: loginController
                                            .selectLoginTypeCompany.value
                                        ? WHITE
                                        : BLUE,
                                    border: Border.all(
                                      color: WHITE,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(
                                        30,
                                      ),
                                      topLeft: Radius.circular(
                                        30,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.business,
                                        color: loginController
                                                .selectLoginTypeCompany.value
                                            ? BLUE
                                            : WHITE,
                                        size: 40,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Company",
                                            style: TextStyle(
                                              color: loginController
                                                      .selectLoginTypeCompany
                                                      .value
                                                  ? BLUE
                                                  : WHITE,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  loginController.lType.value = "STAFF";
                                  loginController.loginType();

                                  loginController.update();
                                },
                                child: Container(
                                  height: 100,
                                  width: 110,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: loginController
                                            .selectLoginTypeStaff.value
                                        ? WHITE
                                        : BLUE,
                                    border: Border.all(
                                      color: WHITE,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(
                                        30,
                                      ),
                                      topLeft: Radius.circular(
                                        30,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        color: loginController
                                                .selectLoginTypeStaff.value
                                            ? BLUE
                                            : WHITE,
                                        size: 40,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Staff",
                                            style: TextStyle(
                                              color: loginController
                                                      .selectLoginTypeStaff
                                                      .value
                                                  ? BLUE
                                                  : WHITE,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: Get.height / 15, bottom: Get.height / 20),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: Get.width / 18,
                          color: BLUE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(
                        horizontal: Get.width / 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormFieldWidget(
                            hinttext: "Mobile No",
                            controller: loginController.mobileController,
                            errortext: "Enter Mobile No",
                            keyboardType: TextInputType.phone,
                            inputFormatter: r'[0-9]',
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: BLUE,
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            hinttext: "Password",
                            controller: loginController.passwordController,
                            errortext: "Enter password",
                            keyboardType: TextInputType.visiblePassword,
                            inputFormatter: r'[a-z A-Z 0-9 @.&,!#]',
                            isPassword: true,
                            obscureText: !Service.showPass.value,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: BLUE,
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              smallText(
                                "Forgot Password ?",
                                GREY_DARK,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => ForgotPasswordPage(
                                        loginController.roleController.text));
                                    loginController.update();
                                  },
                                  child: smallText("Click Here", RED))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: Get.height / 30,
                        right: Get.height / 30,
                        top: Get.height / 15,
                      ),
                      child: (loginController.isLoading.value)
                          ? loadingWidget()
                          : ButtonWidget(
                              onPressed: () {
                                loginController.login();
                                loginController.update();
                              },
                              text: "Login",
                              buttonBorder: BLUE,
                              buttonColor: BLUE,
                              textcolor: WHITE,
                            ),
                    ),
                    (loginController.selectLoginTypeCompany.value == true)
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Not an existing user?",
                                  style: TextStyle(
                                    color: BLUE,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (loginController
                                            .selectLoginTypeCompany.value ==
                                        true) {
                                      Get.to(() => const CompanyRegisterPage());
                                    } else {
                                      flutterToastMsg(
                                          "This is valid only for company.");
                                    }
                                  },
                                  child: const Text(
                                    "Register here",
                                    style: TextStyle(
                                        color: BLUE,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
