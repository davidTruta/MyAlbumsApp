import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';

class TempScreen extends StatelessWidget {
  static const routeName = '/temp-screen';

  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title:
        Text('Temp Screen', style: Theme.of(context).textTheme.headlineSmall),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: false,
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Delete this :) !'),
        ],
      )),
    );
  }
}
