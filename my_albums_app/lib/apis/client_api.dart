import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'client_api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ClientApi {
  factory ClientApi(Dio dio, {String baseUrl}) = _ClientApi;

  @GET("/albums")
  Future<List<Album>> getAlbums();

  @GET("/photos")
  Future<List<Photo>> getPhotos();

  @GET("/photos/?albumId={albumId}")
  Future<List<Photo>> getPhotosFromAlbum(@Path("albumId") int albumId);
}

@JsonSerializable()
class Album {
  int? id;
  int? userId;
  String? title;

  Album({this.id, this.userId, this.title});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class Photo {
  int? id;
  int? albumId;
  String? title;
  String? url;
  String? thumbnail;

  Photo({this.id, this.albumId, this.title, this.url, this.thumbnail});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
