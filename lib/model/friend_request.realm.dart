// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class FriendRequest extends _FriendRequest
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  FriendRequest(
    String id,
    String requesterId,
    String requesterName,
    String receiverId,
    DateTime createdAt, {
    String? requesterAvatar,
    String? message,
    bool isRead = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<FriendRequest>({
        'isRead': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'requesterId', requesterId);
    RealmObjectBase.set(this, 'requesterName', requesterName);
    RealmObjectBase.set(this, 'requesterAvatar', requesterAvatar);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'receiverId', receiverId);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'isRead', isRead);
  }

  FriendRequest._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get requesterId =>
      RealmObjectBase.get<String>(this, 'requesterId') as String;
  @override
  set requesterId(String value) =>
      RealmObjectBase.set(this, 'requesterId', value);

  @override
  String get requesterName =>
      RealmObjectBase.get<String>(this, 'requesterName') as String;
  @override
  set requesterName(String value) =>
      RealmObjectBase.set(this, 'requesterName', value);

  @override
  String? get requesterAvatar =>
      RealmObjectBase.get<String>(this, 'requesterAvatar') as String?;
  @override
  set requesterAvatar(String? value) =>
      RealmObjectBase.set(this, 'requesterAvatar', value);

  @override
  String? get message =>
      RealmObjectBase.get<String>(this, 'message') as String?;
  @override
  set message(String? value) => RealmObjectBase.set(this, 'message', value);

  @override
  String get receiverId =>
      RealmObjectBase.get<String>(this, 'receiverId') as String;
  @override
  set receiverId(String value) =>
      RealmObjectBase.set(this, 'receiverId', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  bool get isRead => RealmObjectBase.get<bool>(this, 'isRead') as bool;
  @override
  set isRead(bool value) => RealmObjectBase.set(this, 'isRead', value);

  @override
  Stream<RealmObjectChanges<FriendRequest>> get changes =>
      RealmObjectBase.getChanges<FriendRequest>(this);

  @override
  Stream<RealmObjectChanges<FriendRequest>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<FriendRequest>(this, keyPaths);

  @override
  FriendRequest freeze() => RealmObjectBase.freezeObject<FriendRequest>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'requesterId': requesterId.toEJson(),
      'requesterName': requesterName.toEJson(),
      'requesterAvatar': requesterAvatar.toEJson(),
      'message': message.toEJson(),
      'receiverId': receiverId.toEJson(),
      'createdAt': createdAt.toEJson(),
      'isRead': isRead.toEJson(),
    };
  }

  static EJsonValue _toEJson(FriendRequest value) => value.toEJson();
  static FriendRequest _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'requesterId': EJsonValue requesterId,
        'requesterName': EJsonValue requesterName,
        'receiverId': EJsonValue receiverId,
        'createdAt': EJsonValue createdAt,
      } =>
        FriendRequest(
          fromEJson(id),
          fromEJson(requesterId),
          fromEJson(requesterName),
          fromEJson(receiverId),
          fromEJson(createdAt),
          requesterAvatar: fromEJson(ejson['requesterAvatar']),
          message: fromEJson(ejson['message']),
          isRead: fromEJson(ejson['isRead'], defaultValue: false),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FriendRequest._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      FriendRequest,
      'FriendRequest',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('requesterId', RealmPropertyType.string),
        SchemaProperty('requesterName', RealmPropertyType.string),
        SchemaProperty(
          'requesterAvatar',
          RealmPropertyType.string,
          optional: true,
        ),
        SchemaProperty('message', RealmPropertyType.string, optional: true),
        SchemaProperty('receiverId', RealmPropertyType.string),
        SchemaProperty('createdAt', RealmPropertyType.timestamp),
        SchemaProperty('isRead', RealmPropertyType.bool),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
