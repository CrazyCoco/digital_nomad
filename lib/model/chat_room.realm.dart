// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class ChatRoom extends _ChatRoom
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  ChatRoom(
    String id,
    String name,
    DateTime createdAt,
    DateTime updatedAt, {
    String? description,
    int membersCount = 0,
    bool isHot = false,
    String? avatar,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<ChatRoom>({
        'membersCount': 0,
        'isHot': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'membersCount', membersCount);
    RealmObjectBase.set(this, 'isHot', isHot);
    RealmObjectBase.set(this, 'avatar', avatar);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  ChatRoom._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  int get membersCount => RealmObjectBase.get<int>(this, 'membersCount') as int;
  @override
  set membersCount(int value) =>
      RealmObjectBase.set(this, 'membersCount', value);

  @override
  bool get isHot => RealmObjectBase.get<bool>(this, 'isHot') as bool;
  @override
  set isHot(bool value) => RealmObjectBase.set(this, 'isHot', value);

  @override
  String? get avatar => RealmObjectBase.get<String>(this, 'avatar') as String?;
  @override
  set avatar(String? value) => RealmObjectBase.set(this, 'avatar', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  DateTime get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime;
  @override
  set updatedAt(DateTime value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<ChatRoom>> get changes =>
      RealmObjectBase.getChanges<ChatRoom>(this);

  @override
  Stream<RealmObjectChanges<ChatRoom>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ChatRoom>(this, keyPaths);

  @override
  ChatRoom freeze() => RealmObjectBase.freezeObject<ChatRoom>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'description': description.toEJson(),
      'membersCount': membersCount.toEJson(),
      'isHot': isHot.toEJson(),
      'avatar': avatar.toEJson(),
      'createdAt': createdAt.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(ChatRoom value) => value.toEJson();
  static ChatRoom _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'createdAt': EJsonValue createdAt,
        'updatedAt': EJsonValue updatedAt,
      } =>
        ChatRoom(
          fromEJson(id),
          fromEJson(name),
          fromEJson(createdAt),
          fromEJson(updatedAt),
          description: fromEJson(ejson['description']),
          membersCount: fromEJson(ejson['membersCount'], defaultValue: 0),
          isHot: fromEJson(ejson['isHot'], defaultValue: false),
          avatar: fromEJson(ejson['avatar']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ChatRoom._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, ChatRoom, 'ChatRoom', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('membersCount', RealmPropertyType.int),
      SchemaProperty('isHot', RealmPropertyType.bool),
      SchemaProperty('avatar', RealmPropertyType.string, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
