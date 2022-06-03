import 'package:flutter/material.dart';
import 'package:my_albums_app/screen/albums/album_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../theming/dimensions.dart';
import '../../../widgets/app_bar_widget.dart';
import '../details/album_detail_screen.dart';

class AlbumsListScreen extends StatefulWidget {
  final List<AlbumViewModel> albums;
  const AlbumsListScreen({Key? key, required this.albums}) : super(key: key);

  @override
  State<AlbumsListScreen> createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<AlbumsListScreen> {
  AlbumViewModel? currentAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentAlbum == null
          ? AppBarWidget(
        title: Text(AppLocalizations.of(context)!.myAlbums,
            style: Theme.of(context).textTheme.headlineSmall),
        backgroundColor: Theme.of(context).colorScheme.background,
      )
          : AppBarWidget(
        title: Text(AppLocalizations.of(context)!.details,
            style: Theme.of(context).textTheme.headlineSmall),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).primaryColor),
          onPressed: () {
            setState(() {
              currentAlbum = null;
            });
          },
        ),
      ),
      body: currentAlbum == null
          ? Center(
        child: ListView.separated(
          itemCount: widget.albums.length,
          padding: albumListPadding,
          separatorBuilder: (context, i) {
            return albumListTileDistance;
          },
          itemBuilder: (context, i) {
            return ListTile(
              iconColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              onTap: () {
                setState(() {
                  currentAlbum = widget.albums[i];
                });
              },
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: Icon(
                  Icons.photo_album_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(
                widget.albums[i].title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                  '${AppLocalizations.of(context)!.albumWithId}: ${widget.albums[i].id}'),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
        ),
      )
          : AlbumDetailScreen(album: currentAlbum!),
    );
  }
}
