// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Conversation extends _Conversation
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Conversation(
    String id,
    String userId,
    String userName, {
    String? userAvatar,
    String? lastMessage,
    DateTime? lastMessageTime,
    int unreadCount = 0,
    bool isOnline = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Conversation>({
        'unreadCount': 0,
        'isOnline': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'userAvatar', userAvatar);
    RealmObjectBase.set(this, 'lastMessage', lastMessage);
    RealmObjectBase.set(this, 'lastMessageTime', lastMessageTime);
    RealmObjectBase.set(this, 'unreadCount', unreadCount);
    RealmObjectBase.set(this, 'isOnline', isOnline);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  Conversation._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String;
  @override
  set userName(String value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get userAvatar =>
      RealmObjectBase.get<String>(this, 'userAvatar') as String?;
  @override
  set userAvatar(String? value) =>
      RealmObjectBase.set(this, 'userAvatar', value);

  @override
  String? get lastMessage =>
      RealmObjectBase.get<String>(this, 'lastMessage') as String?;
  @override
  set lastMessage(String? value) =>
      RealmObjectBase.set(this, 'lastMessage', value);

  @override
  DateTime? get lastMessageTime =>
      RealmObjectBase.get<DateTime>(this, 'lastMessageTime') as DateTime?;
  @override
  set lastMessageTime(DateTime? value) =>
      RealmObjectBase.set(this, 'lastMessageTime', value);

  @override
  int get unreadCount => RealmObjectBase.get<int>(this, 'unreadCount') as int;
  @override
  set unreadCount(int value) => RealmObjectBase.set(this, 'unreadCount', value);

  @override
  bool get isOnline => RealmObjectBase.get<bool>(this, 'isOnline') as bool;
  @override
  set isOnline(bool value) => RealmObjectBase.set(this, 'isOnline', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  DateTime? get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime?;
  @override
  set updatedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<Conversation>> get changes =>
      RealmObjectBase.getChanges<Conversation>(this);

  @override
  Stream<RealmObjectChanges<Conversation>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<Conversation>(this, keyPaths);

  @override
  Conversation freeze() => RealmObjectBase.freezeObject<Conversation>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'userId': userId.toEJson(),
      'userName': userName.toEJson(),
      'userAvatar': userAvatar.toEJson(),
      'lastMessage': lastMessage.toEJson(),
      'lastMessageTime': lastMessageTime.toEJson(),
      'unreadCount': unreadCount.toEJson(),
      'isOnline': isOnline.toEJson(),
      'createdAt': createdAt.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(Conversation value) => value.toEJson();
  static Conversation _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'userId': EJsonValue userId,
        'userName': EJsonValue userName,
      } =>
        Conversation(
          fromEJson(id),
          fromEJson(userId),
          fromEJson(userName),
          userAvatar: fromEJson(ejson['userAvatar']),
          lastMessage: fromEJson(ejson['lastMessage']),
          lastMessageTime: fromEJson(ejson['lastMessageTime']),
          unreadCount: fromEJson(ejson['unreadCount'], defaultValue: 0),
          isOnline: fromEJson(ejson['isOnline'], defaultValue: false),
          createdAt: fromEJson(ejson['createdAt']),
          updatedAt: fromEJson(ejson['updatedAt']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Conversation._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      Conversation,
      'Conversation',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('userId', RealmPropertyType.string),
        SchemaProperty('userName', RealmPropertyType.string),
        SchemaProperty('userAvatar', RealmPropertyType.string, optional: true),
        SchemaProperty('lastMessage', RealmPropertyType.string, optional: true),
        SchemaProperty(
          'lastMessageTime',
          RealmPropertyType.timestamp,
          optional: true,
        ),
        SchemaProperty('unreadCount', RealmPropertyType.int),
        SchemaProperty('isOnline', RealmPropertyType.bool),
        SchemaProperty(
          'createdAt',
          RealmPropertyType.timestamp,
          optional: true,
        ),
        SchemaProperty(
          'updatedAt',
          RealmPropertyType.timestamp,
          optional: true,
        ),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
