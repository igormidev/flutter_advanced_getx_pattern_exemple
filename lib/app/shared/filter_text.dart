import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';

class FilterText extends StatelessWidget {
  final String text;
  final String filterText;
  final String? choisedText;
  final List<String> listOfChoises;
  final void Function(String?)? onChanged;
  const FilterText({
    required this.text,
    required this.filterText,
    required this.choisedText,
    required this.listOfChoises,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        boldText(text),
        DropdownButton<String>(
          hint: Text(filterText),
          value: choisedText,
          items: listOfChoises.map((item) {
            return DropdownMenuItem(
              value: item,
              child: boldText(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
