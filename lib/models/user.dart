import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class MyUser {
  @JsonKey(nullable: false)
  String name;
  @JsonKey(nullable: true)
  String userId;
  @JsonKey(nullable: false)
  String lastName;
  @JsonKey(nullable: false)
  String email;
  @JsonKey(nullable: false)
  String gender;
  @JsonKey(ignore: true)
  String password;
  @JsonKey(nullable: false, required: false)
  String dateOfBirth;
  @JsonKey(nullable: true, required: false)
  String favoriteSoccerTeam;
  @JsonKey(nullable: true, required: false)
  String favoriteDish;

  MyUser();
  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
  toJson() => _$MyUserToJson(this);
}
