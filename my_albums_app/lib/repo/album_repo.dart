import 'package:shared_preferences/shared_preferences.dart';

import '../api/client_api.dart';
import '../model/album.dart';
import 'common.dart';

class AlbumRepo {
  final ClientApi api;

  AlbumRepo(this.api);

  Future<List<Album>> getAlbums() async {
    final albums = await api.getAlbums().catchError(handleError);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('albums');
    await prefs.setStringList(
        'albums', [...albums.map((a) => "${a.id},${a.userId},${a.title}")]);

    return albums;
  }
}
