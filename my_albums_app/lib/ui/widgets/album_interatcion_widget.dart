import 'package:flutter/material.dart';

class AlbumInteractionWidget extends StatelessWidget {
  final int nrOfPhotos;

  const AlbumInteractionWidget({Key? key, required this.nrOfPhotos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: Theme.of(context).primaryColor,
                ),
                const Text(
                  'Save to favorites',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
          ),
        ),
        const VerticalDivider(
          thickness: 1,
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  nrOfPhotos.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              const Text('Photos', style: TextStyle(color: Colors.black45))
            ],
          ),
        ),
        const VerticalDivider(
          thickness: 1,
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: Column(
              children: [
                Icon(Icons.mode_comment_rounded,
                    color: Theme.of(context).primaryColor),
                const SizedBox(
                  height: 5,
                ),
                const Text('Add a \ncomment',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
