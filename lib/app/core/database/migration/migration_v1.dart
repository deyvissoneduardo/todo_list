import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list/app/core/database/migration/i_migration.dart';

class MigrationV1 extends IMigration {
  @override
  void create(Batch bath) {
    bath.execute('''
      create table todo(
        id Integer primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datatime,
        finalizado integer
      )
    ''');
  }

  @override
  void upgrade(Batch bath) {}
}
