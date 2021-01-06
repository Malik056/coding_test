import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

part 'image_object.g.dart';

@JsonSerializable()
class ImageObject {
  @JsonKey(nullable: false)
  String url;
  @JsonKey(nullable: false)
  String storagePath;
  @JsonKey(nullable: false)
  String name;
  @JsonKey(nullable: false)
  String uid;

  @JsonKey(ignore: true)
  File file;

  ImageObject();
  factory ImageObject.fromJson(Map<String, dynamic> json) =>
      _$ImageObjectFromJson(json);
  toJson() => _$ImageObjectToJson(this);
}
