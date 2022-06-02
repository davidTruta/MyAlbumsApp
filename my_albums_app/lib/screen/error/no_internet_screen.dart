import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  static const routeName = '/no-internet-screen';

  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final retryFunction =
        ModalRoute.of(context)!.settings.arguments as Function;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'No internet connection :(',
              style: TextStyle(fontSize: 22),
            ),
            TextButton(
                onPressed: () async {
                  try {
                    await (retryFunction() as Future<void>).then((value) =>
                        Navigator.of(context).pushReplacementNamed('/'));
                  } catch (err) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No connection was found...')));
                  }
                },
                child: const Text('Retry'))
          ],
        ),
      ),
    );
  }
}
