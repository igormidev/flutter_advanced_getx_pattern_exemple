import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0.wp,
      width: 30.0.wp,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
