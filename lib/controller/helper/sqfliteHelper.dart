import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final _databaseName = "zenresume2.db";
  final _databaseVersion = 1;

  final table = 'resume';
  final resume_id = 'resume_id';
  final resume_name = 'resume_name';
  final photo = 'photo';
  final fName = 'fname';
  final lName = 'lName';
  final aboutyourself = 'aboutyourself';
  final job_title = 'job_title';
  final number = 'number';
  final email = 'email';
  final address = 'address';
  final city = 'city';
  final state = 'state';
  final create_time = 'create_time';

  final project_table = 'project';
  final pro_id = 'pro_id';
  final pro_name = 'pro_name';
  final pro_detail = 'pro_detail';

  final experience = 'experience';
  final exp_id = 'exp_id';
  final compny_name = 'compny_name';
  final join_time = 'join_time';
  final left_time = 'left_time';
  final job_role = 'job_role';

  final education = 'education';
  final edu_id = 'edu_id';
  final location_name = 'location_name';
  final edu_join_date = 'edu_join_date';
  final edu_left_date = 'edu_left_date';
  final edu_type = 'edu_type';
  final edu_score = 'edu_score';

  final techskills = 'techskills';
  final ts_id = 'ts_id';
  final ts_name = 'ts_name';

  final language = 'language';
  final lang_id = 'lang_id';
  final lang_name = 'lang_name';

  final maintbl_id = 'maintbl_id';

  SQLiteHelper._();

  static final SQLiteHelper sqLiteHelper = SQLiteHelper._();
  static Database? _mydatabase;

  Future<Database> get database async {
    if (_mydatabase != null) {
      return _mydatabase!;
    }

    _mydatabase = await initDatabase();
    return _mydatabase!;
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE $table (
            $resume_id INTEGER PRIMARY KEY,
            $maintbl_id INTEGER,
            $resume_name TEXT,
            $fName TEXT,
            $lName TEXT,
            $number INTEGER,
            $email TEXT,
            $address TEXT,
            $city TEXT,
            $state TEXT,
            $photo TEXT,
            $aboutyourself TEXT,
            $job_title TEXT,
            $create_time TEXT NOT NULL
          )
          ''');
          await db.execute('''
          CREATE TABLE $project_table (
            $pro_id INTEGER PRIMARY KEY,
            $maintbl_id INTEGER,
            $pro_name TEXT,
            $pro_detail TEXT,
            $create_time TEXT NOT NULL
          )
          ''');
          await db.execute('''
          CREATE TABLE $experience (
            $exp_id INTEGER PRIMARY KEY,
            $maintbl_id INTEGER,
            $compny_name TEXT,
            $join_time TEXT,
            $left_time TEXT,
            $job_role TEXT,
            $create_time TEXT NOT NULL
          )
          ''');
          await db.execute('''
          CREATE TABLE $education (
            $edu_id INTEGER PRIMARY KEY,
            $maintbl_id INTEGER,
            $location_name TEXT,
            $edu_join_date TEXT,
            $edu_left_date TEXT,
            $edu_type TEXT,
            $edu_score TEXT,
            $create_time TEXT NOT NULL
          )
          ''');
          await db.execute('''
          CREATE TABLE $techskills (
            $ts_id INTEGER PRIMARY KEY,
            $maintbl_id INTEGER,
            $ts_name TEXT,
            $create_time TEXT NOT NULL
          )
          ''');
          await db.execute('''
          CREATE TABLE $language (
            $lang_id INTEGER PRIMARY KEY,
            $maintbl_id INTEGER,
            $lang_name TEXT,
            $create_time TEXT NOT NULL
          )
          ''');
        });
  }

  addmaintbl(
      String fname,
      String lname,
      int mobile_number,
      String emailid,
      String addresss,
      String cityname,
      String statename,
      String aboutyourSelf,
      String jobTitle,
      String uphoto,
      ) async {
    final db = await database;
    int index = await db.insert(
      '$table',
      {
        fName: fname,
        lName: lname,
        resume_name: fname + lname,
        photo: uphoto,
        number: mobile_number,
        email: emailid,
        address: addresss,
        city: cityname,
        state: statename,
        aboutyourself: aboutyourSelf,
        job_title: jobTitle,
        create_time: DateTime.now().toString(),
      },
    );
    log('${index}');
  }



  updatemaintbl(
    int id,
    String fname,
    String lname,
    int mobile_number,
    String email_add,
    String addresss,
    String cityname,
    String statename,
    String aboutyourSelf,
    String jobTitle,
    String photo_path,
  ) async {
    final db = await database;
    await db.update(
      '$table',
      {
        fName: fname,
        photo: photo_path,
        lName: lname, // Corrected column name
        number: mobile_number,
        email: email_add,
        address: addresss,
        city: cityname,
        state: statename,
        aboutyourself: aboutyourSelf,
        job_title: jobTitle,
      },
      where: '$resume_id = ?',
      whereArgs: [id],
    );
  }

  deletemaintbl(int id) async {
    final db = await database;
    await db.delete(
      '$table',
      where: '$resume_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, Object?>>> getmaintbl() async {
    final db = await database;
    // log('${db.close()}');
    // log('${db.rawQuery('SELECT * FROM $table')}');
    List<Map<String, Object?>> list = await db.rawQuery('SELECT * FROM $table');
    return list;
  }

  // project tbl

  // Project table CRUD operations
  addProject(
      int maintblId,
      String name,
      String detail,
      ) async {
    final db = await database;
    await db.insert(
      '$project_table',
      {
        maintbl_id: maintblId,
        pro_name: name,
        pro_detail: detail,
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateProject(
      int id,
      String name,
      String detail,
      ) async {
    final db = await database;

    await db.update(
      '$project_table',
      {
        pro_name: name,
        pro_detail: detail,
      },
      where: '$pro_id = ?',
      whereArgs: [id],
    );
  }

  deleteProject(int id) async {
    final db = await database;
    await db.delete(
      '$project_table',
      where: '$pro_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getProjects(int maintblId) async {
    final db = await database;
    return db.query(
      '$project_table',
      where: '$maintbl_id = ?',
      whereArgs: [maintblId],
    );
  }

// Experience table CRUD operations
  addExperience(
      int maintblId,
      String c_name,
      String join_date,
      String left_date,
      String jobRole,
      ) async {
    final db = await database;
    await db.insert(
      '$experience',
      {
        maintbl_id: maintblId,
        compny_name: c_name,
        join_time: join_date,
        left_time: left_date,
        job_role: jobRole,
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateExperience(
      int id,
      String c_name,
      String join_date,
      String left_date,
      String jobRole,
      ) async {
    final db = await database;

    await db.update(
      '$experience',
      {
        compny_name: c_name,
        join_time: join_date,
        left_time: left_date,
        job_role: jobRole,
      },
      where: '$exp_id = ?',
      whereArgs: [id],
    );
  }

  deleteExperience(int id) async {
    final db = await database;
    await db.delete(
      '$experience',
      where: '$exp_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getExperiences(int maintblId) async {
    final db = await database;
    return db.query(
      '$experience',
      where: '$maintbl_id = ?',
      whereArgs: [maintblId],
    );
  }

// Education table CRUD operations
  addEducation(
      int maintblId,
      String locationName,
      String edu_joinDate,
      String edu_leftDate,
      String eduType,
      String eduscore,
      ) async {
    final db = await database;
    await db.insert(
      '$education',
      {
        maintbl_id: maintblId,
        location_name: locationName,
        edu_join_date: edu_joinDate,
        edu_left_date: edu_leftDate,
        edu_type: eduType,
        edu_score: eduscore,
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateEducation(
      int id,
      String locationName,
      String edu_joinDate,
      String edu_leftDate,
      String eduType,
      String eduscore,
      ) async {
    final db = await database;

    await db.update(
      '$education',
      {
        location_name: locationName,
        edu_join_date: edu_joinDate,
        edu_left_date: edu_leftDate,
        edu_type: eduType,
        edu_score: eduscore,
      },
      where: '$edu_id = ?',
      whereArgs: [id],
    );
  }

  deleteEducation(int id) async {
    final db = await database;
    await db.delete(
      '$education',
      where: '$edu_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getEducations(int maintblId) async {
    final db = await database;
    return db.query(
      '$education',
      where: '$maintbl_id = ?',
      whereArgs: [maintblId],
    );
  }


  //techskills

  //tbl techskills

  // static final techskills = 'techskills';
  // static final ts_id = 'ts_id';
  // static final ts_name = 'ts_name';
  // static final sub_ts_name = 'sub_ts_name';
  //
  //
  addTechskills(
      int maintblId,
      String tsName,
      ) async {
    final db = await database;
    await db.insert(
      '$techskills',
      {
        maintbl_id: maintblId,
        ts_name: tsName,
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateTechskills(
      int id,
      String tsName,
      ) async {
    final db = await database;

    await db.update(
      '$techskills',
      {
        ts_name: tsName,
      },
      where: '$ts_id = ?',
      whereArgs: [id],
    );
  }

  deleteTechskills(int id) async {
    final db = await database;
    await db.delete(
      '$techskills',
      where: '$ts_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getTechskills(int maintblId) async {
    final db = await database;
    return db.query(
      '$techskills',
      where: '$maintbl_id = ?',
      whereArgs: [maintblId],
    );
  }

// Language table CRUD operations
  addLanguage(
      int maintblId,
      String lang,
      ) async {
    final db = await database;
    await db.insert(
      '$language',
      {
        maintbl_id: maintblId,
        lang_name: lang,
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateLanguage(
      int id,
      String lang,
      ) async {
    final db = await database;

    await db.update(
      '$language',
      {
        lang_name: lang,
      },
      where: '$lang_id = ?',
      whereArgs: [id],
    );
  }

  deleteLanguage(int id) async {
    final db = await database;
    await db.delete(
      '$language',
      where: '$lang_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getLanguages(int maintblId) async {
    final db = await database;
    return db.query(
      '$language',
      where: '$maintbl_id = ?',
      whereArgs: [maintblId],
    );
  }
}
