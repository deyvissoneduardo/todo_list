import 'package:path/path.dart';
import 'package:todo_list/app/core/modules/todo_list_modules.dart';
import 'package:todo_list/app/modules/home/home_page.dart';

class HomeModule extends TodoListModules {
  HomeModule()
      : super(
          // bindings: [],
          routers: {
            '/home': (context) => const HomePage(),
          },
        );
}
