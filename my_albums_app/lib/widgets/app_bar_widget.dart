import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? leading;

  const AppBarWidget(
      {Key? key,
      required this.title,
      this.centerTitle,
      this.backgroundColor,
      this.foregroundColor,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Theme.of(context).colorScheme.outline,
          height: 1,
        ),
      ),
      title: title,
      centerTitle: centerTitle ?? true,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
