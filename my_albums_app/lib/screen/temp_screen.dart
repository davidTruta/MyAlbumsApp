import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  static const routeName = '/temp-screen';

  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Coming soon!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        Text('This feature was not yet implemented, but it willbe in short time!', textAlign: TextAlign.center,),
      ],
    ));
  }
}
