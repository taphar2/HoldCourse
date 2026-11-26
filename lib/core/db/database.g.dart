// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CoursesTable extends Courses with TableInfo<$CoursesTable, Course> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lecturerMeta = const VerificationMeta(
    'lecturer',
  );
  @override
  late final GeneratedColumn<String> lecturer = GeneratedColumn<String>(
    'lecturer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetPercentMeta = const VerificationMeta(
    'targetPercent',
  );
  @override
  late final GeneratedColumn<int> targetPercent = GeneratedColumn<int>(
    'target_percent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorIndexMeta = const VerificationMeta(
    'colorIndex',
  );
  @override
  late final GeneratedColumn<int> colorIndex = GeneratedColumn<int>(
    'color_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    title,
    lecturer,
    targetPercent,
    colorIndex,
    createdAt,
    archivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Course> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('lecturer')) {
      context.handle(
        _lecturerMeta,
        lecturer.isAcceptableOrUnknown(data['lecturer']!, _lecturerMeta),
      );
    }
    if (data.containsKey('target_percent')) {
      context.handle(
        _targetPercentMeta,
        targetPercent.isAcceptableOrUnknown(
          data['target_percent']!,
          _targetPercentMeta,
        ),
      );
    }
    if (data.containsKey('color_index')) {
      context.handle(
        _colorIndexMeta,
        colorIndex.isAcceptableOrUnknown(data['color_index']!, _colorIndexMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Course map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Course(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      lecturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lecturer'],
      ),
      targetPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_percent'],
      ),
      colorIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_index'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class Course extends DataClass implements Insertable<Course> {
  final String id;
  final String code;
  final String title;
  final String? lecturer;
  final int? targetPercent;
  final int colorIndex;
  final DateTime createdAt;
  final DateTime? archivedAt;
  const Course({
    required this.id,
    required this.code,
    required this.title,
    this.lecturer,
    this.targetPercent,
    required this.colorIndex,
    required this.createdAt,
    this.archivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || lecturer != null) {
      map['lecturer'] = Variable<String>(lecturer);
    }
    if (!nullToAbsent || targetPercent != null) {
      map['target_percent'] = Variable<int>(targetPercent);
    }
    map['color_index'] = Variable<int>(colorIndex);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      id: Value(id),
      code: Value(code),
      title: Value(title),
      lecturer: lecturer == null && nullToAbsent
          ? const Value.absent()
          : Value(lecturer),
      targetPercent: targetPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(targetPercent),
      colorIndex: Value(colorIndex),
      createdAt: Value(createdAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory Course.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Course(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      lecturer: serializer.fromJson<String?>(json['lecturer']),
      targetPercent: serializer.fromJson<int?>(json['targetPercent']),
      colorIndex: serializer.fromJson<int>(json['colorIndex']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'lecturer': serializer.toJson<String?>(lecturer),
      'targetPercent': serializer.toJson<int?>(targetPercent),
      'colorIndex': serializer.toJson<int>(colorIndex),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  Course copyWith({
    String? id,
    String? code,
    String? title,
    Value<String?> lecturer = const Value.absent(),
    Value<int?> targetPercent = const Value.absent(),
    int? colorIndex,
    DateTime? createdAt,
    Value<DateTime?> archivedAt = const Value.absent(),
  }) => Course(
    id: id ?? this.id,
    code: code ?? this.code,
    title: title ?? this.title,
    lecturer: lecturer.present ? lecturer.value : this.lecturer,
    targetPercent: targetPercent.present
        ? targetPercent.value
        : this.targetPercent,
    colorIndex: colorIndex ?? this.colorIndex,
    createdAt: createdAt ?? this.createdAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
  );
  Course copyWithCompanion(CoursesCompanion data) {
    return Course(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      lecturer: data.lecturer.present ? data.lecturer.value : this.lecturer,
      targetPercent: data.targetPercent.present
          ? data.targetPercent.value
          : this.targetPercent,
      colorIndex: data.colorIndex.present
          ? data.colorIndex.value
          : this.colorIndex,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Course(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('lecturer: $lecturer, ')
          ..write('targetPercent: $targetPercent, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    title,
    lecturer,
    targetPercent,
    colorIndex,
    createdAt,
    archivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Course &&
          other.id == this.id &&
          other.code == this.code &&
          other.title == this.title &&
          other.lecturer == this.lecturer &&
          other.targetPercent == this.targetPercent &&
          other.colorIndex == this.colorIndex &&
          other.createdAt == this.createdAt &&
          other.archivedAt == this.archivedAt);
}

class CoursesCompanion extends UpdateCompanion<Course> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> title;
  final Value<String?> lecturer;
  final Value<int?> targetPercent;
  final Value<int> colorIndex;
  final Value<DateTime> createdAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const CoursesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.lecturer = const Value.absent(),
    this.targetPercent = const Value.absent(),
    this.colorIndex = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoursesCompanion.insert({
    required String id,
    required String code,
    required String title,
    this.lecturer = const Value.absent(),
    this.targetPercent = const Value.absent(),
    this.colorIndex = const Value.absent(),
    required DateTime createdAt,
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       title = Value(title),
       createdAt = Value(createdAt);
  static Insertable<Course> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? lecturer,
    Expression<int>? targetPercent,
    Expression<int>? colorIndex,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (lecturer != null) 'lecturer': lecturer,
      if (targetPercent != null) 'target_percent': targetPercent,
      if (colorIndex != null) 'color_index': colorIndex,
      if (createdAt != null) 'created_at': createdAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoursesCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? title,
    Value<String?>? lecturer,
    Value<int?>? targetPercent,
    Value<int>? colorIndex,
    Value<DateTime>? createdAt,
    Value<DateTime?>? archivedAt,
    Value<int>? rowid,
  }) {
    return CoursesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      lecturer: lecturer ?? this.lecturer,
      targetPercent: targetPercent ?? this.targetPercent,
      colorIndex: colorIndex ?? this.colorIndex,
      createdAt: createdAt ?? this.createdAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (lecturer.present) {
      map['lecturer'] = Variable<String>(lecturer.value);
    }
    if (targetPercent.present) {
      map['target_percent'] = Variable<int>(targetPercent.value);
    }
    if (colorIndex.present) {
      map['color_index'] = Variable<int>(colorIndex.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('lecturer: $lecturer, ')
          ..write('targetPercent: $targetPercent, ')
          ..write('colorIndex: $colorIndex, ')
          ..write('createdAt: $createdAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklySlotsTable extends WeeklySlots
    with TableInfo<$WeeklySlotsTable, WeeklySlot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklySlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinuteMeta = const VerificationMeta(
    'endMinute',
  );
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
    'end_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roomMeta = const VerificationMeta('room');
  @override
  late final GeneratedColumn<String> room = GeneratedColumn<String>(
    'room',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    courseId,
    weekday,
    startMinute,
    endMinute,
    room,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklySlot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdayMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('end_minute')) {
      context.handle(
        _endMinuteMeta,
        endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinuteMeta);
    }
    if (data.containsKey('room')) {
      context.handle(
        _roomMeta,
        room.isAcceptableOrUnknown(data['room']!, _roomMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklySlot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklySlot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_id'],
      )!,
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      )!,
      endMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minute'],
      )!,
      room: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room'],
      ),
    );
  }

  @override
  $WeeklySlotsTable createAlias(String alias) {
    return $WeeklySlotsTable(attachedDatabase, alias);
  }
}

class WeeklySlot extends DataClass implements Insertable<WeeklySlot> {
  final String id;
  final String courseId;

  /// 1 = Monday through 7 = Sunday, matching [DateTime.weekday].
  final int weekday;
  final int startMinute;
  final int endMinute;
  final String? room;
  const WeeklySlot({
    required this.id,
    required this.courseId,
    required this.weekday,
    required this.startMinute,
    required this.endMinute,
    this.room,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['course_id'] = Variable<String>(courseId);
    map['weekday'] = Variable<int>(weekday);
    map['start_minute'] = Variable<int>(startMinute);
    map['end_minute'] = Variable<int>(endMinute);
    if (!nullToAbsent || room != null) {
      map['room'] = Variable<String>(room);
    }
    return map;
  }

  WeeklySlotsCompanion toCompanion(bool nullToAbsent) {
    return WeeklySlotsCompanion(
      id: Value(id),
      courseId: Value(courseId),
      weekday: Value(weekday),
      startMinute: Value(startMinute),
      endMinute: Value(endMinute),
      room: room == null && nullToAbsent ? const Value.absent() : Value(room),
    );
  }

  factory WeeklySlot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklySlot(
      id: serializer.fromJson<String>(json['id']),
      courseId: serializer.fromJson<String>(json['courseId']),
      weekday: serializer.fromJson<int>(json['weekday']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      endMinute: serializer.fromJson<int>(json['endMinute']),
      room: serializer.fromJson<String?>(json['room']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'courseId': serializer.toJson<String>(courseId),
      'weekday': serializer.toJson<int>(weekday),
      'startMinute': serializer.toJson<int>(startMinute),
      'endMinute': serializer.toJson<int>(endMinute),
      'room': serializer.toJson<String?>(room),
    };
  }

  WeeklySlot copyWith({
    String? id,
    String? courseId,
    int? weekday,
    int? startMinute,
    int? endMinute,
    Value<String?> room = const Value.absent(),
  }) => WeeklySlot(
    id: id ?? this.id,
    courseId: courseId ?? this.courseId,
    weekday: weekday ?? this.weekday,
    startMinute: startMinute ?? this.startMinute,
    endMinute: endMinute ?? this.endMinute,
    room: room.present ? room.value : this.room,
  );
  WeeklySlot copyWithCompanion(WeeklySlotsCompanion data) {
    return WeeklySlot(
      id: data.id.present ? data.id.value : this.id,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
      room: data.room.present ? data.room.value : this.room,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklySlot(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('weekday: $weekday, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('room: $room')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, courseId, weekday, startMinute, endMinute, room);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklySlot &&
          other.id == this.id &&
          other.courseId == this.courseId &&
          other.weekday == this.weekday &&
          other.startMinute == this.startMinute &&
          other.endMinute == this.endMinute &&
          other.room == this.room);
}

class WeeklySlotsCompanion extends UpdateCompanion<WeeklySlot> {
  final Value<String> id;
  final Value<String> courseId;
  final Value<int> weekday;
  final Value<int> startMinute;
  final Value<int> endMinute;
  final Value<String?> room;
  final Value<int> rowid;
  const WeeklySlotsCompanion({
    this.id = const Value.absent(),
    this.courseId = const Value.absent(),
    this.weekday = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.room = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklySlotsCompanion.insert({
    required String id,
    required String courseId,
    required int weekday,
    required int startMinute,
    required int endMinute,
    this.room = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       courseId = Value(courseId),
       weekday = Value(weekday),
       startMinute = Value(startMinute),
       endMinute = Value(endMinute);
  static Insertable<WeeklySlot> custom({
    Expression<String>? id,
    Expression<String>? courseId,
    Expression<int>? weekday,
    Expression<int>? startMinute,
    Expression<int>? endMinute,
    Expression<String>? room,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseId != null) 'course_id': courseId,
      if (weekday != null) 'weekday': weekday,
      if (startMinute != null) 'start_minute': startMinute,
      if (endMinute != null) 'end_minute': endMinute,
      if (room != null) 'room': room,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklySlotsCompanion copyWith({
    Value<String>? id,
    Value<String>? courseId,
    Value<int>? weekday,
    Value<int>? startMinute,
    Value<int>? endMinute,
    Value<String?>? room,
    Value<int>? rowid,
  }) {
    return WeeklySlotsCompanion(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      weekday: weekday ?? this.weekday,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      room: room ?? this.room,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (room.present) {
      map['room'] = Variable<String>(room.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklySlotsCompanion(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('weekday: $weekday, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('room: $room, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SlotChangesTable extends SlotChanges
    with TableInfo<$SlotChangesTable, SlotChange> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SlotChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slotIdMeta = const VerificationMeta('slotId');
  @override
  late final GeneratedColumn<String> slotId = GeneratedColumn<String>(
    'slot_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weekly_slots (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SlotChangeKind, int> kind =
      GeneratedColumn<int>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<SlotChangeKind>($SlotChangesTable.$converterkind);
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endMinuteMeta = const VerificationMeta(
    'endMinute',
  );
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
    'end_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    courseId,
    slotId,
    date,
    kind,
    startMinute,
    endMinute,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'slot_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<SlotChange> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('slot_id')) {
      context.handle(
        _slotIdMeta,
        slotId.isAcceptableOrUnknown(data['slot_id']!, _slotIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    }
    if (data.containsKey('end_minute')) {
      context.handle(
        _endMinuteMeta,
        endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SlotChange map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SlotChange(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_id'],
      )!,
      slotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slot_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      kind: $SlotChangesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}kind'],
        )!,
      ),
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      ),
      endMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minute'],
      ),
    );
  }

  @override
  $SlotChangesTable createAlias(String alias) {
    return $SlotChangesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SlotChangeKind, int, int> $converterkind =
      const EnumIndexConverter<SlotChangeKind>(SlotChangeKind.values);
}

class SlotChange extends DataClass implements Insertable<SlotChange> {
  final String id;
  final String courseId;

  /// The slot being cancelled or moved. Null for an [SlotChangeKind.added]
  /// session, which exists only on this date.
  final String? slotId;
  final DateTime date;
  final SlotChangeKind kind;
  final int? startMinute;
  final int? endMinute;
  const SlotChange({
    required this.id,
    required this.courseId,
    this.slotId,
    required this.date,
    required this.kind,
    this.startMinute,
    this.endMinute,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['course_id'] = Variable<String>(courseId);
    if (!nullToAbsent || slotId != null) {
      map['slot_id'] = Variable<String>(slotId);
    }
    map['date'] = Variable<DateTime>(date);
    {
      map['kind'] = Variable<int>($SlotChangesTable.$converterkind.toSql(kind));
    }
    if (!nullToAbsent || startMinute != null) {
      map['start_minute'] = Variable<int>(startMinute);
    }
    if (!nullToAbsent || endMinute != null) {
      map['end_minute'] = Variable<int>(endMinute);
    }
    return map;
  }

  SlotChangesCompanion toCompanion(bool nullToAbsent) {
    return SlotChangesCompanion(
      id: Value(id),
      courseId: Value(courseId),
      slotId: slotId == null && nullToAbsent
          ? const Value.absent()
          : Value(slotId),
      date: Value(date),
      kind: Value(kind),
      startMinute: startMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(startMinute),
      endMinute: endMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(endMinute),
    );
  }

  factory SlotChange.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SlotChange(
      id: serializer.fromJson<String>(json['id']),
      courseId: serializer.fromJson<String>(json['courseId']),
      slotId: serializer.fromJson<String?>(json['slotId']),
      date: serializer.fromJson<DateTime>(json['date']),
      kind: $SlotChangesTable.$converterkind.fromJson(
        serializer.fromJson<int>(json['kind']),
      ),
      startMinute: serializer.fromJson<int?>(json['startMinute']),
      endMinute: serializer.fromJson<int?>(json['endMinute']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'courseId': serializer.toJson<String>(courseId),
      'slotId': serializer.toJson<String?>(slotId),
      'date': serializer.toJson<DateTime>(date),
      'kind': serializer.toJson<int>(
        $SlotChangesTable.$converterkind.toJson(kind),
      ),
      'startMinute': serializer.toJson<int?>(startMinute),
      'endMinute': serializer.toJson<int?>(endMinute),
    };
  }

  SlotChange copyWith({
    String? id,
    String? courseId,
    Value<String?> slotId = const Value.absent(),
    DateTime? date,
    SlotChangeKind? kind,
    Value<int?> startMinute = const Value.absent(),
    Value<int?> endMinute = const Value.absent(),
  }) => SlotChange(
    id: id ?? this.id,
    courseId: courseId ?? this.courseId,
    slotId: slotId.present ? slotId.value : this.slotId,
    date: date ?? this.date,
    kind: kind ?? this.kind,
    startMinute: startMinute.present ? startMinute.value : this.startMinute,
    endMinute: endMinute.present ? endMinute.value : this.endMinute,
  );
  SlotChange copyWithCompanion(SlotChangesCompanion data) {
    return SlotChange(
      id: data.id.present ? data.id.value : this.id,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      slotId: data.slotId.present ? data.slotId.value : this.slotId,
      date: data.date.present ? data.date.value : this.date,
      kind: data.kind.present ? data.kind.value : this.kind,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SlotChange(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('slotId: $slotId, ')
          ..write('date: $date, ')
          ..write('kind: $kind, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, courseId, slotId, date, kind, startMinute, endMinute);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SlotChange &&
          other.id == this.id &&
          other.courseId == this.courseId &&
          other.slotId == this.slotId &&
          other.date == this.date &&
          other.kind == this.kind &&
          other.startMinute == this.startMinute &&
          other.endMinute == this.endMinute);
}

class SlotChangesCompanion extends UpdateCompanion<SlotChange> {
  final Value<String> id;
  final Value<String> courseId;
  final Value<String?> slotId;
  final Value<DateTime> date;
  final Value<SlotChangeKind> kind;
  final Value<int?> startMinute;
  final Value<int?> endMinute;
  final Value<int> rowid;
  const SlotChangesCompanion({
    this.id = const Value.absent(),
    this.courseId = const Value.absent(),
    this.slotId = const Value.absent(),
    this.date = const Value.absent(),
    this.kind = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SlotChangesCompanion.insert({
    required String id,
    required String courseId,
    this.slotId = const Value.absent(),
    required DateTime date,
    required SlotChangeKind kind,
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       courseId = Value(courseId),
       date = Value(date),
       kind = Value(kind);
  static Insertable<SlotChange> custom({
    Expression<String>? id,
    Expression<String>? courseId,
    Expression<String>? slotId,
    Expression<DateTime>? date,
    Expression<int>? kind,
    Expression<int>? startMinute,
    Expression<int>? endMinute,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseId != null) 'course_id': courseId,
      if (slotId != null) 'slot_id': slotId,
      if (date != null) 'date': date,
      if (kind != null) 'kind': kind,
      if (startMinute != null) 'start_minute': startMinute,
      if (endMinute != null) 'end_minute': endMinute,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SlotChangesCompanion copyWith({
    Value<String>? id,
    Value<String>? courseId,
    Value<String?>? slotId,
    Value<DateTime>? date,
    Value<SlotChangeKind>? kind,
    Value<int?>? startMinute,
    Value<int?>? endMinute,
    Value<int>? rowid,
  }) {
    return SlotChangesCompanion(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      slotId: slotId ?? this.slotId,
      date: date ?? this.date,
      kind: kind ?? this.kind,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (slotId.present) {
      map['slot_id'] = Variable<String>(slotId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(
        $SlotChangesTable.$converterkind.toSql(kind.value),
      );
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SlotChangesCompanion(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('slotId: $slotId, ')
          ..write('date: $date, ')
          ..write('kind: $kind, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceMarksTable extends AttendanceMarks
    with TableInfo<$AttendanceMarksTable, AttendanceMark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceMarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AttendanceStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<AttendanceStatus>($AttendanceMarksTable.$converterstatus);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _markedAtMeta = const VerificationMeta(
    'markedAt',
  );
  @override
  late final GeneratedColumn<DateTime> markedAt = GeneratedColumn<DateTime>(
    'marked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    courseId,
    date,
    startMinute,
    status,
    note,
    markedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_marks';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceMark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('marked_at')) {
      context.handle(
        _markedAtMeta,
        markedAt.isAcceptableOrUnknown(data['marked_at']!, _markedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_markedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {courseId, date, startMinute};
  @override
  AttendanceMark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceMark(
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      )!,
      status: $AttendanceMarksTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      markedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}marked_at'],
      )!,
    );
  }

  @override
  $AttendanceMarksTable createAlias(String alias) {
    return $AttendanceMarksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AttendanceStatus, int, int> $converterstatus =
      const EnumIndexConverter<AttendanceStatus>(AttendanceStatus.values);
}

class AttendanceMark extends DataClass implements Insertable<AttendanceMark> {
  final String courseId;
  final DateTime date;
  final int startMinute;
  final AttendanceStatus status;
  final String? note;
  final DateTime markedAt;
  const AttendanceMark({
    required this.courseId,
    required this.date,
    required this.startMinute,
    required this.status,
    this.note,
    required this.markedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['course_id'] = Variable<String>(courseId);
    map['date'] = Variable<DateTime>(date);
    map['start_minute'] = Variable<int>(startMinute);
    {
      map['status'] = Variable<int>(
        $AttendanceMarksTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['marked_at'] = Variable<DateTime>(markedAt);
    return map;
  }

  AttendanceMarksCompanion toCompanion(bool nullToAbsent) {
    return AttendanceMarksCompanion(
      courseId: Value(courseId),
      date: Value(date),
      startMinute: Value(startMinute),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      markedAt: Value(markedAt),
    );
  }

  factory AttendanceMark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceMark(
      courseId: serializer.fromJson<String>(json['courseId']),
      date: serializer.fromJson<DateTime>(json['date']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      status: $AttendanceMarksTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      note: serializer.fromJson<String?>(json['note']),
      markedAt: serializer.fromJson<DateTime>(json['markedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'courseId': serializer.toJson<String>(courseId),
      'date': serializer.toJson<DateTime>(date),
      'startMinute': serializer.toJson<int>(startMinute),
      'status': serializer.toJson<int>(
        $AttendanceMarksTable.$converterstatus.toJson(status),
      ),
      'note': serializer.toJson<String?>(note),
      'markedAt': serializer.toJson<DateTime>(markedAt),
    };
  }

  AttendanceMark copyWith({
    String? courseId,
    DateTime? date,
    int? startMinute,
    AttendanceStatus? status,
    Value<String?> note = const Value.absent(),
    DateTime? markedAt,
  }) => AttendanceMark(
    courseId: courseId ?? this.courseId,
    date: date ?? this.date,
    startMinute: startMinute ?? this.startMinute,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    markedAt: markedAt ?? this.markedAt,
  );
  AttendanceMark copyWithCompanion(AttendanceMarksCompanion data) {
    return AttendanceMark(
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      date: data.date.present ? data.date.value : this.date,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      markedAt: data.markedAt.present ? data.markedAt.value : this.markedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceMark(')
          ..write('courseId: $courseId, ')
          ..write('date: $date, ')
          ..write('startMinute: $startMinute, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('markedAt: $markedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(courseId, date, startMinute, status, note, markedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceMark &&
          other.courseId == this.courseId &&
          other.date == this.date &&
          other.startMinute == this.startMinute &&
          other.status == this.status &&
          other.note == this.note &&
          other.markedAt == this.markedAt);
}

class AttendanceMarksCompanion extends UpdateCompanion<AttendanceMark> {
  final Value<String> courseId;
  final Value<DateTime> date;
  final Value<int> startMinute;
  final Value<AttendanceStatus> status;
  final Value<String?> note;
  final Value<DateTime> markedAt;
  final Value<int> rowid;
  const AttendanceMarksCompanion({
    this.courseId = const Value.absent(),
    this.date = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.markedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceMarksCompanion.insert({
    required String courseId,
    required DateTime date,
    required int startMinute,
    required AttendanceStatus status,
    this.note = const Value.absent(),
    required DateTime markedAt,
    this.rowid = const Value.absent(),
  }) : courseId = Value(courseId),
       date = Value(date),
       startMinute = Value(startMinute),
       status = Value(status),
       markedAt = Value(markedAt);
  static Insertable<AttendanceMark> custom({
    Expression<String>? courseId,
    Expression<DateTime>? date,
    Expression<int>? startMinute,
    Expression<int>? status,
    Expression<String>? note,
    Expression<DateTime>? markedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (courseId != null) 'course_id': courseId,
      if (date != null) 'date': date,
      if (startMinute != null) 'start_minute': startMinute,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (markedAt != null) 'marked_at': markedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceMarksCompanion copyWith({
    Value<String>? courseId,
    Value<DateTime>? date,
    Value<int>? startMinute,
    Value<AttendanceStatus>? status,
    Value<String?>? note,
    Value<DateTime>? markedAt,
    Value<int>? rowid,
  }) {
    return AttendanceMarksCompanion(
      courseId: courseId ?? this.courseId,
      date: date ?? this.date,
      startMinute: startMinute ?? this.startMinute,
      status: status ?? this.status,
      note: note ?? this.note,
      markedAt: markedAt ?? this.markedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $AttendanceMarksTable.$converterstatus.toSql(status.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (markedAt.present) {
      map['marked_at'] = Variable<DateTime>(markedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceMarksCompanion(')
          ..write('courseId: $courseId, ')
          ..write('date: $date, ')
          ..write('startMinute: $startMinute, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('markedAt: $markedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CatEntriesTable extends CatEntries
    with TableInfo<$CatEntriesTable, CatEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES courses (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marksMeta = const VerificationMeta('marks');
  @override
  late final GeneratedColumn<double> marks = GeneratedColumn<double>(
    'marks',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    courseId,
    title,
    marks,
    total,
    weight,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cat_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CatEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('marks')) {
      context.handle(
        _marksMeta,
        marks.isAcceptableOrUnknown(data['marks']!, _marksMeta),
      );
    } else if (isInserting) {
      context.missing(_marksMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CatEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      courseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      marks: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}marks'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      ),
    );
  }

  @override
  $CatEntriesTable createAlias(String alias) {
    return $CatEntriesTable(attachedDatabase, alias);
  }
}

class CatEntry extends DataClass implements Insertable<CatEntry> {
  final String id;
  final String courseId;
  final String title;
  final double marks;
  final double total;
  final double weight;
  final DateTime? date;
  const CatEntry({
    required this.id,
    required this.courseId,
    required this.title,
    required this.marks,
    required this.total,
    required this.weight,
    this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['course_id'] = Variable<String>(courseId);
    map['title'] = Variable<String>(title);
    map['marks'] = Variable<double>(marks);
    map['total'] = Variable<double>(total);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  CatEntriesCompanion toCompanion(bool nullToAbsent) {
    return CatEntriesCompanion(
      id: Value(id),
      courseId: Value(courseId),
      title: Value(title),
      marks: Value(marks),
      total: Value(total),
      weight: Value(weight),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory CatEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatEntry(
      id: serializer.fromJson<String>(json['id']),
      courseId: serializer.fromJson<String>(json['courseId']),
      title: serializer.fromJson<String>(json['title']),
      marks: serializer.fromJson<double>(json['marks']),
      total: serializer.fromJson<double>(json['total']),
      weight: serializer.fromJson<double>(json['weight']),
      date: serializer.fromJson<DateTime?>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'courseId': serializer.toJson<String>(courseId),
      'title': serializer.toJson<String>(title),
      'marks': serializer.toJson<double>(marks),
      'total': serializer.toJson<double>(total),
      'weight': serializer.toJson<double>(weight),
      'date': serializer.toJson<DateTime?>(date),
    };
  }

  CatEntry copyWith({
    String? id,
    String? courseId,
    String? title,
    double? marks,
    double? total,
    double? weight,
    Value<DateTime?> date = const Value.absent(),
  }) => CatEntry(
    id: id ?? this.id,
    courseId: courseId ?? this.courseId,
    title: title ?? this.title,
    marks: marks ?? this.marks,
    total: total ?? this.total,
    weight: weight ?? this.weight,
    date: date.present ? date.value : this.date,
  );
  CatEntry copyWithCompanion(CatEntriesCompanion data) {
    return CatEntry(
      id: data.id.present ? data.id.value : this.id,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      title: data.title.present ? data.title.value : this.title,
      marks: data.marks.present ? data.marks.value : this.marks,
      total: data.total.present ? data.total.value : this.total,
      weight: data.weight.present ? data.weight.value : this.weight,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CatEntry(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('title: $title, ')
          ..write('marks: $marks, ')
          ..write('total: $total, ')
          ..write('weight: $weight, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, courseId, title, marks, total, weight, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatEntry &&
          other.id == this.id &&
          other.courseId == this.courseId &&
          other.title == this.title &&
          other.marks == this.marks &&
          other.total == this.total &&
          other.weight == this.weight &&
          other.date == this.date);
}

class CatEntriesCompanion extends UpdateCompanion<CatEntry> {
  final Value<String> id;
  final Value<String> courseId;
  final Value<String> title;
  final Value<double> marks;
  final Value<double> total;
  final Value<double> weight;
  final Value<DateTime?> date;
  final Value<int> rowid;
  const CatEntriesCompanion({
    this.id = const Value.absent(),
    this.courseId = const Value.absent(),
    this.title = const Value.absent(),
    this.marks = const Value.absent(),
    this.total = const Value.absent(),
    this.weight = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatEntriesCompanion.insert({
    required String id,
    required String courseId,
    required String title,
    required double marks,
    required double total,
    required double weight,
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       courseId = Value(courseId),
       title = Value(title),
       marks = Value(marks),
       total = Value(total),
       weight = Value(weight);
  static Insertable<CatEntry> custom({
    Expression<String>? id,
    Expression<String>? courseId,
    Expression<String>? title,
    Expression<double>? marks,
    Expression<double>? total,
    Expression<double>? weight,
    Expression<DateTime>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (courseId != null) 'course_id': courseId,
      if (title != null) 'title': title,
      if (marks != null) 'marks': marks,
      if (total != null) 'total': total,
      if (weight != null) 'weight': weight,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? courseId,
    Value<String>? title,
    Value<double>? marks,
    Value<double>? total,
    Value<double>? weight,
    Value<DateTime?>? date,
    Value<int>? rowid,
  }) {
    return CatEntriesCompanion(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      marks: marks ?? this.marks,
      total: total ?? this.total,
      weight: weight ?? this.weight,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (marks.present) {
      map['marks'] = Variable<double>(marks.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatEntriesCompanion(')
          ..write('id: $id, ')
          ..write('courseId: $courseId, ')
          ..write('title: $title, ')
          ..write('marks: $marks, ')
          ..write('total: $total, ')
          ..write('weight: $weight, ')
          ..write('date: $date, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 0,
  );
  static const VerificationMeta _semesterStartMeta = const VerificationMeta(
    'semesterStart',
  );
  @override
  late final GeneratedColumn<DateTime> semesterStart =
      GeneratedColumn<DateTime>(
        'semester_start',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _semesterEndMeta = const VerificationMeta(
    'semesterEnd',
  );
  @override
  late final GeneratedColumn<DateTime> semesterEnd = GeneratedColumn<DateTime>(
    'semester_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attendanceThresholdMeta =
      const VerificationMeta('attendanceThreshold');
  @override
  late final GeneratedColumn<int> attendanceThreshold = GeneratedColumn<int>(
    'attendance_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(75),
  );
  static const VerificationMeta _catWeightMeta = const VerificationMeta(
    'catWeight',
  );
  @override
  late final GeneratedColumn<int> catWeight = GeneratedColumn<int>(
    'cat_weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(40),
  );
  static const VerificationMeta _examWeightMeta = const VerificationMeta(
    'examWeight',
  );
  @override
  late final GeneratedColumn<int> examWeight = GeneratedColumn<int>(
    'exam_weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    semesterStart,
    semesterEnd,
    attendanceThreshold,
    catWeight,
    examWeight,
    onboardingComplete,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('semester_start')) {
      context.handle(
        _semesterStartMeta,
        semesterStart.isAcceptableOrUnknown(
          data['semester_start']!,
          _semesterStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_semesterStartMeta);
    }
    if (data.containsKey('semester_end')) {
      context.handle(
        _semesterEndMeta,
        semesterEnd.isAcceptableOrUnknown(
          data['semester_end']!,
          _semesterEndMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_semesterEndMeta);
    }
    if (data.containsKey('attendance_threshold')) {
      context.handle(
        _attendanceThresholdMeta,
        attendanceThreshold.isAcceptableOrUnknown(
          data['attendance_threshold']!,
          _attendanceThresholdMeta,
        ),
      );
    }
    if (data.containsKey('cat_weight')) {
      context.handle(
        _catWeightMeta,
        catWeight.isAcceptableOrUnknown(data['cat_weight']!, _catWeightMeta),
      );
    }
    if (data.containsKey('exam_weight')) {
      context.handle(
        _examWeightMeta,
        examWeight.isAcceptableOrUnknown(data['exam_weight']!, _examWeightMeta),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      semesterStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}semester_start'],
      )!,
      semesterEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}semester_end'],
      )!,
      attendanceThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attendance_threshold'],
      )!,
      catWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cat_weight'],
      )!,
      examWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exam_weight'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  /// Always 0: the check constraint keeps this table to one row.
  final int id;
  final DateTime semesterStart;
  final DateTime semesterEnd;
  final int attendanceThreshold;
  final int catWeight;
  final int examWeight;
  final bool onboardingComplete;
  const AppSetting({
    required this.id,
    required this.semesterStart,
    required this.semesterEnd,
    required this.attendanceThreshold,
    required this.catWeight,
    required this.examWeight,
    required this.onboardingComplete,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['semester_start'] = Variable<DateTime>(semesterStart);
    map['semester_end'] = Variable<DateTime>(semesterEnd);
    map['attendance_threshold'] = Variable<int>(attendanceThreshold);
    map['cat_weight'] = Variable<int>(catWeight);
    map['exam_weight'] = Variable<int>(examWeight);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      semesterStart: Value(semesterStart),
      semesterEnd: Value(semesterEnd),
      attendanceThreshold: Value(attendanceThreshold),
      catWeight: Value(catWeight),
      examWeight: Value(examWeight),
      onboardingComplete: Value(onboardingComplete),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      semesterStart: serializer.fromJson<DateTime>(json['semesterStart']),
      semesterEnd: serializer.fromJson<DateTime>(json['semesterEnd']),
      attendanceThreshold: serializer.fromJson<int>(
        json['attendanceThreshold'],
      ),
      catWeight: serializer.fromJson<int>(json['catWeight']),
      examWeight: serializer.fromJson<int>(json['examWeight']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'semesterStart': serializer.toJson<DateTime>(semesterStart),
      'semesterEnd': serializer.toJson<DateTime>(semesterEnd),
      'attendanceThreshold': serializer.toJson<int>(attendanceThreshold),
      'catWeight': serializer.toJson<int>(catWeight),
      'examWeight': serializer.toJson<int>(examWeight),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
    };
  }

  AppSetting copyWith({
    int? id,
    DateTime? semesterStart,
    DateTime? semesterEnd,
    int? attendanceThreshold,
    int? catWeight,
    int? examWeight,
    bool? onboardingComplete,
  }) => AppSetting(
    id: id ?? this.id,
    semesterStart: semesterStart ?? this.semesterStart,
    semesterEnd: semesterEnd ?? this.semesterEnd,
    attendanceThreshold: attendanceThreshold ?? this.attendanceThreshold,
    catWeight: catWeight ?? this.catWeight,
    examWeight: examWeight ?? this.examWeight,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      semesterStart: data.semesterStart.present
          ? data.semesterStart.value
          : this.semesterStart,
      semesterEnd: data.semesterEnd.present
          ? data.semesterEnd.value
          : this.semesterEnd,
      attendanceThreshold: data.attendanceThreshold.present
          ? data.attendanceThreshold.value
          : this.attendanceThreshold,
      catWeight: data.catWeight.present ? data.catWeight.value : this.catWeight,
      examWeight: data.examWeight.present
          ? data.examWeight.value
          : this.examWeight,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('semesterStart: $semesterStart, ')
          ..write('semesterEnd: $semesterEnd, ')
          ..write('attendanceThreshold: $attendanceThreshold, ')
          ..write('catWeight: $catWeight, ')
          ..write('examWeight: $examWeight, ')
          ..write('onboardingComplete: $onboardingComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    semesterStart,
    semesterEnd,
    attendanceThreshold,
    catWeight,
    examWeight,
    onboardingComplete,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.semesterStart == this.semesterStart &&
          other.semesterEnd == this.semesterEnd &&
          other.attendanceThreshold == this.attendanceThreshold &&
          other.catWeight == this.catWeight &&
          other.examWeight == this.examWeight &&
          other.onboardingComplete == this.onboardingComplete);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<DateTime> semesterStart;
  final Value<DateTime> semesterEnd;
  final Value<int> attendanceThreshold;
  final Value<int> catWeight;
  final Value<int> examWeight;
  final Value<bool> onboardingComplete;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.semesterStart = const Value.absent(),
    this.semesterEnd = const Value.absent(),
    this.attendanceThreshold = const Value.absent(),
    this.catWeight = const Value.absent(),
    this.examWeight = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime semesterStart,
    required DateTime semesterEnd,
    this.attendanceThreshold = const Value.absent(),
    this.catWeight = const Value.absent(),
    this.examWeight = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
  }) : semesterStart = Value(semesterStart),
       semesterEnd = Value(semesterEnd);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<DateTime>? semesterStart,
    Expression<DateTime>? semesterEnd,
    Expression<int>? attendanceThreshold,
    Expression<int>? catWeight,
    Expression<int>? examWeight,
    Expression<bool>? onboardingComplete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (semesterStart != null) 'semester_start': semesterStart,
      if (semesterEnd != null) 'semester_end': semesterEnd,
      if (attendanceThreshold != null)
        'attendance_threshold': attendanceThreshold,
      if (catWeight != null) 'cat_weight': catWeight,
      if (examWeight != null) 'exam_weight': examWeight,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? semesterStart,
    Value<DateTime>? semesterEnd,
    Value<int>? attendanceThreshold,
    Value<int>? catWeight,
    Value<int>? examWeight,
    Value<bool>? onboardingComplete,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      semesterStart: semesterStart ?? this.semesterStart,
      semesterEnd: semesterEnd ?? this.semesterEnd,
      attendanceThreshold: attendanceThreshold ?? this.attendanceThreshold,
      catWeight: catWeight ?? this.catWeight,
      examWeight: examWeight ?? this.examWeight,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (semesterStart.present) {
      map['semester_start'] = Variable<DateTime>(semesterStart.value);
    }
    if (semesterEnd.present) {
      map['semester_end'] = Variable<DateTime>(semesterEnd.value);
    }
    if (attendanceThreshold.present) {
      map['attendance_threshold'] = Variable<int>(attendanceThreshold.value);
    }
    if (catWeight.present) {
      map['cat_weight'] = Variable<int>(catWeight.value);
    }
    if (examWeight.present) {
      map['exam_weight'] = Variable<int>(examWeight.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('semesterStart: $semesterStart, ')
          ..write('semesterEnd: $semesterEnd, ')
          ..write('attendanceThreshold: $attendanceThreshold, ')
          ..write('catWeight: $catWeight, ')
          ..write('examWeight: $examWeight, ')
          ..write('onboardingComplete: $onboardingComplete')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $WeeklySlotsTable weeklySlots = $WeeklySlotsTable(this);
  late final $SlotChangesTable slotChanges = $SlotChangesTable(this);
  late final $AttendanceMarksTable attendanceMarks = $AttendanceMarksTable(
    this,
  );
  late final $CatEntriesTable catEntries = $CatEntriesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    courses,
    weeklySlots,
    slotChanges,
    attendanceMarks,
    catEntries,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weekly_slots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('slot_changes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weekly_slots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('slot_changes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('attendance_marks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'courses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cat_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CoursesTableCreateCompanionBuilder = CoursesCompanion Function({
  required String id,
  required String code,
  required String title,
  Value<String?> lecturer,
  Value<int?> targetPercent,
  Value<int> colorIndex,
  required DateTime createdAt,
  Value<DateTime?> archivedAt,
  Value<int> rowid,
});
typedef $$CoursesTableUpdateCompanionBuilder = CoursesCompanion Function({
  Value<String> id,
  Value<String> code,
  Value<String> title,
  Value<String?> lecturer,
  Value<int?> targetPercent,
  Value<int> colorIndex,
  Value<DateTime> createdAt,
  Value<DateTime?> archivedAt,
  Value<int> rowid,
});

final class $$CoursesTableReferences
    extends BaseReferences<_$AppDatabase, $CoursesTable, Course> {
  $$CoursesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WeeklySlotsTable, List<WeeklySlot>>
  _weeklySlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weeklySlots,
    aliasName: 'courses__id__weekly_slots__course_id',
  );

  $$WeeklySlotsTableProcessedTableManager get weeklySlotsRefs {
    final manager = $$WeeklySlotsTableTableManager(
      $_db,
      $_db.weeklySlots,
    ).filter((f) => f.courseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_weeklySlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SlotChangesTable, List<SlotChange>>
  _slotChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.slotChanges,
    aliasName: 'courses__id__slot_changes__course_id',
  );

  $$SlotChangesTableProcessedTableManager get slotChangesRefs {
    final manager = $$SlotChangesTableTableManager(
      $_db,
      $_db.slotChanges,
    ).filter((f) => f.courseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_slotChangesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AttendanceMarksTable, List<AttendanceMark>>
  _attendanceMarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attendanceMarks,
    aliasName: 'courses__id__attendance_marks__course_id',
  );

  $$AttendanceMarksTableProcessedTableManager get attendanceMarksRefs {
    final manager = $$AttendanceMarksTableTableManager(
      $_db,
      $_db.attendanceMarks,
    ).filter((f) => f.courseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attendanceMarksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CatEntriesTable, List<CatEntry>>
  _catEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.catEntries,
    aliasName: 'courses__id__cat_entries__course_id',
  );

  $$CatEntriesTableProcessedTableManager get catEntriesRefs {
    final manager = $$CatEntriesTableTableManager(
      $_db,
      $_db.catEntries,
    ).filter((f) => f.courseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_catEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoursesTableFilterComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lecturer => $composableBuilder(
    column: $table.lecturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetPercent => $composableBuilder(
    column: $table.targetPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> weeklySlotsRefs(
    Expression<bool> Function($$WeeklySlotsTableFilterComposer f) f,
  ) {
    final $$WeeklySlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeklySlots,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklySlotsTableFilterComposer(
            $db: $db,
            $table: $db.weeklySlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> slotChangesRefs(
    Expression<bool> Function($$SlotChangesTableFilterComposer f) f,
  ) {
    final $$SlotChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.slotChanges,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SlotChangesTableFilterComposer(
            $db: $db,
            $table: $db.slotChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attendanceMarksRefs(
    Expression<bool> Function($$AttendanceMarksTableFilterComposer f) f,
  ) {
    final $$AttendanceMarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceMarks,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceMarksTableFilterComposer(
            $db: $db,
            $table: $db.attendanceMarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> catEntriesRefs(
    Expression<bool> Function($$CatEntriesTableFilterComposer f) f,
  ) {
    final $$CatEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.catEntries,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatEntriesTableFilterComposer(
            $db: $db,
            $table: $db.catEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lecturer => $composableBuilder(
    column: $table.lecturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetPercent => $composableBuilder(
    column: $table.targetPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get lecturer =>
      $composableBuilder(column: $table.lecturer, builder: (column) => column);

  GeneratedColumn<int> get targetPercent => $composableBuilder(
    column: $table.targetPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorIndex => $composableBuilder(
    column: $table.colorIndex,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  Expression<T> weeklySlotsRefs<T extends Object>(
    Expression<T> Function($$WeeklySlotsTableAnnotationComposer a) f,
  ) {
    final $$WeeklySlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weeklySlots,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklySlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklySlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> slotChangesRefs<T extends Object>(
    Expression<T> Function($$SlotChangesTableAnnotationComposer a) f,
  ) {
    final $$SlotChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.slotChanges,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SlotChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.slotChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> attendanceMarksRefs<T extends Object>(
    Expression<T> Function($$AttendanceMarksTableAnnotationComposer a) f,
  ) {
    final $$AttendanceMarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceMarks,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceMarksTableAnnotationComposer(
            $db: $db,
            $table: $db.attendanceMarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> catEntriesRefs<T extends Object>(
    Expression<T> Function($$CatEntriesTableAnnotationComposer a) f,
  ) {
    final $$CatEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.catEntries,
      getReferencedColumn: (t) => t.courseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CatEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.catEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoursesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoursesTable,
          Course,
          $$CoursesTableFilterComposer,
          $$CoursesTableOrderingComposer,
          $$CoursesTableAnnotationComposer,
          $$CoursesTableCreateCompanionBuilder,
          $$CoursesTableUpdateCompanionBuilder,
          (Course, $$CoursesTableReferences),
          Course,
          PrefetchHooks Function({
            bool weeklySlotsRefs,
            bool slotChangesRefs,
            bool attendanceMarksRefs,
            bool catEntriesRefs,
          })
        > {
  $$CoursesTableTableManager(_$AppDatabase db, $CoursesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> lecturer = const Value.absent(),
                Value<int?> targetPercent = const Value.absent(),
                Value<int> colorIndex = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion(
                id: id,
                code: code,
                title: title,
                lecturer: lecturer,
                targetPercent: targetPercent,
                colorIndex: colorIndex,
                createdAt: createdAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String title,
                Value<String?> lecturer = const Value.absent(),
                Value<int?> targetPercent = const Value.absent(),
                Value<int> colorIndex = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion.insert(
                id: id,
                code: code,
                title: title,
                lecturer: lecturer,
                targetPercent: targetPercent,
                colorIndex: colorIndex,
                createdAt: createdAt,
                archivedAt: archivedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CoursesTable, Course>(table),
                  $$CoursesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                weeklySlotsRefs = false,
                slotChangesRefs = false,
                attendanceMarksRefs = false,
                catEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (weeklySlotsRefs) db.weeklySlots,
                    if (slotChangesRefs) db.slotChanges,
                    if (attendanceMarksRefs) db.attendanceMarks,
                    if (catEntriesRefs) db.catEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (weeklySlotsRefs)
                        await $_getPrefetchedDataByColumns<
                          Course,
                          $CoursesTable,
                          WeeklySlot,
                          $WeeklySlotsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CoursesTableReferences
                              ._weeklySlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoursesTableReferences(
                                db,
                                table,
                                p0,
                              ).weeklySlotsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'course_id',
                          typedResults: items,
                        ),
                      if (slotChangesRefs)
                        await $_getPrefetchedDataByColumns<
                          Course,
                          $CoursesTable,
                          SlotChange,
                          $SlotChangesTable
                        >(
                          currentTable: table,
                          referencedTable: $$CoursesTableReferences
                              ._slotChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoursesTableReferences(
                                db,
                                table,
                                p0,
                              ).slotChangesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'course_id',
                          typedResults: items,
                        ),
                      if (attendanceMarksRefs)
                        await $_getPrefetchedDataByColumns<
                          Course,
                          $CoursesTable,
                          AttendanceMark,
                          $AttendanceMarksTable
                        >(
                          currentTable: table,
                          referencedTable: $$CoursesTableReferences
                              ._attendanceMarksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoursesTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceMarksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'course_id',
                          typedResults: items,
                        ),
                      if (catEntriesRefs)
                        await $_getPrefetchedDataByColumns<
                          Course,
                          $CoursesTable,
                          CatEntry,
                          $CatEntriesTable
                        >(
                          currentTable: table,
                          referencedTable: $$CoursesTableReferences
                              ._catEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoursesTableReferences(
                                db,
                                table,
                                p0,
                              ).catEntriesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'course_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CoursesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoursesTable,
      Course,
      $$CoursesTableFilterComposer,
      $$CoursesTableOrderingComposer,
      $$CoursesTableAnnotationComposer,
      $$CoursesTableCreateCompanionBuilder,
      $$CoursesTableUpdateCompanionBuilder,
      (Course, $$CoursesTableReferences),
      Course,
      PrefetchHooks Function({
        bool weeklySlotsRefs,
        bool slotChangesRefs,
        bool attendanceMarksRefs,
        bool catEntriesRefs,
      })
    >;
typedef $$WeeklySlotsTableCreateCompanionBuilder =
    WeeklySlotsCompanion Function({
      required String id,
      required String courseId,
      required int weekday,
      required int startMinute,
      required int endMinute,
      Value<String?> room,
      Value<int> rowid,
    });
typedef $$WeeklySlotsTableUpdateCompanionBuilder =
    WeeklySlotsCompanion Function({
      Value<String> id,
      Value<String> courseId,
      Value<int> weekday,
      Value<int> startMinute,
      Value<int> endMinute,
      Value<String?> room,
      Value<int> rowid,
    });

final class $$WeeklySlotsTableReferences
    extends BaseReferences<_$AppDatabase, $WeeklySlotsTable, WeeklySlot> {
  $$WeeklySlotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoursesTable _courseIdTable(_$AppDatabase db) =>
      db.courses.createAlias('weekly_slots__course_id__courses__id');

  $$CoursesTableProcessedTableManager get courseId {
    final $_column = $_itemColumn<String>('course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SlotChangesTable, List<SlotChange>>
  _slotChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.slotChanges,
    aliasName: 'weekly_slots__id__slot_changes__slot_id',
  );

  $$SlotChangesTableProcessedTableManager get slotChangesRefs {
    final manager = $$SlotChangesTableTableManager(
      $_db,
      $_db.slotChanges,
    ).filter((f) => f.slotId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_slotChangesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeeklySlotsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklySlotsTable> {
  $$WeeklySlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get courseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> slotChangesRefs(
    Expression<bool> Function($$SlotChangesTableFilterComposer f) f,
  ) {
    final $$SlotChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.slotChanges,
      getReferencedColumn: (t) => t.slotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SlotChangesTableFilterComposer(
            $db: $db,
            $table: $db.slotChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeklySlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklySlotsTable> {
  $$WeeklySlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get courseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklySlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklySlotsTable> {
  $$WeeklySlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  GeneratedColumn<String> get room =>
      $composableBuilder(column: $table.room, builder: (column) => column);

  $$CoursesTableAnnotationComposer get courseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> slotChangesRefs<T extends Object>(
    Expression<T> Function($$SlotChangesTableAnnotationComposer a) f,
  ) {
    final $$SlotChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.slotChanges,
      getReferencedColumn: (t) => t.slotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SlotChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.slotChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeklySlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklySlotsTable,
          WeeklySlot,
          $$WeeklySlotsTableFilterComposer,
          $$WeeklySlotsTableOrderingComposer,
          $$WeeklySlotsTableAnnotationComposer,
          $$WeeklySlotsTableCreateCompanionBuilder,
          $$WeeklySlotsTableUpdateCompanionBuilder,
          (WeeklySlot, $$WeeklySlotsTableReferences),
          WeeklySlot,
          PrefetchHooks Function({bool courseId, bool slotChangesRefs})
        > {
  $$WeeklySlotsTableTableManager(_$AppDatabase db, $WeeklySlotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklySlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklySlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklySlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<int> weekday = const Value.absent(),
                Value<int> startMinute = const Value.absent(),
                Value<int> endMinute = const Value.absent(),
                Value<String?> room = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklySlotsCompanion(
                id: id,
                courseId: courseId,
                weekday: weekday,
                startMinute: startMinute,
                endMinute: endMinute,
                room: room,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String courseId,
                required int weekday,
                required int startMinute,
                required int endMinute,
                Value<String?> room = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklySlotsCompanion.insert(
                id: id,
                courseId: courseId,
                weekday: weekday,
                startMinute: startMinute,
                endMinute: endMinute,
                room: room,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeeklySlotsTable, WeeklySlot>(table),
                  $$WeeklySlotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({courseId = false, slotChangesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (slotChangesRefs) db.slotChanges],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (courseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.courseId,
                        referencedTable: $$WeeklySlotsTableReferences
                            ._courseIdTable(db),
                        referencedColumn: $$WeeklySlotsTableReferences
                            ._courseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (slotChangesRefs)
                    await $_getPrefetchedDataByColumns<
                      WeeklySlot,
                      $WeeklySlotsTable,
                      SlotChange,
                      $SlotChangesTable
                    >(
                      currentTable: table,
                      referencedTable: $$WeeklySlotsTableReferences
                          ._slotChangesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WeeklySlotsTableReferences(
                            db,
                            table,
                            p0,
                          ).slotChangesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'slot_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WeeklySlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklySlotsTable,
      WeeklySlot,
      $$WeeklySlotsTableFilterComposer,
      $$WeeklySlotsTableOrderingComposer,
      $$WeeklySlotsTableAnnotationComposer,
      $$WeeklySlotsTableCreateCompanionBuilder,
      $$WeeklySlotsTableUpdateCompanionBuilder,
      (WeeklySlot, $$WeeklySlotsTableReferences),
      WeeklySlot,
      PrefetchHooks Function({bool courseId, bool slotChangesRefs})
    >;
typedef $$SlotChangesTableCreateCompanionBuilder =
    SlotChangesCompanion Function({
      required String id,
      required String courseId,
      Value<String?> slotId,
      required DateTime date,
      required SlotChangeKind kind,
      Value<int?> startMinute,
      Value<int?> endMinute,
      Value<int> rowid,
    });
typedef $$SlotChangesTableUpdateCompanionBuilder =
    SlotChangesCompanion Function({
      Value<String> id,
      Value<String> courseId,
      Value<String?> slotId,
      Value<DateTime> date,
      Value<SlotChangeKind> kind,
      Value<int?> startMinute,
      Value<int?> endMinute,
      Value<int> rowid,
    });

final class $$SlotChangesTableReferences
    extends BaseReferences<_$AppDatabase, $SlotChangesTable, SlotChange> {
  $$SlotChangesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoursesTable _courseIdTable(_$AppDatabase db) =>
      db.courses.createAlias('slot_changes__course_id__courses__id');

  $$CoursesTableProcessedTableManager get courseId {
    final $_column = $_itemColumn<String>('course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeeklySlotsTable _slotIdTable(_$AppDatabase db) =>
      db.weeklySlots.createAlias('slot_changes__slot_id__weekly_slots__id');

  $$WeeklySlotsTableProcessedTableManager? get slotId {
    final $_column = $_itemColumn<String>('slot_id');
    if ($_column == null) return null;
    final manager = $$WeeklySlotsTableTableManager(
      $_db,
      $_db.weeklySlots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_slotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SlotChangesTableFilterComposer
    extends Composer<_$AppDatabase, $SlotChangesTable> {
  $$SlotChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SlotChangeKind, SlotChangeKind, int>
  get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get courseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeeklySlotsTableFilterComposer get slotId {
    final $$WeeklySlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.slotId,
      referencedTable: $db.weeklySlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklySlotsTableFilterComposer(
            $db: $db,
            $table: $db.weeklySlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SlotChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $SlotChangesTable> {
  $$SlotChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get courseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeeklySlotsTableOrderingComposer get slotId {
    final $$WeeklySlotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.slotId,
      referencedTable: $db.weeklySlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklySlotsTableOrderingComposer(
            $db: $db,
            $table: $db.weeklySlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SlotChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SlotChangesTable> {
  $$SlotChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SlotChangeKind, int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  $$CoursesTableAnnotationComposer get courseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeeklySlotsTableAnnotationComposer get slotId {
    final $$WeeklySlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.slotId,
      referencedTable: $db.weeklySlots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklySlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklySlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SlotChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SlotChangesTable,
          SlotChange,
          $$SlotChangesTableFilterComposer,
          $$SlotChangesTableOrderingComposer,
          $$SlotChangesTableAnnotationComposer,
          $$SlotChangesTableCreateCompanionBuilder,
          $$SlotChangesTableUpdateCompanionBuilder,
          (SlotChange, $$SlotChangesTableReferences),
          SlotChange,
          PrefetchHooks Function({bool courseId, bool slotId})
        > {
  $$SlotChangesTableTableManager(_$AppDatabase db, $SlotChangesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SlotChangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SlotChangesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SlotChangesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<String?> slotId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<SlotChangeKind> kind = const Value.absent(),
                Value<int?> startMinute = const Value.absent(),
                Value<int?> endMinute = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SlotChangesCompanion(
                id: id,
                courseId: courseId,
                slotId: slotId,
                date: date,
                kind: kind,
                startMinute: startMinute,
                endMinute: endMinute,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String courseId,
                Value<String?> slotId = const Value.absent(),
                required DateTime date,
                required SlotChangeKind kind,
                Value<int?> startMinute = const Value.absent(),
                Value<int?> endMinute = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SlotChangesCompanion.insert(
                id: id,
                courseId: courseId,
                slotId: slotId,
                date: date,
                kind: kind,
                startMinute: startMinute,
                endMinute: endMinute,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SlotChangesTable, SlotChange>(table),
                  $$SlotChangesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({courseId = false, slotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (courseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.courseId,
                        referencedTable: $$SlotChangesTableReferences
                            ._courseIdTable(db),
                        referencedColumn: $$SlotChangesTableReferences
                            ._courseIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (slotId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.slotId,
                        referencedTable: $$SlotChangesTableReferences
                            ._slotIdTable(db),
                        referencedColumn: $$SlotChangesTableReferences
                            ._slotIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SlotChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SlotChangesTable,
      SlotChange,
      $$SlotChangesTableFilterComposer,
      $$SlotChangesTableOrderingComposer,
      $$SlotChangesTableAnnotationComposer,
      $$SlotChangesTableCreateCompanionBuilder,
      $$SlotChangesTableUpdateCompanionBuilder,
      (SlotChange, $$SlotChangesTableReferences),
      SlotChange,
      PrefetchHooks Function({bool courseId, bool slotId})
    >;
typedef $$AttendanceMarksTableCreateCompanionBuilder =
    AttendanceMarksCompanion Function({
      required String courseId,
      required DateTime date,
      required int startMinute,
      required AttendanceStatus status,
      Value<String?> note,
      required DateTime markedAt,
      Value<int> rowid,
    });
typedef $$AttendanceMarksTableUpdateCompanionBuilder =
    AttendanceMarksCompanion Function({
      Value<String> courseId,
      Value<DateTime> date,
      Value<int> startMinute,
      Value<AttendanceStatus> status,
      Value<String?> note,
      Value<DateTime> markedAt,
      Value<int> rowid,
    });

final class $$AttendanceMarksTableReferences
    extends
        BaseReferences<_$AppDatabase, $AttendanceMarksTable, AttendanceMark> {
  $$AttendanceMarksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CoursesTable _courseIdTable(_$AppDatabase db) =>
      db.courses.createAlias('attendance_marks__course_id__courses__id');

  $$CoursesTableProcessedTableManager get courseId {
    final $_column = $_itemColumn<String>('course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttendanceMarksTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceMarksTable> {
  $$AttendanceMarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AttendanceStatus, AttendanceStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get courseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceMarksTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceMarksTable> {
  $$AttendanceMarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get markedAt => $composableBuilder(
    column: $table.markedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get courseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceMarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceMarksTable> {
  $$AttendanceMarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AttendanceStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get markedAt =>
      $composableBuilder(column: $table.markedAt, builder: (column) => column);

  $$CoursesTableAnnotationComposer get courseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceMarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceMarksTable,
          AttendanceMark,
          $$AttendanceMarksTableFilterComposer,
          $$AttendanceMarksTableOrderingComposer,
          $$AttendanceMarksTableAnnotationComposer,
          $$AttendanceMarksTableCreateCompanionBuilder,
          $$AttendanceMarksTableUpdateCompanionBuilder,
          (AttendanceMark, $$AttendanceMarksTableReferences),
          AttendanceMark,
          PrefetchHooks Function({bool courseId})
        > {
  $$AttendanceMarksTableTableManager(
    _$AppDatabase db,
    $AttendanceMarksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceMarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceMarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceMarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> courseId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> startMinute = const Value.absent(),
                Value<AttendanceStatus> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> markedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceMarksCompanion(
                courseId: courseId,
                date: date,
                startMinute: startMinute,
                status: status,
                note: note,
                markedAt: markedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String courseId,
                required DateTime date,
                required int startMinute,
                required AttendanceStatus status,
                Value<String?> note = const Value.absent(),
                required DateTime markedAt,
                Value<int> rowid = const Value.absent(),
              }) => AttendanceMarksCompanion.insert(
                courseId: courseId,
                date: date,
                startMinute: startMinute,
                status: status,
                note: note,
                markedAt: markedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttendanceMarksTable, AttendanceMark>(table),
                  $$AttendanceMarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({courseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (courseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.courseId,
                        referencedTable: $$AttendanceMarksTableReferences
                            ._courseIdTable(db),
                        referencedColumn: $$AttendanceMarksTableReferences
                            ._courseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttendanceMarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceMarksTable,
      AttendanceMark,
      $$AttendanceMarksTableFilterComposer,
      $$AttendanceMarksTableOrderingComposer,
      $$AttendanceMarksTableAnnotationComposer,
      $$AttendanceMarksTableCreateCompanionBuilder,
      $$AttendanceMarksTableUpdateCompanionBuilder,
      (AttendanceMark, $$AttendanceMarksTableReferences),
      AttendanceMark,
      PrefetchHooks Function({bool courseId})
    >;
typedef $$CatEntriesTableCreateCompanionBuilder = CatEntriesCompanion Function({
  required String id,
  required String courseId,
  required String title,
  required double marks,
  required double total,
  required double weight,
  Value<DateTime?> date,
  Value<int> rowid,
});
typedef $$CatEntriesTableUpdateCompanionBuilder = CatEntriesCompanion Function({
  Value<String> id,
  Value<String> courseId,
  Value<String> title,
  Value<double> marks,
  Value<double> total,
  Value<double> weight,
  Value<DateTime?> date,
  Value<int> rowid,
});

final class $$CatEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $CatEntriesTable, CatEntry> {
  $$CatEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoursesTable _courseIdTable(_$AppDatabase db) =>
      db.courses.createAlias('cat_entries__course_id__courses__id');

  $$CoursesTableProcessedTableManager get courseId {
    final $_column = $_itemColumn<String>('course_id')!;

    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_courseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CatEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CatEntriesTable> {
  $$CatEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get marks => $composableBuilder(
    column: $table.marks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$CoursesTableFilterComposer get courseId {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CatEntriesTable> {
  $$CatEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get marks => $composableBuilder(
    column: $table.marks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoursesTableOrderingComposer get courseId {
    final $$CoursesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableOrderingComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatEntriesTable> {
  $$CatEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get marks =>
      $composableBuilder(column: $table.marks, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$CoursesTableAnnotationComposer get courseId {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.courseId,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CatEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CatEntriesTable,
          CatEntry,
          $$CatEntriesTableFilterComposer,
          $$CatEntriesTableOrderingComposer,
          $$CatEntriesTableAnnotationComposer,
          $$CatEntriesTableCreateCompanionBuilder,
          $$CatEntriesTableUpdateCompanionBuilder,
          (CatEntry, $$CatEntriesTableReferences),
          CatEntry,
          PrefetchHooks Function({bool courseId})
        > {
  $$CatEntriesTableTableManager(_$AppDatabase db, $CatEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> marks = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<DateTime?> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CatEntriesCompanion(
                id: id,
                courseId: courseId,
                title: title,
                marks: marks,
                total: total,
                weight: weight,
                date: date,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String courseId,
                required String title,
                required double marks,
                required double total,
                required double weight,
                Value<DateTime?> date = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CatEntriesCompanion.insert(
                id: id,
                courseId: courseId,
                title: title,
                marks: marks,
                total: total,
                weight: weight,
                date: date,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CatEntriesTable, CatEntry>(table),
                  $$CatEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({courseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (courseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.courseId,
                        referencedTable: $$CatEntriesTableReferences
                            ._courseIdTable(db),
                        referencedColumn: $$CatEntriesTableReferences
                            ._courseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CatEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CatEntriesTable,
      CatEntry,
      $$CatEntriesTableFilterComposer,
      $$CatEntriesTableOrderingComposer,
      $$CatEntriesTableAnnotationComposer,
      $$CatEntriesTableCreateCompanionBuilder,
      $$CatEntriesTableUpdateCompanionBuilder,
      (CatEntry, $$CatEntriesTableReferences),
      CatEntry,
      PrefetchHooks Function({bool courseId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      required DateTime semesterStart,
      required DateTime semesterEnd,
      Value<int> attendanceThreshold,
      Value<int> catWeight,
      Value<int> examWeight,
      Value<bool> onboardingComplete,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<DateTime> semesterStart,
      Value<DateTime> semesterEnd,
      Value<int> attendanceThreshold,
      Value<int> catWeight,
      Value<int> examWeight,
      Value<bool> onboardingComplete,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get semesterStart => $composableBuilder(
    column: $table.semesterStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get semesterEnd => $composableBuilder(
    column: $table.semesterEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attendanceThreshold => $composableBuilder(
    column: $table.attendanceThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get catWeight => $composableBuilder(
    column: $table.catWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get examWeight => $composableBuilder(
    column: $table.examWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get semesterStart => $composableBuilder(
    column: $table.semesterStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get semesterEnd => $composableBuilder(
    column: $table.semesterEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attendanceThreshold => $composableBuilder(
    column: $table.attendanceThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get catWeight => $composableBuilder(
    column: $table.catWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get examWeight => $composableBuilder(
    column: $table.examWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get semesterStart => $composableBuilder(
    column: $table.semesterStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get semesterEnd => $composableBuilder(
    column: $table.semesterEnd,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attendanceThreshold => $composableBuilder(
    column: $table.attendanceThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<int> get catWeight =>
      $composableBuilder(column: $table.catWeight, builder: (column) => column);

  GeneratedColumn<int> get examWeight => $composableBuilder(
    column: $table.examWeight,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> semesterStart = const Value.absent(),
                Value<DateTime> semesterEnd = const Value.absent(),
                Value<int> attendanceThreshold = const Value.absent(),
                Value<int> catWeight = const Value.absent(),
                Value<int> examWeight = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                semesterStart: semesterStart,
                semesterEnd: semesterEnd,
                attendanceThreshold: attendanceThreshold,
                catWeight: catWeight,
                examWeight: examWeight,
                onboardingComplete: onboardingComplete,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime semesterStart,
                required DateTime semesterEnd,
                Value<int> attendanceThreshold = const Value.absent(),
                Value<int> catWeight = const Value.absent(),
                Value<int> examWeight = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                semesterStart: semesterStart,
                semesterEnd: semesterEnd,
                attendanceThreshold: attendanceThreshold,
                catWeight: catWeight,
                examWeight: examWeight,
                onboardingComplete: onboardingComplete,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$WeeklySlotsTableTableManager get weeklySlots =>
      $$WeeklySlotsTableTableManager(_db, _db.weeklySlots);
  $$SlotChangesTableTableManager get slotChanges =>
      $$SlotChangesTableTableManager(_db, _db.slotChanges);
  $$AttendanceMarksTableTableManager get attendanceMarks =>
      $$AttendanceMarksTableTableManager(_db, _db.attendanceMarks);
  $$CatEntriesTableTableManager get catEntries =>
      $$CatEntriesTableTableManager(_db, _db.catEntries);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
