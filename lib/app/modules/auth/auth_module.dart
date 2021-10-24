import 'package:provider/provider.dart';
import 'package:todo_list/app/core/modules/todo_list_modules.dart';
import 'package:todo_list/app/modules/auth/login/login_controller.dart';
import 'package:todo_list/app/modules/auth/login/login_page.dart';

class AuthModule extends TodoListModules {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(create: (_) => LoginController()),
          ],
          routers: {
            '/login': (context) => const LoginPage(),
          },
        );
}
