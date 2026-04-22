// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  User(
    String id,
    String name, {
    String? avatar,
    String? bio,
    String? title,
    String? gender,
    String? location,
    int following = 0,
    int followers = 0,
    int friends = 0,
    int postsCount = 0,
    int coins = 1000,
    bool isOnline = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<User>({
        'following': 0,
        'followers': 0,
        'friends': 0,
        'postsCount': 0,
        'coins': 1000,
        'isOnline': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'avatar', avatar);
    RealmObjectBase.set(this, 'bio', bio);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'location', location);
    RealmObjectBase.set(this, 'following', following);
    RealmObjectBase.set(this, 'followers', followers);
    RealmObjectBase.set(this, 'friends', friends);
    RealmObjectBase.set(this, 'postsCount', postsCount);
    RealmObjectBase.set(this, 'coins', coins);
    RealmObjectBase.set(this, 'isOnline', isOnline);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  User._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get avatar => RealmObjectBase.get<String>(this, 'avatar') as String?;
  @override
  set avatar(String? value) => RealmObjectBase.set(this, 'avatar', value);

  @override
  String? get bio => RealmObjectBase.get<String>(this, 'bio') as String?;
  @override
  set bio(String? value) => RealmObjectBase.set(this, 'bio', value);

  @override
  String? get title => RealmObjectBase.get<String>(this, 'title') as String?;
  @override
  set title(String? value) => RealmObjectBase.set(this, 'title', value);

  @override
  String? get gender => RealmObjectBase.get<String>(this, 'gender') as String?;
  @override
  set gender(String? value) => RealmObjectBase.set(this, 'gender', value);

  @override
  String? get location =>
      RealmObjectBase.get<String>(this, 'location') as String?;
  @override
  set location(String? value) => RealmObjectBase.set(this, 'location', value);

  @override
  int get following => RealmObjectBase.get<int>(this, 'following') as int;
  @override
  set following(int value) => RealmObjectBase.set(this, 'following', value);

  @override
  int get followers => RealmObjectBase.get<int>(this, 'followers') as int;
  @override
  set followers(int value) => RealmObjectBase.set(this, 'followers', value);

  @override
  int get friends => RealmObjectBase.get<int>(this, 'friends') as int;
  @override
  set friends(int value) => RealmObjectBase.set(this, 'friends', value);

  @override
  int get postsCount => RealmObjectBase.get<int>(this, 'postsCount') as int;
  @override
  set postsCount(int value) => RealmObjectBase.set(this, 'postsCount', value);

  @override
  int get coins => RealmObjectBase.get<int>(this, 'coins') as int;
  @override
  set coins(int value) => RealmObjectBase.set(this, 'coins', value);

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
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  Stream<RealmObjectChanges<User>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<User>(this, keyPaths);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'avatar': avatar.toEJson(),
      'bio': bio.toEJson(),
      'title': title.toEJson(),
      'gender': gender.toEJson(),
      'location': location.toEJson(),
      'following': following.toEJson(),
      'followers': followers.toEJson(),
      'friends': friends.toEJson(),
      'postsCount': postsCount.toEJson(),
      'coins': coins.toEJson(),
      'isOnline': isOnline.toEJson(),
      'createdAt': createdAt.toEJson(),
      'updatedAt': updatedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(User value) => value.toEJson();
  static User _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'id': EJsonValue id, 'name': EJsonValue name} => User(
        fromEJson(id),
        fromEJson(name),
        avatar: fromEJson(ejson['avatar']),
        bio: fromEJson(ejson['bio']),
        title: fromEJson(ejson['title']),
        gender: fromEJson(ejson['gender']),
        location: fromEJson(ejson['location']),
        following: fromEJson(ejson['following'], defaultValue: 0),
        followers: fromEJson(ejson['followers'], defaultValue: 0),
        friends: fromEJson(ejson['friends'], defaultValue: 0),
        postsCount: fromEJson(ejson['postsCount'], defaultValue: 0),
        coins: fromEJson(ejson['coins'], defaultValue: 1000),
        isOnline: fromEJson(ejson['isOnline'], defaultValue: false),
        createdAt: fromEJson(ejson['createdAt']),
        updatedAt: fromEJson(ejson['updatedAt']),
      ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(User._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('avatar', RealmPropertyType.string, optional: true),
      SchemaProperty('bio', RealmPropertyType.string, optional: true),
      SchemaProperty('title', RealmPropertyType.string, optional: true),
      SchemaProperty('gender', RealmPropertyType.string, optional: true),
      SchemaProperty('location', RealmPropertyType.string, optional: true),
      SchemaProperty('following', RealmPropertyType.int),
      SchemaProperty('followers', RealmPropertyType.int),
      SchemaProperty('friends', RealmPropertyType.int),
      SchemaProperty('postsCount', RealmPropertyType.int),
      SchemaProperty('coins', RealmPropertyType.int),
      SchemaProperty('isOnline', RealmPropertyType.bool),
      SchemaProperty('createdAt', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
