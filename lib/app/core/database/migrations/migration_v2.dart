import 'package:sqflite/sqlite_api.dart';
import 'package:to_do_list/app/core/database/migrations/migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('create table teste(id Integer)');
  }

  @override
  void update(Batch batch) {
    batch.execute('create table teste(id Integer)');
  }
}
