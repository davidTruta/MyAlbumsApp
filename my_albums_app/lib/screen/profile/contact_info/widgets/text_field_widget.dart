import 'package:flutter/material.dart';

import '../../../../theming/dimensions.dart';


class TextFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String title;
  final TextEditingController controller;
  final Map<String, dynamic> validationErrors;
  final FocusNode? focusNode;
  final FocusNode? toFocus;

  const TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.validationErrors,
      required this.focusNode,
      this.textInputType,
      required this.title,
      this.toFocus})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  InputDecoration _getInputDecoration([String? title]) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
          color: widget.validationErrors['validationError'] == ''
              ? Theme.of(context).primaryColor
              : Theme.of(context).errorColor,
          width: textFieldBorderThickness),
    );
    return InputDecoration(
        contentPadding: noPadding,
        floatingLabelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: title != null
            ? Text(
                title,
                style: widget.validationErrors['validationError'] == ''
                    ? Theme.of(context).textTheme.labelMedium
                    : TextStyle(color: Theme.of(context).errorColor),
              )
            : null,
        enabledBorder: border,
        focusedBorder: border);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          style: Theme.of(context).textTheme.labelSmall,
          decoration: _getInputDecoration(widget.title),
          onEditingComplete: () {
            if (widget.toFocus != null) {
              widget.toFocus!.requestFocus();
            }
          },
          focusNode: widget.focusNode,
          onChanged: (str) {
            setState(() {
              widget.validationErrors['validationError'] = '';
            });
          },

        ),
        if (widget.validationErrors['validationError'] != '')
          IgnorePointer(
            ignoring: true,
            child: Column(
              children: [
                normalVerticalDistance,
                Text(
                  widget.validationErrors['validationError']!,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
