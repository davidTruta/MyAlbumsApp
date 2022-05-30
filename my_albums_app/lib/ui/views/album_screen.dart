import 'package:flutter/material.dart';
import 'package:my_albums_app/ui/widgets/album_header_widget.dart';
import 'package:my_albums_app/ui/widgets/album_interatcion_widget.dart';
import 'package:my_albums_app/ui/widgets/photo_list_widget.dart';
import 'package:my_albums_app/view_models/album_view_model.dart';

import '../../view_models/photo_view_model.dart';

class AlbumScreen extends StatelessWidget {
  final PhotosViewModel viewModel;
  static const routeName = '/album-screen';

  const AlbumScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
      centerTitle: true,
      title: const Text(
        'Details',
        style: TextStyle(
            fontSize: 24, color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
    );
    final album = ModalRoute.of(context)!.settings.arguments as AlbumViewModel;
    return Scaffold(
      appBar: myAppBar,
      body: FutureBuilder(
          future: viewModel.fetchPhotosFromAlbum(album.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final photos = snapshot.data as List<PhotoViewModel>;
              return SingleChildScrollView(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      AlbumHeaderWidget(
                        id: album.id,
                        title: album.title,
                      ),
                      const Divider(
                        thickness: 0.7,
                      ),
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          child: AlbumInteractionWidget(
                            nrOfPhotos: photos.length,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.7,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PhotoListWidget(
                        albumId: album.id,
                        photos: photos,
                      )
                    ],
                  ),
                )),
              );
            }
          }),
    );
  }
}
