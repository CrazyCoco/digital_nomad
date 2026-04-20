// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Settings extends _Settings
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Settings(
    String id, {
    bool notifications = true,
    bool darkMode = false,
    String language = 'English',
    DateTime? updatedAt,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Settings>({
        'notifications': true,
        'darkMode': false,
        'language': 'English',
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'notifications', notifications);
    RealmObjectBase.set(this, 'darkMode', darkMode);
    RealmObjectBase.set(this, 'language', language);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  Settings._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  bool get notifications =>
      RealmObjectBase.get<bool>(this, 'notifications') as bool;
  @override
  set notifications(bool value) =>
      RealmObjectBase.set(this, 'notifications', value);

  @override
  bool get darkMode => RealmObjectBase.get<bool>(this, 'darkMode') as bool;
  @override
  set darkMode(bool value) => RealmObjectBase.set(this, 'darkMode', value);

  @override
  String get language =>
      RealmObjectBase.get<String>(this, 'language') as String;
  @override
  set language(String value) => RealmObjectBase.set(this, 'language', value);

  @override
  DateTime? get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime?;
  @override
  set updatedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<Settings>> get changes =>
      RealmObjectBase.getChanges<Settings>(this);

  @override
  Stream<RealmObjectChanges<Settings>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Settings>(this, keyPaths);

  @override
  Settings freeze() => RealmObjectBase.freezeObject<Settings>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'notifications': notifications.toEJson(),
      'darkMode': darkMode.toEJson(),
      'language': language.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(Settings value) => value.toEJson();
  static Settings _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'id': EJsonValue id} => Settings(
        fromEJson(id),
        notifications: fromEJson(ejson['notifications'], defaultValue: true),
        darkMode: fromEJson(ejson['darkMode'], defaultValue: false),
        language: fromEJson(ejson['language'], defaultValue: 'English'),
        updatedAt: fromEJson(ejson['updatedAt']),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Settings._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Settings, 'Settings', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('notifications', RealmPropertyType.bool),
      SchemaProperty('darkMode', RealmPropertyType.bool),
      SchemaProperty('language', RealmPropertyType.string),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
