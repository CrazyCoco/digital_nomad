// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocklist.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Blocklist extends _Blocklist
    with RealmEntity, RealmObjectBase, RealmObject {
  Blocklist(
    String id,
    String blockerId,
    String blockedUserId,
    DateTime blockedAt,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'blockerId', blockerId);
    RealmObjectBase.set(this, 'blockedUserId', blockedUserId);
    RealmObjectBase.set(this, 'blockedAt', blockedAt);
  }

  Blocklist._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get blockerId =>
      RealmObjectBase.get<String>(this, 'blockerId') as String;
  @override
  set blockerId(String value) => RealmObjectBase.set(this, 'blockerId', value);

  @override
  String get blockedUserId =>
      RealmObjectBase.get<String>(this, 'blockedUserId') as String;
  @override
  set blockedUserId(String value) =>
      RealmObjectBase.set(this, 'blockedUserId', value);

  @override
  DateTime get blockedAt =>
      RealmObjectBase.get<DateTime>(this, 'blockedAt') as DateTime;
  @override
  set blockedAt(DateTime value) =>
      RealmObjectBase.set(this, 'blockedAt', value);

  @override
  Stream<RealmObjectChanges<Blocklist>> get changes =>
      RealmObjectBase.getChanges<Blocklist>(this);

  @override
  Stream<RealmObjectChanges<Blocklist>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Blocklist>(this, keyPaths);

  @override
  Blocklist freeze() => RealmObjectBase.freezeObject<Blocklist>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'blockerId': blockerId.toEJson(),
      'blockedUserId': blockedUserId.toEJson(),
      'blockedAt': blockedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(Blocklist value) => value.toEJson();
  static Blocklist _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'blockerId': EJsonValue blockerId,
        'blockedUserId': EJsonValue blockedUserId,
        'blockedAt': EJsonValue blockedAt,
      } =>
        Blocklist(
          fromEJson(id),
          fromEJson(blockerId),
          fromEJson(blockedUserId),
          fromEJson(blockedAt),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Blocklist._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Blocklist, 'Blocklist', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('blockerId', RealmPropertyType.string),
      SchemaProperty('blockedUserId', RealmPropertyType.string),
      SchemaProperty('blockedAt', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
