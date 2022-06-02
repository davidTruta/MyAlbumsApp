
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

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
