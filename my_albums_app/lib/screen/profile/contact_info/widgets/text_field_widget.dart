import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_view_model.dart';

import '../../../../theming/dimensions.dart';

class TextFieldWidget extends StatefulWidget {
  final TextInputType? textInputType;
  final String title;
  final TextEditingController controller;
  final MyString validationErrors;
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
          color: widget.validationErrors.value == ''
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
                style: widget.validationErrors.value == ''
                    ? Theme.of(context).textTheme.labelMedium
                    : TextStyle(color: Theme.of(context).errorColor),
              )
            : null,
        enabledBorder: border,
        focusedBorder: border);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.focusNode != null) widget.focusNode!.dispose();
    if (widget.toFocus != null) widget.toFocus!.dispose();
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
              widget.validationErrors.value = '';
            });
          },
        ),
        if (widget.validationErrors.value != '')
          IgnorePointer(
            ignoring: true,
            child: Column(
              children: [
                normalVerticalDistance,
                Text(
                  widget.validationErrors.value,
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
