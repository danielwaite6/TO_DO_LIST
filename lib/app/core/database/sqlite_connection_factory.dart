import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:synchronized/synchronized.dart';
import 'package:to_do_list/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  // ignore: constant_identifier_names
  static const _VERSION = 1;
  // ignore: constant_identifier_names
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';
  Database? _db;
  final _lock = Lock();

  static SqliteConnectionFactory? _instance;

  SqliteConnectionFactory._(); // construtor privado

  factory SqliteConnectionFactory() {
    // ignore: prefer_conditional_assignment
    if (_instance == null) {
      _instance = SqliteConnectionFactory._();
    }
    return _instance!;
  }

  Future<Database> openConn() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        // ignore: prefer_conditional_assignment
        if (_db == null) {
          _db = await openDatabase(
            databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade,
          );
        }
      });
    }
    return _db!;
  }

  void closeConn() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.update(batch);
    }
    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
