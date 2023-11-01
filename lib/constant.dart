// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

const Color GREY = Color(0xffECF0F2);
const Color GREY_DARK = Color(0xff8a94a6);
const Color GREY_LIGHTER = Color(0xfff6f7f8);
const Color BLUE = Color(0xff5D5BD4);
const Color LightBLUE = Color.fromARGB(255, 242, 242, 245);
const Color WHITE = Color(0xffffffff);
const Color BLACK = Color(0xff000000);
const Color BUTTONCOLOR = Color(0xffB4B4BE);
const Color GREEN = Color(0xff81BC06);
const Color LIGHTGREEN = Color(0xffd0ffeb);
const Color ORANGE = Color(0xffFFBA08);
const Color PINK = Color(0xffFF7489);

const Color LIGHTORANGE = Color.fromARGB(255, 240, 219, 168);
const Color RED = Color(0xffF35325);
const Color LIGHTRED = Color(0xffffe7d3);

const Map<int, Color> COLOR = {
  50: Color.fromRGBO(161, 32, 64, .1),
  100: Color.fromRGBO(161, 32, 64, .2),
  200: Color.fromRGBO(161, 32, 64, .3),
  300: Color.fromRGBO(161, 32, 64, .4),
  400: Color.fromRGBO(161, 32, 64, .5),
  500: Color.fromRGBO(161, 32, 64, .6),
  600: Color.fromRGBO(161, 32, 64, .7),
  700: Color.fromRGBO(161, 32, 64, .8),
  800: Color.fromRGBO(161, 32, 64, .9),
  900: Color.fromRGBO(161, 32, 64, 1),
};
Text titleText(text, Color color, [align = TextAlign.center]) {
  return Text(text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ));
}

Text smallText(text, Color color,
    [FontWeight wt = FontWeight.normal, align = TextAlign.center]) {
  return Text(
    text,
    textAlign: (align == "") ? TextAlign.left : align,
    style: TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: wt,
    ),
  );
}

Text buttontext(text, Color color, Color bgcolor, [align = TextAlign.center]) {
  return Text(
    text,
    textAlign: (align == "") ? TextAlign.center : align,
    style: TextStyle(
        color: color,
        backgroundColor: bgcolor,
        fontSize: 18,
        fontWeight: FontWeight.bold),
  );
}

Text normaltext(text, Color color,
    [FontWeight wt = FontWeight.normal, align = TextAlign.left]) {
  return Text(
    text,
    textAlign: (align == "") ? TextAlign.left : align,
    style: TextStyle(color: color, fontSize: 14, fontWeight: wt),
  );
}

flutterToastMsg(String txt) {
  return ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      backgroundColor: ORANGE,
      duration: Duration(seconds: 2),
      content: normaltext(
        txt,
        WHITE,
      ),
    ),
  );
}

loadingWidget() {
  return SizedBox(
    height: 25,
    width: 25,
    child: CircularProgressIndicator(
      color: BLUE,
      strokeWidth: 2,
    ),
  );
}

RxString companyname = "".obs;
RxString emailid = "".obs;
RxString companyLogo = "".obs;
RxBool isOtherValue = false.obs;
