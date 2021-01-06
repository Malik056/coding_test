// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageObject _$ImageObjectFromJson(Map<String, dynamic> json) {
  return ImageObject()
    ..url = json['url'] as String
    ..storagePath = json['storagePath'] as String
    ..name = json['name'] as String
    ..uid = json['uid'] as String;
}

Map<String, dynamic> _$ImageObjectToJson(ImageObject instance) =>
    <String, dynamic>{
      'url': instance.url,
      'storagePath': instance.storagePath,
      'name': instance.name,
      'uid': instance.uid,
    };
