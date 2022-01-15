import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final String text;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0.hp),
      height: 5.2.hp,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        child: boldText(
          text,
          color: Colors.white,
        ),
      ),
    );
  }
}
