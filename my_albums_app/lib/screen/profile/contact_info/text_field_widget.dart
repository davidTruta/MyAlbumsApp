import 'package:flutter/material.dart';

import '../../../theming/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;

  const TextFieldWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: TextField(
        style: Theme.of(context).textTheme.labelSmall,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          floatingLabelStyle: Theme.of(context).textTheme.labelMedium,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}
