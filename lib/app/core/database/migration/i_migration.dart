import 'package:sqflite/sqflite.dart';

abstract class IMigration {
  void create(Batch batch);
  void upgrade(Batch batch);
}
