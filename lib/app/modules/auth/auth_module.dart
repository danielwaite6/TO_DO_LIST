import 'package:provider/provider.dart';
import 'package:to_do_list/app/core/modules/todo_list_module.dart';
import 'package:to_do_list/app/modules/auth/login/login_controller.dart';
import 'package:to_do_list/app/modules/auth/login/login_page.dart';
import 'package:to_do_list/app/modules/auth/register/register_controller.dart';
import 'package:to_do_list/app/modules/auth/register/register_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider<LoginController>(
              create: (context) => LoginController(),
            ),
            ChangeNotifierProvider<RegisterController>(
              create: (context) => RegisterController(
                userService: context.read(),
              ),
            ),
          ],
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
        );
}
