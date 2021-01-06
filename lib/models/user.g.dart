// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) {
  return MyUser()
    ..name = json['name'] as String
    ..userId = json['userId'] as String
    ..lastName = json['lastName'] as String
    ..email = json['email'] as String
    ..gender = json['gender'] as String
    ..dateOfBirth = json['dateOfBirth'] as String
    ..favoriteSoccerTeam = json['favoriteSoccerTeam'] as String
    ..favoriteDish = json['favoriteDish'] as String;
}

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'lastName': instance.lastName,
      'email': instance.email,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'favoriteSoccerTeam': instance.favoriteSoccerTeam,
      'favoriteDish': instance.favoriteDish,
    };
