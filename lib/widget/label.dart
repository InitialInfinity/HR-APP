import 'package:flutter/material.dart';

import '../constant.dart';

class LabelWidget extends StatelessWidget {
  String label = "";

  LabelWidget(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 3.0),
          child: normaltext(label.toString(), GREY_DARK),
        ),
      ],
    );
  }
}
