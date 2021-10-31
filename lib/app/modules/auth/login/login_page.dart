import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';
import 'package:todo_list/app/core/widgets/todo_list_field.dart';
import 'package:todo_list/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _emailfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
            context: context,
            everCallback: (notifier, listenerInstance) {
              if (notifier is LoginController && notifier.hasInfo) {
                Messages.of(context).showInfo(notifier.infoMessage!);
              }
            },
            successCallback: (notifier, listenerInstance) {
              print('LOGIN SUCCESSFULL');
            });
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TodoListField(
                              label: 'E-mail',
                              controller: _controllerEmail,
                              focusNode: _emailfocusNode,
                              keyboardType: TextInputType.emailAddress,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatorio'),
                                Validatorless.email('E-mail invalido'),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            TodoListField(
                              label: 'Senha',
                              obscureText: true,
                              controller: _controllerPassword,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatorio'),
                                Validatorless.min(6, 'Minio 6 caracters'),
                              ]),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('Esqueceu sua senha?'),
                                  onPressed: () {
                                    if (_controllerEmail.text.isNotEmpty) {
                                      context
                                          .read<LoginController>()
                                          .forgotPassword(
                                              _controllerEmail.text);
                                    } else {
                                      _emailfocusNode.requestFocus();
                                      Messages.of(context)
                                          .showError('E-mail Obrigatorio');
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final formValid =
                                        _formkey.currentState?.validate() ??
                                            false;
                                    if (formValid) {
                                      context.read<LoginController>().login(
                                            _controllerEmail.text.trim(),
                                            _controllerPassword.text.trim(),
                                          );
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Login'),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              SignInButton(
                                Buttons.Google,
                                text: 'Continue com o Google',
                                padding: const EdgeInsets.all(5),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                onPressed: () => context
                                    .read<LoginController>()
                                    .googleLogin(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Não tem conta?'),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/register');
                                      },
                                      child: const Text('Cadastre-se'))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
