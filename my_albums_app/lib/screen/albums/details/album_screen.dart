import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/repo/photo_repo.dart';
import 'package:my_albums_app/screen/albums/details/album_header_widget.dart';
import 'package:my_albums_app/screen/albums/details/album_interatcion_widget.dart';
import 'package:my_albums_app/screen/albums/details/photo_list_widget.dart';
import 'package:my_albums_app/screen/albums/list/album_view_model.dart';

import 'photo_view_model.dart';

class AlbumScreen extends StatelessWidget {
  final PhotosViewModel viewModel = PhotosViewModel(photoRepo: PhotoRepo(ClientApi(Dio())));
  static const routeName = '/album-screen';

  AlbumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
      centerTitle: true,
      title: Text(
        'Details',
        style: TextStyle(
            fontSize: 24, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.onBackground,
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
