import 'package:flutter/material.dart';
import 'package:todo_list/app/core/database/sql_adm_connection.dart';
import 'package:todo_list/app/modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteconnection = SqlAdmConnection();
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(sqliteconnection);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(sqliteconnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TODO App',
      home: SplashPage(),
    );
  }
}
