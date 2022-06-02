import 'package:flutter/material.dart';

import 'photo_view_model.dart';

class PhotoListWidget extends StatefulWidget {
  final int albumId;
  final List<PhotoViewModel> photos;

  const PhotoListWidget({Key? key, required this.albumId, required this.photos})
      : super(key: key);

  @override
  State<PhotoListWidget> createState() => _PhotoListWidgetState();
}

class _PhotoListWidgetState extends State<PhotoListWidget> {
  final header = Row(
    children: const [
      SizedBox(
        height: 20,
      ),
      Text(
        'Photos',
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      children: [
        header,
        const SizedBox(
          height: 10,
        ),
        ListView.separated(
          padding: const EdgeInsets.all(0),
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.photos.length,
          itemBuilder: (context, i) {
            return ListTile(
              minVerticalPadding: 0,
              horizontalTitleGap: 20,
              contentPadding: const EdgeInsets.all(0),
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.network(
                  widget.photos[i].url,
                ),
              ),
              title: Text(
                widget.photos[i].title,
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Photo with id: ${widget.photos[i].id}',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 0.7,
            );
          },
        )
      ],
    );
  }
}
