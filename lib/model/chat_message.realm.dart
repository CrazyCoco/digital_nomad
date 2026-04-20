// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class ChatMessage extends _ChatMessage
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  ChatMessage(
    String id,
    String conversationId,
    String senderId,
    String senderName,
    String content, {
    String? senderAvatar,
    String? imageUrl,
    String? videoUrl,
    int messageType = 0,
    bool isRead = false,
    DateTime? createdAt,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<ChatMessage>({
        'messageType': 0,
        'isRead': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'conversationId', conversationId);
    RealmObjectBase.set(this, 'senderId', senderId);
    RealmObjectBase.set(this, 'senderName', senderName);
    RealmObjectBase.set(this, 'senderAvatar', senderAvatar);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'videoUrl', videoUrl);
    RealmObjectBase.set(this, 'messageType', messageType);
    RealmObjectBase.set(this, 'isRead', isRead);
    RealmObjectBase.set(this, 'createdAt', createdAt);
  }

  ChatMessage._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get conversationId =>
      RealmObjectBase.get<String>(this, 'conversationId') as String;
  @override
  set conversationId(String value) =>
      RealmObjectBase.set(this, 'conversationId', value);

  @override
  String get senderId =>
      RealmObjectBase.get<String>(this, 'senderId') as String;
  @override
  set senderId(String value) => RealmObjectBase.set(this, 'senderId', value);

  @override
  String get senderName =>
      RealmObjectBase.get<String>(this, 'senderName') as String;
  @override
  set senderName(String value) =>
      RealmObjectBase.set(this, 'senderName', value);

  @override
  String? get senderAvatar =>
      RealmObjectBase.get<String>(this, 'senderAvatar') as String?;
  @override
  set senderAvatar(String? value) =>
      RealmObjectBase.set(this, 'senderAvatar', value);

  @override
  String get content => RealmObjectBase.get<String>(this, 'content') as String;
  @override
  set content(String value) => RealmObjectBase.set(this, 'content', value);

  @override
  String? get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String?;
  @override
  set imageUrl(String? value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  String? get videoUrl =>
      RealmObjectBase.get<String>(this, 'videoUrl') as String?;
  @override
  set videoUrl(String? value) => RealmObjectBase.set(this, 'videoUrl', value);

  @override
  int get messageType => RealmObjectBase.get<int>(this, 'messageType') as int;
  @override
  set messageType(int value) => RealmObjectBase.set(this, 'messageType', value);

  @override
  bool get isRead => RealmObjectBase.get<bool>(this, 'isRead') as bool;
  @override
  set isRead(bool value) => RealmObjectBase.set(this, 'isRead', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Stream<RealmObjectChanges<ChatMessage>> get changes =>
      RealmObjectBase.getChanges<ChatMessage>(this);

  @override
  Stream<RealmObjectChanges<ChatMessage>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<ChatMessage>(this, keyPaths);

  @override
  ChatMessage freeze() => RealmObjectBase.freezeObject<ChatMessage>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'conversationId': conversationId.toEJson(),
      'senderId': senderId.toEJson(),
      'senderName': senderName.toEJson(),
      'senderAvatar': senderAvatar.toEJson(),
      'content': content.toEJson(),
      'imageUrl': imageUrl.toEJson(),
      'videoUrl': videoUrl.toEJson(),
      'messageType': messageType.toEJson(),
      'isRead': isRead.toEJson(),
      'createdAt': createdAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(ChatMessage value) => value.toEJson();
  static ChatMessage _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'conversationId': EJsonValue conversationId,
        'senderId': EJsonValue senderId,
        'senderName': EJsonValue senderName,
        'content': EJsonValue content,
      } =>
        ChatMessage(
          fromEJson(id),
          fromEJson(conversationId),
          fromEJson(senderId),
          fromEJson(senderName),
          fromEJson(content),
          senderAvatar: fromEJson(ejson['senderAvatar']),
          imageUrl: fromEJson(ejson['imageUrl']),
          videoUrl: fromEJson(ejson['videoUrl']),
          messageType: fromEJson(ejson['messageType'], defaultValue: 0),
          isRead: fromEJson(ejson['isRead'], defaultValue: false),
          createdAt: fromEJson(ejson['createdAt']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ChatMessage._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      ChatMessage,
      'ChatMessage',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('conversationId', RealmPropertyType.string),
        SchemaProperty('senderId', RealmPropertyType.string),
        SchemaProperty('senderName', RealmPropertyType.string),
        SchemaProperty(
          'senderAvatar',
          RealmPropertyType.string,
          optional: true,
        ),
        SchemaProperty('content', RealmPropertyType.string),
        SchemaProperty('imageUrl', RealmPropertyType.string, optional: true),
        SchemaProperty('videoUrl', RealmPropertyType.string, optional: true),
        SchemaProperty('messageType', RealmPropertyType.int),
        SchemaProperty('isRead', RealmPropertyType.bool),
        SchemaProperty(
          'createdAt',
          RealmPropertyType.timestamp,
          optional: true,
        ),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
