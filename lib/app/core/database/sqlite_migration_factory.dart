import 'package:todo_list/app/core/database/migration/i_migration.dart';
import 'package:todo_list/app/core/database/migration/migration_v1.dart';

class SqliteMigrationFactory {
  List<IMigration> getCreateMigration() => [
        MigrationV1(),
      ];
  List<IMigration> getUpgradeMigration(int version) => [];
}
