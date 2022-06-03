import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/repo/photo_repo.dart';
import 'package:my_albums_app/screen/albums/details/widgets/album_header_widget.dart';
import 'package:my_albums_app/screen/albums/details/widgets/album_interatcion_widget.dart';
import 'package:my_albums_app/screen/albums/details/widgets/photo_list_widget.dart';
import 'package:my_albums_app/screen/albums/album_view_model.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../theming/dimensions.dart';
import 'photo_view_model.dart';

class AlbumDetailScreen extends StatelessWidget {
  final PhotosViewModel viewModel =
      PhotosViewModel(photoRepo: PhotoRepo(ClientApi(Dio())));
  final AlbumViewModel album;

  AlbumDetailScreen({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchPhotosFromAlbum(album.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return const Center(
                  child: Text(
                      '!!!Temporary ERROR!!!\n we also need to store photos locally', textAlign: TextAlign.center,));
            } else {
              final photos = snapshot.data as List<PhotoViewModel>;
              return SingleChildScrollView(
                child: Center(
                    child: Padding(
                  padding: albumDetailsPadding,
                  child: Column(
                    children: [
                      AlbumHeaderWidget(
                        id: album.id,
                        title: album.title,
                      ),
                      const Divider(
                        thickness: dividerThickness,
                      ),
                      IntrinsicHeight(
                        child: Padding(
                          padding: albumInteractionPadding,
                          child: AlbumInteractionWidget(
                            nrOfPhotos: photos.length,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: dividerThickness,
                      ),
                      normalVerticalDistance,
                      PhotoListWidget(
                        albumId: album.id,
                        photos: photos,
                      )
                    ],
                  ),
                )),
              );
            }
          }
        });
  }
}
