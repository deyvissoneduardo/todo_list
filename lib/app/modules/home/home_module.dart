import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/modules/todo_list_modules.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/home_page.dart';

class HomeModule extends TodoListModules {
  HomeModule()
      : super(
          bindings: [
            ChangeNotifierProvider(create: (context) => HomeController()),
          ],
          routers: {
            '/home': (context) => const HomePage(),
          },
        );
}
