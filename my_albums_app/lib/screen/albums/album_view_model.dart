
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/album.dart';
import '../../repo/album_repo.dart';

class AlbumsViewModel {
  AlbumRepo albumRepo;

  AlbumsViewModel({required this.albumRepo});

  Future<List<AlbumViewModel>> fetchAlbums() async {
    try {
      return (await albumRepo.getAlbums())
          .map((a) => AlbumViewModel(a))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<AlbumViewModel>> fetchLocalAlbums() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? albums = prefs.getStringList('albums');
    return albums!.map((a) {
      final args = a.split(",");
      return AlbumViewModel(Album(id: int.parse(args[0]), userId: int.parse(args[1]), title: args[2]));
    }).toList();
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
