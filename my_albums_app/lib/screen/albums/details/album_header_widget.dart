import 'package:flutter/material.dart';

class AlbumHeaderWidget extends StatelessWidget {
  final int id;
  final String title;

  const AlbumHeaderWidget({Key? key, required this.id, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          minRadius: 40.0,
          child: Text(
            title[0],
            style: const TextStyle(fontSize: 38),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Album with id: $id',
          style: const TextStyle(fontSize: 14, color: Colors.black45),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
