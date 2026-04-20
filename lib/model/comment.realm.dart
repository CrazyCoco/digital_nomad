// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Comment extends _Comment with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Comment(
    String id,
    String postId,
    String userId,
    String userName,
    String content, {
    String? userAvatar,
    int likes = 0,
    bool isLiked = false,
    DateTime? createdAt,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Comment>({
        'likes': 0,
        'isLiked': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'postId', postId);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'userAvatar', userAvatar);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'likes', likes);
    RealmObjectBase.set(this, 'isLiked', isLiked);
    RealmObjectBase.set(this, 'createdAt', createdAt);
  }

  Comment._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get postId => RealmObjectBase.get<String>(this, 'postId') as String;
  @override
  set postId(String value) => RealmObjectBase.set(this, 'postId', value);

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
  String get content => RealmObjectBase.get<String>(this, 'content') as String;
  @override
  set content(String value) => RealmObjectBase.set(this, 'content', value);

  @override
  int get likes => RealmObjectBase.get<int>(this, 'likes') as int;
  @override
  set likes(int value) => RealmObjectBase.set(this, 'likes', value);

  @override
  bool get isLiked => RealmObjectBase.get<bool>(this, 'isLiked') as bool;
  @override
  set isLiked(bool value) => RealmObjectBase.set(this, 'isLiked', value);

  @override
  DateTime? get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime?;
  @override
  set createdAt(DateTime? value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  Stream<RealmObjectChanges<Comment>> get changes =>
      RealmObjectBase.getChanges<Comment>(this);

  @override
  Stream<RealmObjectChanges<Comment>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Comment>(this, keyPaths);

  @override
  Comment freeze() => RealmObjectBase.freezeObject<Comment>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'postId': postId.toEJson(),
      'userId': userId.toEJson(),
      'userName': userName.toEJson(),
      'userAvatar': userAvatar.toEJson(),
      'content': content.toEJson(),
      'likes': likes.toEJson(),
      'isLiked': isLiked.toEJson(),
      'createdAt': createdAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(Comment value) => value.toEJson();
  static Comment _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'postId': EJsonValue postId,
        'userId': EJsonValue userId,
        'userName': EJsonValue userName,
        'content': EJsonValue content,
      } =>
        Comment(
          fromEJson(id),
          fromEJson(postId),
          fromEJson(userId),
          fromEJson(userName),
          fromEJson(content),
          userAvatar: fromEJson(ejson['userAvatar']),
          likes: fromEJson(ejson['likes'], defaultValue: 0),
          isLiked: fromEJson(ejson['isLiked'], defaultValue: false),
          createdAt: fromEJson(ejson['createdAt']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Comment._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Comment, 'Comment', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('postId', RealmPropertyType.string),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('userName', RealmPropertyType.string),
      SchemaProperty('userAvatar', RealmPropertyType.string, optional: true),
      SchemaProperty('content', RealmPropertyType.string),
      SchemaProperty('likes', RealmPropertyType.int),
      SchemaProperty('isLiked', RealmPropertyType.bool),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
