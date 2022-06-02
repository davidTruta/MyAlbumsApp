import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_albums_app/api/client_api.dart';
import 'package:my_albums_app/repo/album_repo.dart';
import 'package:my_albums_app/screen/albums/details/album_screen.dart';
import 'package:my_albums_app/screen/albums/list/album_view_model.dart';

class AlbumsScreen extends StatelessWidget {
  final AlbumsViewModel viewModel =
      AlbumsViewModel(albumRepo: AlbumRepo(ClientApi(Dio())));

  AlbumsScreen({Key? key}) : super(key: key);

  Widget _buildListView(context, albums) {
    return Center(
      child: ListView.separated(
        itemCount: albums.length,
        padding: const EdgeInsets.all(20),
        separatorBuilder: (context, i) {
          return const SizedBox(
            height: 20,
          );
        },
        itemBuilder: (context, i) {
          return ListTile(
            iconColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).colorScheme.outline, width: 1),
                borderRadius: BorderRadius.circular(5)),
            onTap: () {
              if (albums[i].id % 2 == 0) {
                Navigator.of(context)
                    .pushNamed(AlbumScreen.routeName, arguments: albums[i]);
              } else {
                Fluttertoast.showToast(msg: 'Album not available :(');
              }
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Icon(
                Icons.photo_album_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              albums[i].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('Album with id: ${albums[i].id}'),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.fetchAlbums(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          List<AlbumViewModel>? albums = snapshot.data as List<AlbumViewModel>;
          if (snapshot.error != null) {
            FutureBuilder(
              future: viewModel.fetchLocalAlbums(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting) {
                  return _buildListView(context, albums);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
            return Center(
                child: Text(
              'error',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ));
          } else {
            return _buildListView(context, albums);
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
