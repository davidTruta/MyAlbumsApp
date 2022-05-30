import 'package:dio/dio.dart';

import '../apis/client_api.dart';
import '../repos/album_repo.dart';

class AlbumsViewModel {
  List<AlbumViewModel> _albums = <AlbumViewModel>[];

  Future<void> fetchAlbums() async {
    try {
      _albums = (await AlbumRepo(ClientApi(Dio())).getAlbums())
          .map((a) => AlbumViewModel(a))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  List<AlbumViewModel> getAlbums() {
    return [..._albums];
  }
}

class AlbumViewModel {
  final Album _album;

  AlbumViewModel(this._album);

  int get id {
    return _album.id as int;
  }

  String get title {
    return _album.title as String;
  }
}
