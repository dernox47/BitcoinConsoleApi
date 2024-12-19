// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      role: json['role'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      money: (json['money'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateOfBirth': instance.dateOfBirth,
      'username': instance.username,
      'password': instance.password,
      'role': _$RoleEnumMap[instance.role]!,
      'money': instance.money,
    };

const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.user: 'user',
};
