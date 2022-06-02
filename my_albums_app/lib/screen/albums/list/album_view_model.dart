
import '../../../model/album.dart';
import '../../../repo/album_repo.dart';

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
    try {
      return (await albumRepo.getAlbums())
          .map((a) => AlbumViewModel(a))
          .toList();
    } catch (err) {
      rethrow;
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
}
