import 'package:flutter/material.dart';
import '../constant.dart';

class BackButtonWidget extends StatelessWidget {
  final Function() onPressed;

  final double? width;
  final Color? buttonColor;
  final Color buttonBorder;
  final double? buttonHeight;
  final Color? textcolor;
  const BackButtonWidget({
    Key? key,
    required this.onPressed,
    this.width,
    this.buttonColor = BUTTONCOLOR,
    this.buttonBorder = BUTTONCOLOR,
    this.buttonHeight,
    this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: WHITE,
      backgroundColor: BLUE,
      onPressed: () {
        onPressed.call();
      },
      child: Icon(
        Icons.arrow_back_ios_new,
      ),
    );
  }
}
