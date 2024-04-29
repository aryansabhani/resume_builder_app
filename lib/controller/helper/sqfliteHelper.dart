import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  SQLiteHelper._();

  static final _databaseName = "myDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'resume';
  static final resume_id = 'resume_id';
  static final fName = 'fname';
  static final lName = 'lName';
  static final aboutyourself = 'aboutyourself';
  static final job_title = 'job_title';
  static final number = 'number';
  static final email = 'email';
  static final address = 'address';
  static final city = 'city';
  static final state = 'state';
  static final create_time = 'create_time';

//tbl project
  static final project_table = 'project';
  static final pro_id = 'pro_id';
  static final pro_name = 'pro_name';
  static final pro_detail = 'pro_detail';

//tbl experience
  static final experience = 'experience';
  static final exp_id = 'exp_id';
  static final compny_name = 'compny_name';
  static final join_time = 'join_time';
  static final left_time = 'left_time';
  static final job_role = 'job_role';

  //tbl education
  static final education = 'education';
  static final edu_id = 'edu_id';
  static final location_name = 'location_name';
  static final edu_join_date = 'edu_join_date';
  static final edu_left_date = 'edu_left_date';
  static final edu_type = 'edu_type';
  static final edu_score = 'edu_score';

  //tbl techskills

  static final techskills = 'techskills';
  static final ts_id = 'ts_id';
  static final ts_name = 'ts_name';
  static final sub_ts_name = 'sub_ts_name';

  //tbl langeuage

  static final langeuage = 'langeuage';
  static final lang_id = 'lang_id';
  static final lang_name = 'lang_name';

  // make this a singleton class

  static final SQLiteHelper sqLiteHelper = SQLiteHelper._();

  // only have a single app-wide reference to the database
  static Database? _mydatabase;

  Future<Database> get database async {
    if (_mydatabase != null) return _mydatabase!;
    _mydatabase = await _initDatabase();
    return _mydatabase!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      db.execute('''
          CREATE TABLE $table (
            $resume_id INTEGER PRIMARY KEY,
            $fName TEXT,
            $lName TEXT,
            $number INTEGER,
            $email TEXT,
            $address TEXT,
            $city TEXT,
            $state TEXT,
            $aboutyourself TEXT,
            $job_title TEXT,
            $create_time DATE NOT NULL,
          )
          ''');
      db.execute('''
          CREATE TABLE $project_table (
            $pro_id INTEGER PRIMARY KEY,
            $pro_name TEXT,
            $pro_detail TEXT,
            $create_time DATE NOT NULL,
          )
          ''');
      db.execute('''
          CREATE TABLE $experience (
            $exp_id INTEGER PRIMARY KEY,
            $compny_name TEXT,
            $join_time DATE,
            $left_time DATE,
            $job_role TEXT,
            $create_time DATE NOT NULL,
          )
          ''');
      db.execute('''
          CREATE TABLE $education (
            $edu_id INTEGER PRIMARY KEY,
            $location_name TEXT,
            $edu_join_date DATE,
            $edu_left_date DATE,
            $edu_type TEXT,
            $edu_score TEXT,
            $create_time DATE NOT NULL,
          )
          ''');
      db.execute('''
          CREATE TABLE $techskills (
            $ts_id INTEGER PRIMARY KEY,
            $ts_name TEXT,
            $sub_ts_name TEXT,
            $create_time DATE NOT NULL,
          )
          ''');
      db.execute('''
          CREATE TABLE $langeuage (
            $lang_id INTEGER PRIMARY KEY,
            $lang_name TEXT,
            $create_time DATE NOT NULL,
          )
          ''');
    });
  }

  addmaintbl(
    String fname,
    String lname,
    int mobile_number,
    String email,
    String address,
    String cityname,
    String statename,
    String aboutyourSelf,
    String jobTitle,
  ) async {
    final db = await database;
    await db.insert(
      '$table',
      {
        fName: fname,
        lName: lname, // Corrected column name
        number: mobile_number,
        email: email,
        address: address,
        city: cityname,
        state: statename,
        aboutyourself: aboutyourSelf,
        job_title: jobTitle,
        create_time: DateTime.now().toString(),
      },
    );
  }

  updatemaintbl(
    int id,
    String fname,
    String lname,
    int mobile_number,
    String email,
    String address,
    String cityname,
    String statename,
    String aboutyourSelf,
    String jobTitle,
  ) async {
    final db = await database;
    await db.update(
      '$table',
      {
        fName: fname,
        lName: lname, // Corrected column name
        number: mobile_number,
        email: email,
        address: address,
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

  getmaintbl() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $table');
    return list;
  }

  // project tbl

  addProject(
    String name,
    String detail,
  ) async {
    final db = await database;
    await db.insert(
      '$project_table',
      {
        pro_name: name,
        pro_detail: detail, // Corrected column name
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
        pro_detail: detail, // Corrected column nam
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

  getProject() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $project_table');
    return list;
  }

  // experience

  addexperience(
    String c_name,
    DateTime join_date,
    DateTime left_date,
    String jobRole,
  ) async {
    final db = await database;
    await db.insert(
      '$experience',
      {
        compny_name: c_name,
        join_time: join_date,
        left_time: left_date,
        job_role: jobRole, // Corrected column name
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateexperience(
    int id,
    String c_name,
    DateTime join_date,
    DateTime left_date,
    String jobRole,
  ) async {
    final db = await database;

    await db.update(
      '$experience',
      {
        compny_name: c_name,
        join_time: join_date,
        left_time: left_date,
        job_role: jobRole, // // Corrected column nam
      },
      where: '$exp_id = ?',
      whereArgs: [id],
    );
  }

  deleteexperience(int id) async {
    final db = await database;
    await db.delete(
      '$experience',
      where: '$exp_id = ?',
      whereArgs: [id],
    );
  }

  getexperience() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $experience');
    return list;
  }

  //education

  addeducation(
    String locationName,
    DateTime edu_joinDate,
    DateTime edu_leftDate,
    String eduType,
    String eduscore,
  ) async {
    final db = await database;
    await db.insert(
      '$education',
      {
        location_name: locationName,
        edu_join_date: edu_joinDate,
        edu_left_date: edu_leftDate,
        edu_type: eduType, // Corrected column name
        edu_score: eduscore, // Corrected column name
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateEducation(
    int id,
    String locationName,
    DateTime edu_joinDate,
    DateTime edu_leftDate,
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
        edu_type: eduType, // Corrected column name
        edu_score: eduscore, // C// Corrected column nam
      },
      where: '$edu_id = ?',
      whereArgs: [id],
    );
  }

  deleteeducation(int id) async {
    final db = await database;
    await db.delete(
      '$education',
      where: '$edu_id = ?',
      whereArgs: [id],
    );
  }

  geteducation() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $education');
    return list;
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
    String tsName,
    String subts_name,
  ) async {
    final db = await database;
    await db.insert(
      '$techskills',
      {
        ts_name: tsName,
        sub_ts_name: subts_name,
        create_time: DateTime.now().toString(),
      },
    );
  }

  updateTechskills(
    int id,
    String tsName,
    String subts_name,
  ) async {
    final db = await database;

    await db.update(
      '$techskills',
      {
        ts_name: tsName,
        sub_ts_name: subts_name,
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

  getTechskills() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $techskills');
    return list;
  }

  //tbl langeuage
  //
  // static final langeuage = 'langeuage';
  // static final lang_id = 'lang_id';
  // s  tatic final lang_name = 'lang_name';

  addlangeuage(
    String lang,
  ) async {
    final db = await database;
    await db.insert(
      '$langeuage',
      {
        lang_name: lang,

        create_time: DateTime.now().toString(),
      },
    );
  }

  updatelangeuage(
    int id,
    String lang,
    String subts_name,
  ) async {
    final db = await database;

    await db.update(
      '$langeuage',
      {
        lang_name: lang,
      },
      where: '$ts_id = ?',
      whereArgs: [id],
    );
  }

  deletelangeuage(int id) async {
    final db = await database;
    await db.delete(
      '$langeuage',
      where: '$ts_id = ?',
      whereArgs: [id],
    );
  }

  getlangeuage() async {
    final db = await database;
    List<Map> list = await db.rawQuery('SELECT * FROM $langeuage');
    return list;
  }
}
