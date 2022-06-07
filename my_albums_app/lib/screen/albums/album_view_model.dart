import 'package:shared_preferences/shared_preferences.dart';

import '../../model/album.dart';
import '../../repo/album_repo.dart';

class AlbumsViewModel {
  final AlbumRepo _albumRepo;
  AlbumViewModel? _selectedAlbum;

  AlbumsViewModel(this._albumRepo);

  AlbumViewModel? get getSelectedAlbum {
    return _selectedAlbum;
  }

  void setSelectedAlbum(AlbumViewModel? album) {
    _selectedAlbum = album;
  }

  bool isEven(int id) {
    if (id % 2 == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<AlbumViewModel>> fetchAlbums() async {
    try {
      return (await _albumRepo.getAlbums())
          .map((a) => AlbumViewModel(a))
          .toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<List<AlbumViewModel>> fetchLocalAlbums() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final List<String>? albums = prefs.getStringList('albums');
      return albums!.map((a) {
        final args = a.split(",");
        return AlbumViewModel(Album(
            id: int.parse(args[0]),
            userId: int.parse(args[1]),
            title: args[2]));
      }).toList();
    } catch (err) {
      throw Exception("There are no local albums");
    }
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

  @override
  operator ==(Object other) {
    return other is AlbumViewModel && other._album == _album;
  }

  @override
  int get hashCode => id.hashCode;
}