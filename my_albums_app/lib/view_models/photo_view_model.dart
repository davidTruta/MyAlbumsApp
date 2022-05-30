import 'package:dio/dio.dart';

import '../apis/client_api.dart';
import '../repos/photo_repo.dart';

class PhotosViewModel {
  Future<List<PhotoViewModel>> fetchPhotosFromAlbum(int albumId) async {
    try {
      return (await PhotoRepo(ClientApi(Dio())).getPhotosFromAlbum(albumId))
          .map((a) => PhotoViewModel(a))
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}

class PhotoViewModel {
  final Photo _photo;

  PhotoViewModel(this._photo);

  int get id {
    return _photo.id as int;
  }

  String get title {
    return _photo.title as String;
  }

  String get url {
    return _photo.url as String;
  }
}
