import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_albums_app/BLoC/photo_query_bloc.dart';
import 'package:my_albums_app/screen/albums/album_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../BLoC/bloc_provider.dart';
import '../../../theming/dimensions.dart';
import '../../../widgets/app_bar_widget.dart';
import '../details/album_detail_screen.dart';

class AlbumsListScreen extends StatefulWidget {
  final AlbumsViewModel viewModel;
  final List<AlbumViewModel> albums;

  const AlbumsListScreen(
      {Key? key, required this.albums, required this.viewModel})
      : super(key: key);

  @override
  State<AlbumsListScreen> createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<AlbumsListScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.viewModel.getSelectedAlbum != null) {
      final bloc = PhotoQueryBloc();
      bloc.submitQuery(widget.viewModel.getSelectedAlbum!.id);
      return Scaffold(
        appBar: AppBarWidget(
          title: Text(AppLocalizations.of(context)!.details,
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            onPressed: () {
              setState(() {
                widget.viewModel.setSelectedAlbum(null);
              });
            },
          ),
        ),
        body: BlocProvider<PhotoQueryBloc>(
          bloc: bloc,
          child: AlbumDetailScreen(album: widget.viewModel.getSelectedAlbum!),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBarWidget(
          title: Text(AppLocalizations.of(context)!.myAlbums,
              style: Theme.of(context).textTheme.headlineSmall),
          centerTitle: false,
        ),
        body: Center(
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
                    if (widget.viewModel.isEven(widget.albums[i].id)) {
                      widget.viewModel.setSelectedAlbum(widget.albums[i]);
                    } else {
                      Fluttertoast.showToast(msg: "Id is uneven!");
                    }
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
        ),
      );
    }
  }
}
