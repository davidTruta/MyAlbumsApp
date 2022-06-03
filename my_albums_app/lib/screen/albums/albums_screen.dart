import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/repo/album_repo.dart';
import 'package:my_albums_app/screen/albums/album_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'list/albums_list_screen.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  final AlbumsViewModel viewModel =
      AlbumsViewModel(albumRepo: AlbumRepo(ClientApi(Dio())));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.fetchAlbums(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          List<AlbumViewModel> albums;
          if (snapshot.error != null) {
            return FutureBuilder(
              future: viewModel.fetchLocalAlbums(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting) {
                  albums = snapshot.data as List<AlbumViewModel>;
                  Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)!.localAlbumsWereLoaded,
                  );
                  return AlbumsListScreen(albums: albums);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            albums = snapshot.data as List<AlbumViewModel>;
            return AlbumsListScreen(albums: albums);
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
