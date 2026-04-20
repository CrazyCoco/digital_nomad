// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Post extends _Post with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Post(
    String id,
    String userId,
    String userName, {
    String? userAvatar,
    String? description,
    String? image,
    String? videoPath,
    bool isVideo = false,
    int likes = 0,
    int comments = 0,
    int shares = 0,
    bool isLiked = false,
    String? category,
    String? weather,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Post>({
        'isVideo': false,
        'likes': 0,
        'comments': 0,
        'shares': 0,
        'isLiked': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'userAvatar', userAvatar);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'image', image);
    RealmObjectBase.set(this, 'videoPath', videoPath);
    RealmObjectBase.set(this, 'isVideo', isVideo);
    RealmObjectBase.set(this, 'likes', likes);
    RealmObjectBase.set(this, 'comments', comments);
    RealmObjectBase.set(this, 'shares', shares);
    RealmObjectBase.set(this, 'isLiked', isLiked);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'weather', weather);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  Post._();

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
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get image => RealmObjectBase.get<String>(this, 'image') as String?;
  @override
  set image(String? value) => RealmObjectBase.set(this, 'image', value);

  @override
  String? get videoPath =>
      RealmObjectBase.get<String>(this, 'videoPath') as String?;
  @override
  set videoPath(String? value) => RealmObjectBase.set(this, 'videoPath', value);

  @override
  bool get isVideo => RealmObjectBase.get<bool>(this, 'isVideo') as bool;
  @override
  set isVideo(bool value) => RealmObjectBase.set(this, 'isVideo', value);

  @override
  int get likes => RealmObjectBase.get<int>(this, 'likes') as int;
  @override
  set likes(int value) => RealmObjectBase.set(this, 'likes', value);

  @override
  int get comments => RealmObjectBase.get<int>(this, 'comments') as int;
  @override
  set comments(int value) => RealmObjectBase.set(this, 'comments', value);

  @override
  int get shares => RealmObjectBase.get<int>(this, 'shares') as int;
  @override
  set shares(int value) => RealmObjectBase.set(this, 'shares', value);

  @override
  bool get isLiked => RealmObjectBase.get<bool>(this, 'isLiked') as bool;
  @override
  set isLiked(bool value) => RealmObjectBase.set(this, 'isLiked', value);

  @override
  String? get category =>
      RealmObjectBase.get<String>(this, 'category') as String?;
  @override
  set category(String? value) => RealmObjectBase.set(this, 'category', value);

  @override
  String? get weather =>
      RealmObjectBase.get<String>(this, 'weather') as String?;
  @override
  set weather(String? value) => RealmObjectBase.set(this, 'weather', value);

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
  Stream<RealmObjectChanges<Post>> get changes =>
      RealmObjectBase.getChanges<Post>(this);

  @override
  Stream<RealmObjectChanges<Post>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Post>(this, keyPaths);

  @override
  Post freeze() => RealmObjectBase.freezeObject<Post>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'userId': userId.toEJson(),
      'userName': userName.toEJson(),
      'userAvatar': userAvatar.toEJson(),
      'description': description.toEJson(),
      'image': image.toEJson(),
      'videoPath': videoPath.toEJson(),
      'isVideo': isVideo.toEJson(),
      'likes': likes.toEJson(),
      'comments': comments.toEJson(),
      'shares': shares.toEJson(),
      'isLiked': isLiked.toEJson(),
      'category': category.toEJson(),
      'weather': weather.toEJson(),
      'createdAt': createdAt.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(Post value) => value.toEJson();
  static Post _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'userId': EJsonValue userId,
        'userName': EJsonValue userName,
      } =>
        Post(
          fromEJson(id),
          fromEJson(userId),
          fromEJson(userName),
          userAvatar: fromEJson(ejson['userAvatar']),
          description: fromEJson(ejson['description']),
          image: fromEJson(ejson['image']),
          videoPath: fromEJson(ejson['videoPath']),
          isVideo: fromEJson(ejson['isVideo'], defaultValue: false),
          likes: fromEJson(ejson['likes'], defaultValue: 0),
          comments: fromEJson(ejson['comments'], defaultValue: 0),
          shares: fromEJson(ejson['shares'], defaultValue: 0),
          isLiked: fromEJson(ejson['isLiked'], defaultValue: false),
          category: fromEJson(ejson['category']),
          weather: fromEJson(ejson['weather']),
          createdAt: fromEJson(ejson['createdAt']),
          updatedAt: fromEJson(ejson['updatedAt']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Post._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Post, 'Post', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('userName', RealmPropertyType.string),
      SchemaProperty('userAvatar', RealmPropertyType.string, optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('image', RealmPropertyType.string, optional: true),
      SchemaProperty('videoPath', RealmPropertyType.string, optional: true),
      SchemaProperty('isVideo', RealmPropertyType.bool),
      SchemaProperty('likes', RealmPropertyType.int),
      SchemaProperty('comments', RealmPropertyType.int),
      SchemaProperty('shares', RealmPropertyType.int),
      SchemaProperty('isLiked', RealmPropertyType.bool),
      SchemaProperty('category', RealmPropertyType.string, optional: true),
      SchemaProperty('weather', RealmPropertyType.string, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
