// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Report extends _Report with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Report(
    String id,
    String reporterId,
    String reporterName,
    String reportedUserId,
    String reportedUserName,
    String reason,
    DateTime reportedAt, {
    String? description,
    bool isResolved = false,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Report>({'isResolved': false});
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'reporterId', reporterId);
    RealmObjectBase.set(this, 'reporterName', reporterName);
    RealmObjectBase.set(this, 'reportedUserId', reportedUserId);
    RealmObjectBase.set(this, 'reportedUserName', reportedUserName);
    RealmObjectBase.set(this, 'reason', reason);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'reportedAt', reportedAt);
    RealmObjectBase.set(this, 'isResolved', isResolved);
  }

  Report._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get reporterId =>
      RealmObjectBase.get<String>(this, 'reporterId') as String;
  @override
  set reporterId(String value) =>
      RealmObjectBase.set(this, 'reporterId', value);

  @override
  String get reporterName =>
      RealmObjectBase.get<String>(this, 'reporterName') as String;
  @override
  set reporterName(String value) =>
      RealmObjectBase.set(this, 'reporterName', value);

  @override
  String get reportedUserId =>
      RealmObjectBase.get<String>(this, 'reportedUserId') as String;
  @override
  set reportedUserId(String value) =>
      RealmObjectBase.set(this, 'reportedUserId', value);

  @override
  String get reportedUserName =>
      RealmObjectBase.get<String>(this, 'reportedUserName') as String;
  @override
  set reportedUserName(String value) =>
      RealmObjectBase.set(this, 'reportedUserName', value);

  @override
  String get reason => RealmObjectBase.get<String>(this, 'reason') as String;
  @override
  set reason(String value) => RealmObjectBase.set(this, 'reason', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  DateTime get reportedAt =>
      RealmObjectBase.get<DateTime>(this, 'reportedAt') as DateTime;
  @override
  set reportedAt(DateTime value) =>
      RealmObjectBase.set(this, 'reportedAt', value);

  @override
  bool get isResolved => RealmObjectBase.get<bool>(this, 'isResolved') as bool;
  @override
  set isResolved(bool value) => RealmObjectBase.set(this, 'isResolved', value);

  @override
  Stream<RealmObjectChanges<Report>> get changes =>
      RealmObjectBase.getChanges<Report>(this);

  @override
  Stream<RealmObjectChanges<Report>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Report>(this, keyPaths);

  @override
  Report freeze() => RealmObjectBase.freezeObject<Report>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'reporterId': reporterId.toEJson(),
      'reporterName': reporterName.toEJson(),
      'reportedUserId': reportedUserId.toEJson(),
      'reportedUserName': reportedUserName.toEJson(),
      'reason': reason.toEJson(),
      'description': description.toEJson(),
      'reportedAt': reportedAt.toEJson(),
      'isResolved': isResolved.toEJson(),
    };
  }

  static EJsonValue _toEJson(Report value) => value.toEJson();
  static Report _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'reporterId': EJsonValue reporterId,
        'reporterName': EJsonValue reporterName,
        'reportedUserId': EJsonValue reportedUserId,
        'reportedUserName': EJsonValue reportedUserName,
        'reason': EJsonValue reason,
        'reportedAt': EJsonValue reportedAt,
      } =>
        Report(
          fromEJson(id),
          fromEJson(reporterId),
          fromEJson(reporterName),
          fromEJson(reportedUserId),
          fromEJson(reportedUserName),
          fromEJson(reason),
          fromEJson(reportedAt),
          description: fromEJson(ejson['description']),
          isResolved: fromEJson(ejson['isResolved'], defaultValue: false),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Report._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Report, 'Report', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('reporterId', RealmPropertyType.string),
      SchemaProperty('reporterName', RealmPropertyType.string),
      SchemaProperty('reportedUserId', RealmPropertyType.string),
      SchemaProperty('reportedUserName', RealmPropertyType.string),
      SchemaProperty('reason', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('reportedAt', RealmPropertyType.timestamp),
      SchemaProperty('isResolved', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
