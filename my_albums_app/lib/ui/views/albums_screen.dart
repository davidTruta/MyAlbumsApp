import 'package:flutter/material.dart';
import 'package:my_albums_app/ui/views/album_screen.dart';
import 'package:my_albums_app/ui/views/no_internet_screen.dart';
import 'package:my_albums_app/view_models/album_view_model.dart';

class AlbumsScreen extends StatelessWidget {
  final AlbumsViewModel viewModel;

  const AlbumsScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.fetchAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.error != null &&
                snapshot.error.toString() == "Exception: no internet") {
              Future.microtask(() => Navigator.pushReplacementNamed(
                  context, NoInternetScreen.routeName,
                  arguments: viewModel.fetchAlbums));
              return const Center(child: Text('error'));
            } else {
              final List<AlbumViewModel> albums = viewModel.getAlbums();
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
                      shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            AlbumScreen.routeName,
                            arguments: albums[i]);
                      },
                      leading: const CircleAvatar(
                        child: Icon(Icons.filter),
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
  }
}
