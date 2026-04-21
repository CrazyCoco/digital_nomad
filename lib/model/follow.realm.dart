// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Follow extends _Follow with RealmEntity, RealmObjectBase, RealmObject {
  Follow(String id, String followerId, String followingId, DateTime createdAt) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'followerId', followerId);
    RealmObjectBase.set(this, 'followingId', followingId);
    RealmObjectBase.set(this, 'createdAt', createdAt);
  }

  Follow._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get followerId =>
      RealmObjectBase.get<String>(this, 'followerId') as String;
  @override
  set followerId(String value) =>
      RealmObjectBase.set(this, 'followerId', value);

  @override
  String get followingId =>
      RealmObjectBase.get<String>(this, 'followingId') as String;
  @override
  set followingId(String value) =>
      RealmObjectBase.set(this, 'followingId', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Stream<RealmObjectChanges<Follow>> get changes =>
      RealmObjectBase.getChanges<Follow>(this);

  @override
  Stream<RealmObjectChanges<Follow>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Follow>(this, keyPaths);

  @override
  Follow freeze() => RealmObjectBase.freezeObject<Follow>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'followerId': followerId.toEJson(),
      'followingId': followingId.toEJson(),
      'createdAt': createdAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(Follow value) => value.toEJson();
  static Follow _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'followerId': EJsonValue followerId,
        'followingId': EJsonValue followingId,
        'createdAt': EJsonValue createdAt,
      } =>
        Follow(
          fromEJson(id),
          fromEJson(followerId),
          fromEJson(followingId),
          fromEJson(createdAt),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Follow._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Follow, 'Follow', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('followerId', RealmPropertyType.string),
      SchemaProperty('followingId', RealmPropertyType.string),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
