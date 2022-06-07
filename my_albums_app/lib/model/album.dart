import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  int? id;
  int? userId;
  String? title;

  Album({this.id, this.userId, this.title});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Album &&
        other.id == id &&
        other.title == title &&
        other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode;
}
