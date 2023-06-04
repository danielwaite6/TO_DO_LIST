import 'package:sqflite/sqlite_api.dart';
import 'package:to_do_list/app/core/database/migrations/migration.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('create table teste2(id Integer)');
  }

  @override
  void update(Batch batch) {
    batch.execute('create table teste2(id Integer)');
  }
}
