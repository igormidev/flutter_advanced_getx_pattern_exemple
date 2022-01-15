import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool onlyNumbers;
  final bool isUnlimitedText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomField({
    Key? key,
    required this.controller,
    required this.label,
    this.isUnlimitedText = false,
    this.onlyNumbers = false,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isUnlimitedText
        ? ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 150),
            child: TextFormField(
              validator: validator,
              keyboardType: onlyNumbers
                  ? TextInputType.number
                  : TextInputType.emailAddress,
              controller: controller,
              onChanged: onChanged,
              maxLines: null,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: label,
              ),
            ),
          )
        : TextFormField(
            validator: validator,
            controller: controller,
            onChanged: onChanged,
            keyboardType:
                onlyNumbers ? TextInputType.number : TextInputType.emailAddress,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
            ),
          );
  }
}
