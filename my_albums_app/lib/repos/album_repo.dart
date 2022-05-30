import 'package:dio/dio.dart';
import '../apis/client_api.dart';

class AlbumRepo {
  final ClientApi api;

  AlbumRepo(this.api);

  Future<List<Album>> getAlbums() async {
    return await api.getAlbums().catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).message;
          if (res ==
              "SocketException: Failed host lookup: 'jsonplaceholder.typicode.com' (OS Error: No address associated with hostname, errno = 7)") {
            throw Exception('no internet');
          }
          break;
        default:
          break;
      }
    });
  }
}
